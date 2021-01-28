class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_post, only: [:show, :update, :destroy]

  
  def index
    parent_post  = main_post
      if(parent_post && params[:user_id])
        @post=Post.where(user_id: params[:user_id], postable_id: parent_post.id).all
        render json: @post,include:[:comments]
      elsif (params[:user_id])
        @post=Post.where(user_id: params[:user_id]).all
        render json: @post,include:[:comments]
    else
        render json:Post.all,include:[:comments]
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