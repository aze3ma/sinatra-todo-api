# These settings establish the proper database Connection
# The environment variable DATABASE_URL should be in the following format:
# scheme://{user}:{password}@{host}:{port}/path
# This is automatically configured on Heroku, you only need to worry if you
# also want to run your app locally

configure :production, :development do
  set :show_exceptions, true
 
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://127.0.0.1/todo')
 
  ActiveRecord::Base.establish_connection(
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
 
  ActiveRecord::Base.class_eval do
    def self.reset_autoincrement(options={})
      options[:to] ||= 1
      case self.connection.adapter_name
        when 'MySQL'
          self.connection.execute "ALTER TABLE #{self.table_name} AUTO_INCREMENT=#{options[:to]}"
        when 'PostgreSQL'
          self.connection.execute "ALTER SEQUENCE #{self.table_name}_id_seq RESTART WITH #{options[:to]};"
        when 'SQLite'
          self.connection.execute "UPDATE sqlite_sequence SET seq=#{options[:to]} WHERE name='#{self.table_name}';"
        else
      end
    end
  end
end