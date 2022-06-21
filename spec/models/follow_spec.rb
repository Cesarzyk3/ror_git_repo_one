require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  
  it "doesn't allow following someone twice" do
    follow = Follow.new(follower: user, followed: other_user)
    follow.save
    expect(follow).to be_valid
    other_follow = Follow.new(follower: user, followed: other_user)
    other_follow.save
    expect(other_follow).not_to be_valid
  end

  it "doesn't allow to follow yourself" do
    follow = Follow.new(follower: user, followed: user)
    follow.save
    expect(follow).not_to be_valid
  end
end
