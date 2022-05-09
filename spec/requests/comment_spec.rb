require "rails_helper"

RSpec.describe "Comment", :type => :request do
    let!(:user)         { create(:user) }
    let!(:other_user)   { create(:user) }
    let!(:admin)        { create(:user, :admin) }
    let!(:article)      { create(:article, user: user) }
    let!(:comment)      { create(:comment, article: article, user: user)}
    
    context "creation" do
        it "works for logged user" do
            sign_in user
            expect{
                post article_comments_path(article), params: { comment: attributes_for(:comment) }
            }.to change{Comment.all.count}.by(1)
        end
        
        it "doesn't work for not logged user" do
            expect{
                post article_comments_path(article), params: { comment: attributes_for(:comment) }
                expect(status).to be(302)
            }.not_to change{Comment.all.count}
        end
    end
    
    context "deletion" do
        it "works for comment's author" do
            sign_in user
            expect{
                delete article_comment_path(article, comment)
            }.to change{Comment.count}.by(-1)
        end
        
        it "works for admin" do
            sign_in admin
            expect{
                delete article_comment_path(article, comment)
            }.to change{Comment.count}.by(-1)
        end
        
        it "doesn't work for other users" do
            sign_in other_user
            expect{
                delete article_comment_path(article, comment)
            }.not_to change{Comment.count}
        end

        it "doesn't work for not logged users" do
            expect{
                delete article_comment_path(article, comment)
            }.not_to change{Comment.count}
        end
    end
end