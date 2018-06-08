class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update]}


  def index
  	@posts = Post.all.order(created_at: :desc)
  	@post = Post.new
    @user = User.find(current_user.id)

  end

  def create
  	@post = Post.new(post_params)
    @post.user_id = current_user.id

  	if @post.save
      flash[:notice] = "Your post has been completed successfully!"
	    redirect_to post_path(@post.id)
    else
      render "posts/index"
    end
  end

  def show
    @new_post = Post.new
  	@post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update(post_params)
  	   flash[:notice] = "Your post has been updateed successfully!"
  	   redirect_to post_path(@post.id)
    else
       render "posts/edit"
    end
  end

  def destroy
  	post = Post.find(params[:id])
  	post.destroy
  	flash[:notice] = "Your post has been deleted."
  	redirect_to posts_path
  end

  def post_params
  	params.require(:post).permit(:title, :body, :user_id)
  end
end
