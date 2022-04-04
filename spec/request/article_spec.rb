require "rails_helper"


RSpec.describe "Article", :type => :request do

    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:admin) { create(:user, :admin) }
    let!(:article) { create(:article, user: user) }

    context "creation" do
        it "works for logged user" do
            sign_in user
            get new_article_path
            expect(response).to render_template(:new)
        end
        
        it "doesn't work for not logged user" do
            get new_article_path
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context "editing" do
        it "works for the article creator" do
            sign_in user
            get edit_article_path(article)
            expect(status).to eq(200)
        end

        it "doesn't work for other users" do
            sign_in other_user
            get edit_article_path(article)
            expect(response).to redirect_to(root_path)
        end
    end

    context "destroying" do
        it "works for the article creator" do
            sign_in user
            expect{
                delete article_path(article)
                expect(response).to redirect_to(articles_path)
            }.to change{Article.count}.by(-1)
        end

        it "works for an admin" do
            sign_in admin
            expect{
                delete article_path(article)
                expect(response).to redirect_to(articles_path)
            }.to change{Article.count}.by(-1)
        end

        it "doesn't work for other users" do
            sign_in other_user
            expect{
                delete article_path(article)
                expect(response).to redirect_to(root_path)
            }.not_to change{Article.count}
        end
    end

    context "index" do
        it "works for everyone" do
            get articles_path
            expect(response).to render_template(:index)
        end
    end

    context "showing" do
        it "works for everyone" do
            get article_path(article)
            expect(response).to render_template(:show)
        end
    end
end