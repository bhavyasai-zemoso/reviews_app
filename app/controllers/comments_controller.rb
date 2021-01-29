class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_comment, only: [:show, :update, :destroy]

  #def index
  # @comments = Comment.all
  # render json: @comments
  #end
  def index
    if (params[:post_id])
      if(params[:movie_id])
        @user = User.find(params[:user_id])
        @movie = Movie.find(params[:movie_id])
        @post = Post.where(postable:@movie, user:@user).first
      elsif(params[:book_id])
        @user = User.find(params[:user_id])
        @book = Book.find(params[:book_id])
        @post = Post.where(postable:@book, user:@user).first
      else
        @post = Post.find(params[:post_id])
      end
      @comment = Comment.where(post:@post)
      render json:@comment, include: [:post]
    else
      raise Exception.new "Post does not exist"
    end
end

  def show
   render json: @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:text))
    render json: @comment
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments
   if @comment.update(comment_params)
    render json: @comment
   else
    render json: @comment.errors, status: :unprocessable_entity
   end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
        head:ok
    else
        render json: @comment.errors
    end
  end

  private
  def set_comment
   @comment = Comment.find(params[:id]) rescue nil
  end

  def comment_params
  params.require(:comment).permit(:text)
  end
end
