class UsersController < ApplicationController
  before_action :is_user_admin?, only: [:index, :destroy]
  
  def show
    @user = User.find(params[:id])
    @articles = Article.all.where(user_id: params[:id])
  end

  def index
    @users = User.all.group(:id, :email).order(:id).select(:id, :email).left_joins(:articles, :comments).select("COUNT(articles.id) AS article_count").select("COUNT(comments.id) AS comment_count")
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def is_user_admin?
    if current_user && current_user.admin?
      return true
    end
    redirect_to root_path
  end
end
