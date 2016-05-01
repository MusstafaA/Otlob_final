class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,

         :omniauthable, :omniauth_providers => [:facebook , :google_oauth2]


    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name
        user.avatar = auth.info.image
        user.password = Devise.friendly_token[0,20]
      end
    end

   mount_uploader :avatar, AvatarUploader
   

   validates :name, presence: true,length: { minimum: 3 }  ,uniqueness: true

   validates :avatar, presence: true

   validates :email, uniqueness: true


  has_many :orders , :dependent => :destroy  

  has_many :groups , :dependent => :destroy 

  has_many :inviteds, :dependent =>  :destroy  
  has_many :orders, :through => :inviteds
  
  has_many :ordetails, :dependent =>  :destroy  
  has_many :orders, :through => :ordetails
  
  
  has_many :usgroups, :dependent =>  :destroy  
  has_many :groups, :through => :usgroups

 
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
   

  has_many :notifications, foreign_key: :recipient_id 

end
