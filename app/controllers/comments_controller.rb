class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_comment?, only: :destroy
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @comment = Comments.find(params[:id])
  end

  private

  def is_users_comment?
    comment = Comment.find(params[:id])
    comment.user_id == current_user
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
