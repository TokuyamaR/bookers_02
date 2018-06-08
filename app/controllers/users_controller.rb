class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def show
  	@user = User.find(params[:id])
  	@posts = Post.where(user_id: @user.id)
  	@post = Post.new
  end

  def index
    @user = User.find(params[:id])
  	@users = User.all.order(created_at: :asc)
    @post = Post.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have edited your profile successfully!"

      redirect_to user_path(current_user.id)
    else
      render "users/edit"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :image_name, :introduction)
  end

end
