class User < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :authentication_token, length: 30, unique: true

      t.timestamps null: false
    end

    def down
      drop_table :users
    end
  end
end
