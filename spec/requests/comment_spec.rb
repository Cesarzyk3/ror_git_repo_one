require "rails_helper"

RSpec.describe "Comment", :type => :request do
    context "creation" do
        it "works for logged user" do
            user = create(:user)
            sign_in user
            article = create(:article, user_id: user.id)
            expect{
                post article_comments_path(article.id), params: { comment: attributes_for(:comment) }
            }.to change{Comment.all.count}.by(1)
        end
        
        it "doesn't work for not logged user" do
            user = create(:user)
            article = create(:article, user_id: user.id)
            expect{
                post article_comments_path(article.id), params: { comment: attributes_for(:comment) }
                expect(status).to be(302)
            }.not_to change{Comment.all.count}
        end
    end
    
    context "deletion" do
        it "works for comment's author" do
            user = create(:user)
            sign_in user
            article = create(:article, user_id: user.id)
            comment = create(:comment, article_id: article.id, user_id: user.id)
            expect{
                delete article_comment_path ({ article_id: article.id, id: comment.id })
            }.to change{Comment.count}.by(-1)
        end
        
        it "works for admin" do
            user = create(:user)
            admin = create(:user, :admin)
            sign_in admin
            article = create(:article, user_id: user.id)
            comment = create(:comment, article_id: article.id, user_id: user.id)
            expect{
                delete article_comment_path({ article_id: article.id, id: comment.id })
            }.to change{Comment.count}.by(-1)
        end
        
        it "doesn't work for other users" do
            user = create(:user)
            other_user = create(:user)
            article = create(:article, user_id: user.id)
            comment = create(:comment, article_id: article.id, user_id: user.id)
            expect{
                delete article_comment_path({ article_id: article.id, id: comment.id })
            }.not_to change{Comment.count}
        end

        it "doesn't work for not logged users" do
            user = create(:user)
            article = create(:article, user_id: user.id)
            comment = create(:comment, user_id: user.id, article_id: article.id)
            expect{
                delete article_comment_path({ article_id: article.id, id: comment.id })
            }.not_to change{Comment.count}
        end
    end
end