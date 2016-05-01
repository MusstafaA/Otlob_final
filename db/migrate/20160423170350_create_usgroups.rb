class CreateUsgroups < ActiveRecord::Migration
  def change
    create_table :usgroups do |t|
        t.references :user  ,  index: true,  foreign_key: true
        t.references :group ,  index: true, foreign_key: true
    end
  end
end
