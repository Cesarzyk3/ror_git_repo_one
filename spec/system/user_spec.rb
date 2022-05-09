require 'rails_helper'

RSpec.describe "User", type: :system do
    let!(:user)             { create(:user) }
    let!(:other_user)       { create(:user) }
    let!(:admin)            { create(:user, :admin) }
    let!(:article)          { create(:article, user: user) }
    let!(:other_article)    { create(:article, user: user) }

    describe "show page" do
        it "has all user's posts" do
            visit user_path(user)
            # expecting twice as much posts, because every post
            # is doubled in a modal
            expect(page).to have_text('Some test title', count: 4)
        end

        #        context "doesn't have add to friends button" do
        #            it "for not logged users" do
        #
        #            end
        #
        #            it "for users that are already friends" do
        #
        #            end
        #        end
        #
        #        it "has add to friends button" do
        #
        #        end
        #
    end
    
    describe "index page" do

        it "has all users listed" do
           sign_in admin
           visit users_path
           expect(page).to have_text("person", count: 3)
        end

        it "has delete buttons for an admin" do
            sign_in admin
            visit users_path
            expect(page).to have_link("Delete", count: 3)
        end

        # it "doesn't have delete buttons for other users" do
        # 
        # end
    end
end