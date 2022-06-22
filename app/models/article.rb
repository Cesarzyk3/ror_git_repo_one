class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  scope :feed, ->(following) { where user_id: following }

  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :body, presence: true, length: {minimum: 3, maximum: 500}
end
