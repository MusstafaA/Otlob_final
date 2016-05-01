class Order < ActiveRecord::Base
  belongs_to :user

  has_many :ordetails,  :dependent => :destroy   
  has_many :users, :through => :ordetails  
  
  has_many :inviteds,  :dependent => :destroy  
  has_many :users, :through => :inviteds

  mount_uploader :avatar, AvatarUploader

 
 validates :res_name, presence: true ,format:{with: /\A(\w+\s?)*\s*\z/, message: ' Restaurant name can only have letters and numbers only one space between words' }


 

end
