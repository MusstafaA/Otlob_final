class Group < ActiveRecord::Base
  belongs_to :user

  
  has_many :usgroups, :dependent => :destroy  
  has_many :users, :through => :usgroups

  validates :name, presence: true,
				length: {minimum:3}

 
end
