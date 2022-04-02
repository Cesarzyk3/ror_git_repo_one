require "rails_helper"


RSpec.describe "Article", :type => :request do

    context "creation" do
        it "works for logged user" do
            user = create(:user)
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
            user = create(:user)
            article = create(:article, user_id: user.id)
            sign_in user
            get edit_article_path(article.id)
            expect(status).to eq(200)
        end

        it "doesn't work for other users" do
            user = create(:user)
            other_user = create(:user)
            article = create(:article, user_id: user.id)
            sign_in other_user
            get edit_article_path(article.id)
            expect(response).to redirect_to(root_path)
        end
    end

    context "destroying" do
        it "works for the article creator" do
            user = create(:user)
            article = create(:article, user_id: user.id)
            sign_in user
            expect{
                delete "/articles/#{article.id}"
                expect(response).to redirect_to(articles_path)
            }.to change{Article.all.count}.by(-1)
        end

        it "works for an admin" do
            #admin role to be added in the future
            user = create(:user)
            article = create(:article, user_id: user.id)
            admin = create(:user, :admin)
            sign_in admin
            expect{
                delete "/articles/#{article.id}"
                expect(response).to redirect_to(articles_path)
            }.to change{Article.all.count}.by(-1)
        end

        it "doesn't work for other users" do
            user = create(:user)
            other_user = create(:user)
            article = create(:article, user_id: user.id)
            sign_in other_user
            expect{
                delete "/articles/#{article.id}"
                expect(response).to redirect_to(root_path)
            }.not_to change{Article.all.count}
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
            article = create(:article)
            get article_path(article.id)
            expect(response).to render_template(:show)
        end
    end
end