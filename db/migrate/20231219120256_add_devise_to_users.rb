# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    change_table :users do |t|
      t.string :email, null: false, default: "" unless column_exists?(:users, :email)

      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at
    end

    add_index :users, :email, unique: true, where: "email IS NOT NULL" unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true, where: "reset_password_token IS NOT NULL"
  end

  def self.down
    remove_index :users, :email if index_exists?(:users, :email)
    remove_index :users, :reset_password_token

    change_table :users do |t|
      t.remove :email if column_exists?(:users, :email)
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
    end
  end
end
