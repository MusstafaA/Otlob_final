class CreateInvited < ActiveRecord::Migration
  def change
    create_table :inviteds do |t|
    	t.references :user  ,  index: true,  foreign_key: true
        t.references :order ,  index: true, foreign_key: true
    end
  end
end
