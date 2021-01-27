class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_post, only: [:show, :update, :destroy]

  
  def index
    if (params[:user_id] && params[:movie_id])
        @post=Post.where(user_id: params[:user_id], movie_id: params[:movie_id]).all
        render json: @post, status: :created, location: post_url(@post) 
    elsif (params[:user_id])
        @post=Post.where(user_id: params[:user_id]).all
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

   private
   def main_post
      return Movie.find params[:movie_id] if params[:movie_id]
      Book.find params[:book_id] if params[:book_id]
   end

  def update
        @main_post  = main_post
      if(@main_post && params[:user_id])
        @post = @main_post.post
        if @post.update(content:params[:content])
            @post.update(content: params[:content])
            render json: @post
        end
    else
        render json:{error:"cannot update post without user id or movie id"},status:404
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
   @post = Post.find(params[:id])
  end

  def post_params
      params.require(:post).permit(:content).merge(user_id: params[:user_id])
   end

end