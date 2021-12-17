class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    change_table :people do |t|
      t.change :first_name, :string
      t.change :last_name, :string
      t.change :description, :text
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end