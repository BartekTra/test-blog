class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :destroy ]
  before_action :find_post, only: [ :like, :unlike ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end


  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(Post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  def like
    @post = Post.find(params[:id])
    @post.likes.create(user: current_user)
    redirect_to root_path
  end

  def unlike
    @post = Post.find(params[:id])
    @post.likes.where(user: current_user).destroy_all
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image, :user_id)
  end
  def find_post
    @post = Post.find(params[:id])
  end
end
