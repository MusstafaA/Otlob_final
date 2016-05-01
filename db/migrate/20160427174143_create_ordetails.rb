class CreateOrdetails < ActiveRecord::Migration
  def change
    create_table :ordetails do |t|
      t.string  :item
      t.float   :price
      t.integer :amount
      t.text    :comment
      t.references :user , index: true, foreign_key: true
      t.references :order , index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
