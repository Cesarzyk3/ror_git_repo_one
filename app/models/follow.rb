class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'


  validates_uniqueness_of :followed, scope: :follower
  validate :following_someone_else

  private

  def following_someone_else
    if follower == followed
      errors.add(:followed, "Can't follow yourself!")
      return false
    else
      return true
    end
  end
end
