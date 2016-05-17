class User < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :email
      t.string  :authentication_token, length: 30
      t.index   :authentication_token, unique: true

      t.timestamps null: false
    end

  end

  def down
    drop_table :users
  end
end
