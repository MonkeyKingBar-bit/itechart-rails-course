class RenameTransactionsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :transactions, :money_transactions
  end
end
