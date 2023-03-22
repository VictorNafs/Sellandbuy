class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :user
      t.belongs_to :item
      t.belongs_to :seller, class_name: 'User'
      t.belongs_to :buyer, class_name: 'User'
    
      t.timestamps
    end
  end
end
