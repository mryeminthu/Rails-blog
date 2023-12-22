# frozen_string_literal: true

class AddUniqueConstraintToUsersEmail < ActiveRecord::Migration[7.1]
  def change
    execute <<-SQL
      DELETE FROM users
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM users
        GROUP BY email HAVING COUNT(email) > 1
      );
    SQL

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
  end
end
