class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_authorized?, only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def is_user_authorized?
    comment = Comment.find(params[:id])
    if comment.user_id != current_user.id
      is_user_admin?
    end
  end

  def is_user_admin?
    article = Article.find(params[:article_id])
    unless current_user.admin?
      redirect_to article_path(article)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
