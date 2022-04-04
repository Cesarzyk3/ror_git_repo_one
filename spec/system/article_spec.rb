require "rails_helper"

RSpec.describe "Article", type: :system do
    let!(:user)         { create(:user) }
    let!(:other_user)   { create(:user) }
    let!(:admin)        { create(:user, :admin) }
    let!(:article)      { create(:article, user: user) }
    let!(:comment)      { create(:comment, article: article, user: user) }

    context "show page" do
        it "has delete and edit button for an author" do
            sign_in user
            visit article_path(article)
            expect(page).to have_link('Edit')
            expect(page).to have_link('Delete')         
        end

        it "has delete button for an admin" do
            sign_in admin
            visit article_path(article)
            expect(page).to have_link('Delete')
        end

        it "doesn't have delete and edit button for other users" do
            sign_in other_user
            visit article_path(article)
            expect(page).not_to have_link('Edit')
            expect(page).not_to have_link('Destroy')
        end

        it "has comment form for logged user" do
            sign_in other_user
            visit article_path(article)
            expect(page).to have_button('Create Comment')
        end
        
        it "doesn't have comment form for not logged user" do
            visit article_path(article)
            expect(page).not_to have_button('Create Comment')
        end
    end

    context "index page" do
        it "shows delete and edit links for an author" do
            sign_in user
            visit articles_path
            expect(page).to have_link('Edit')
            expect(page).to have_link('Delete')
        end
        
        it "doesn't show edit and delete links for other users" do
            sign_in other_user
            visit articles_path
            expect(page).not_to have_link('Edit')
            expect(page).not_to have_link('Delete')
        end

        it "shows delete links for an admin" do
            sign_in admin
            visit articles_path
            expect(page).to have_link('Delete')
        end
    end
end