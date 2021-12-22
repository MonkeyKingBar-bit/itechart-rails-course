class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :transaction_type
      t.references :user, foreign_key: true
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
