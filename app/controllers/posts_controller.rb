class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_post, only: [:show, :update, :destroy]

  
  def index
    if (params[:user_id])
        @user = User.find(params[:user_id])
        @post = @user.posts
        render json: @post, status: :created, location: post_url(@post) 
    else
        #render json:Post.all,include: [:user]
        render json:Post.all
    end
  end

  def show
   render json: @post
  end
  
  def create
    if (params[:user_id] && params[:movie_id])
        @post = Post.new
        @post.title = params[:title]
        @post.user_id = params[:user_id]
        @post.movie_id = params[:movie_id]
        if @post.save
            render json: @post, status: :created, location: post_url(@post)
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    else
        render json:{error:"cannot create post without user id or movie id"},status:404   
    end
  end

 
  def update
    if (params[:user_id])
        @user = User.find(params[:user_id])
        @post = @user.posts.find(params[:id])
        if @post.update(title:params[:title])
            @post.update(title: params[:title])
            render json: @post
        end
    else
        render json:{error:"cannot update post without user id"},status:404
    end
  end

  def edit
      @post = Post.find(params[:id])
  end

  def destroy
     if (params[:user_id])
        @user = User.find(params[:user_id])
        @post = @user.posts.find(params[:id])
        @post.destroy
    else
        render json:{error:"cannot delete post without user id"},status:404
    end
  end

  private
  def set_post
   @post = Post.find(params[:id])
  end


  def post_params
      params.require(:user)  
      params.require(:post).permit(:title)
  end

end