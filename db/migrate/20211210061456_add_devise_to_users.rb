# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :users do |t|
      t.change :email, :string, null: false, default: ""
      t.change :encrypted_password, :string, null: false, default: ""
      t.change :reset_password_token, :string
      t.change :reset_password_sent_at, :datetime
      t.change :remember_created_at, :datetime
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
