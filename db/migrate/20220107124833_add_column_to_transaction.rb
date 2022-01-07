class AddColumnToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :money_transactions, :important, :boolean
  end
end
