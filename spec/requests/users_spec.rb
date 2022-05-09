require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  describe "show page" do
    it "returns http success" do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "index page" do
    it "redirects not logged users" do
      get users_path
      expect(response).to have_http_status(:redirect)
    end

    it "redirects logged in non admin users" do
      sign_in user
      get users_path
      expect(response).to have_http_status(:redirect)
    end

    it "returns http success for admin" do
      sign_in admin
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

end
