class Lists < ActiveRecord::Migration[5.1]
  def up
    create_table :lists do |t|
      t.string :name
      t.string :color

      t.timestamp
    end
  end

  def down
    drop_table :lists
  end
end
