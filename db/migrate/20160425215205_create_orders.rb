class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :for
      t.string :res_name
      t.string :avatar
      t.string :status
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
