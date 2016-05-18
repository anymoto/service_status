class CreateStatusMessages < ActiveRecord::Migration
  def up
    create_table :status_messages do |t|
      t.integer :status
      t.string :message, default: 'No description'

      t.timestamps null: false
    end

  end

  def down
    drop_table :status_messages
  end
end
