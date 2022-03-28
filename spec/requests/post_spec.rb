require "rails_helper"

RSpec.describe "Post", :type => :request do
    context "creation" do
        it "works for logged user" do
            user = User.create(email: "foo@bar.com", password: "password")
            sign_in user
            get "/articles/new"
            expect(response).to render_template(:new)
        end
        
        it "doesn't work for not logged user" do
            get "/articles/new"
            expect(response).to redirect_to("/users/sign_in")
        end
    end

    context "editing" do
        it "works only for the article creator" do

        end

        it "doesn't work for other users" do
        
        end
    end

    context "destroying" do
        it "works for the article creator" do

        end

        it "works for an admin" do

        end

        it "doesn't work for other users" do

        end
    end

    context "index" do
        it "works for everyone" do

        end
    end

    context "showing" do
        it "works for everyone" do

        end
    end
end