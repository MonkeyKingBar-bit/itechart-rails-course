# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
