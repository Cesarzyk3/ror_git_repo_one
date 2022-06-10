class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # Following mechanism
  
  # Followed by user
  has_many :follows_to, foreign_key: 'follower_id', class_name: 'Follow'
  has_many :following, through: :follows_to, source: :followed

  # Users' followers
  has_many :follows_from, foreign_key: 'followed_id', class_name: 'Follow'
  has_many :followers, through: :follows_from, source: :follower

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[ user admin ]

  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end

end
