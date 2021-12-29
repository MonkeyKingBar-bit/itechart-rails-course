class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :count
      t.integer :person_category_id
      t.integer :note_id

      t.timestamps
    end
  end
end
