require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let!(:user)         { create(:user) }
  let!(:other_user)   { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:follow)       { create(:follow, follower: user, followed: another_user) }
  
  describe "creation" do
    it "works for signed in user" do
      sign_in user
      expect{
        post follows_path, params: { follow: { followed_id: other_user.id } }
      }.to change{Follow.all.count}.by(1)
    end

    it "doesn't work for not signed in users" do
      expect{
        post follows_path, params: { follow: { followed_id: other_user.id } }
    }.not_to change{Follow.all.count}
    end
  end

  describe "deletion" do
    it "works for follower" do
      sign_in user
      expect{
        delete follow_path(another_user)
      }.to change{Follow.all.count}.by(-1)
    end

    it "doesn't work for not signed in users" do
      expect{
        delete follow_path(another_user)
      }.not_to change{Follow.all.count}
    end

    it "doesn't work for other users" do
      sign_in other_user
      expect{
        delete follow_path(another_user)
      }.not_to change{Follow.all.count}
    end
  end

end
