class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_post, only: [:show, :update, :destroy]

  
  def index
   @posts = Post.all
   render json: @posts,include:[:comments ,:user]
  end

  def movie_post
    if (params[:id] && params[:movie_id])
      @user = User.find(params[:id])
      @movie = Movie.find(params[:movie_id])
      post = Post.where(postable:@movie, user:@user).first
      render json:post, include: [:user, :comments]
    else
      raise Exception.new "Post does not exist for this user and movie"
    end
  end

  def book_post
    if (params[:id] && params[:book_id])
      @user = User.find(params[:id])
      @book = Book.find(params[:book_id])
      post = Post.where(postable:@book, user:@user).first
      render json:post, include: [:user, :comments]
    else
      raise Exception.new "Post does not exist for this user and book"
    end
  end

  def user_post
    if (params[:id])
      @user = User.find(params[:id])
      @post = Post.where(user:@user)
      render json:@post, include: [:user, :comments]
    else
      raise Exception.new "Post does not exist for this user"
    end
  end

  def show
   render json: @post
  end

  def create
      @main_post  = main_post
      if(@main_post && params[:user_id])
        @post = @main_post.posts.new post_params
        if @post.save
           render json: @post, status: :created, location: post_url(@post)
        else
           render json: @post.errors
        end
      else
       render json:{error:"cannot create post without user id and movie/book id"},status:404   
      end
   end

  

  def update
    if @post.update(content:params[:content])
        render json: @post
    else 
        render json: @post.errors
    end
  end

  def edit
      @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.destroy
        head:ok
     else
        render json: @post.errors
    end
  end

  private
  def set_post
   @post = Post.find(params[:id]) rescue nil
  end

   private
   def main_post
      return Movie.find params[:movie_id] if params[:movie_id]
      Book.find params[:book_id] if params[:book_id]
   end

  def post_params
      params.require(:post).permit(:content).merge(user_id: params[:user_id])
   end

end