class AddCityToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :city, :string
  end
end
