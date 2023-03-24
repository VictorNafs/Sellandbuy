class AddStreetAndZipCodeToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :street, :string
    add_column :transactions, :zip_code, :string
  end
end
