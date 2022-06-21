require 'rails_helper'

RSpec.describe "User", type: :system do
    let!(:user)             { create(:user) }
    let!(:other_user)       { create(:user) }
    let!(:another_user)     { create(:user) }
    let!(:admin)            { create(:user, :admin) }
    let!(:article)          { create(:article, user: user) }
    let!(:other_article)    { create(:article, user: user) }
    let!(:follow)           { create(:follow, follower: user, followed: another_user) }

    describe "show page" do
        it "has all user's posts" do
            visit user_path(user)
            # expecting twice as much posts, because every post
            # is doubled in a modal
            expect(page).to have_text('Some test title', count: 4)
        end

        context "doesn't follow button" do
            it "for not logged users" do
                visit user_path(user)
                expect(page).not_to have_button('Follow')
            end

            it "for already followed users" do
                sign_in user
                visit user_path(another_user)
                expect(page).to have_link('Unfollow')
            end
        end

        it "has follow button" do
            sign_in user
            visit user_path(other_user)
            expect(page).to have_button("Follow")
        end

    end
    
    describe "index page" do

        it "has all users listed" do
           sign_in admin
           visit users_path
           expect(page).to have_text("person", count: 4)
        end

        it "has delete buttons for an admin" do
            sign_in admin
            visit users_path
            expect(page).to have_link("Delete", count: 4)
        end
    end
end