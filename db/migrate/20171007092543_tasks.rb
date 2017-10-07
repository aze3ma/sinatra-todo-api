class Tasks < ActiveRecord::Migration[5.1]
  def up
    create_table :tasks do |t|
      t.string :name
      t.references :list, foreign_key: true

      t.timestamp
    end
  end

  def down
    drop_table :tasks
  end
end
