class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]


  before_action :get_user, only: [:like, :dislike, :create, :new, :destroy, :update]
  skip_before_action :verify_authenticity_token



  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show

  end

  def show_comments
    @comments = Comment.where(user_id: params[:id]).order(created_at: :desc)
    respond_to do |format|
      format.html {render :show_comments }
      format.json {render json: @comments}
    end
  end


  def show_upvoted_comments
    user = User.find(params[:id])
    @comments = user.voted_comments.order(created_at: :desc)
    respond_to do |format|
      if @comments
        format.html { render "show_comments" }
        format.json { render json: @comments }
      end
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    respond_to do |format|
      format.json {render json: @comment}
    end
  end
  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    if @format == "json"
      request.format = :json
    end
    if @user.nil?
      respond_to do |format|
        format.html { redirect_to :contributions, notice: 'You need to be logged in to create a comment' }
        format.json {
          render json: {
            error: "user not found",
            status: :unauthorized
          }, status: :unauthorized
        }
      end
    else
      @comment = @user.comments.create(comment_params)
      @contribution = Contribution.find(@comment.contribution_id)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @contribution }
          format.json { render json: @comment, status: :created }
        else
          format.html { render :new , alert: @comment.errors.full_messages.join(', ') }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

    begin
      respond_to do |format|
        if @user.nil?
          format.html{ redirect_to :contributions, alert: 'You need to be logged in to update a contribution' }
          format.json { render json:{
            error: "user unauthorized",
            status: :unauthorized
          }, status: :unauthorized
          }
        elsif @comment.user_id != @user.id.to_s
          format.html { redirect_to :contributions, alert: 'You are not authorized to update this contribution' }
          format.json { render json: {
            error: "You need to be the creator of the comment to update it",
            status: :unauthorized
          }, status: :unauthorized
          }
        else
          puts comment_params
          puts @comment.inspect
          @comment.update(comment_params)
          format.html { redirect_to :contributions, notice: 'Comment was successfully updated.' }
          format.json { render json: @comment, status: :ok}
        end

      end
    rescue => exception
      puts exception.message
      format.html { redirect_to :contributions, alert: exception.message }
      format.json { render json: { error: exception.message, status: :unprocessable_entity }, status: :unprocessable_entity }

    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    respond_to do |format|
      if @comment.nil?
        format.html { redirect_to :contributions, notice: 'Comment not found' }
        format.json {
          render json:{
            error: "Comment not found",
          }, status: :not_found
        }
      elsif @user.nil? || @user.id.to_s != @comment.user_id.to_s
        @contribution = Contribution.find(@comment.contribution_id)
        format.html { redirect_to @contribution, notice: 'You need to be logged in to destroy a comment'}
        format.json {
          render json: {
            error: "user not found",
            status: :unauthorized
          }, status: :unauthorized
        }
      else
        @contribution = Contribution.find(@comment.contribution_id)
        @comment.destroy
        format.html { redirect_to @contribution , notice: 'Comment was successfully destroyed.' }
        format.json { render json:
                               {
                                 msg: "Comment deleted",
                                 comment: @comment
                               }, status: :ok
        }
      end
    end
  end


  # TODO: add logic to check if user is logged in before let make vote
  def like
    @comment = Comment.find(params[:id])
    begin
      if @user.nil? || !@user.comments.find_by_id(params[:id]).nil?
        render json:{
          error: "You're not allowed to vote this comment ",
          status: :unauthorized
        }, status: :unauthorized
      elsif @user.voted_comments.include?(@comment)
        render json:{
          error: "user already voted",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      elsif @comment.nil?
        render json:{
          error: "contribution not found",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      else
        puts @user.comments
        @comment.points += 1
        if @comment.save
          @user.voted_comments << @comment
          if @user.save
            render json:{
              message: "user voted",
              status: :ok
            }, status: :ok
          end
        else
          render json:{
            error: "error saving vote",
            status: :unprocessable_entity
          }, status: :unprocessable_entity
        end
      end
    rescue => e
      render json:{
        error: e.message,
        status: :unprocessable_entity
      }, status: :unprocessable_entity
    end
  end

  def dislike
    @comment = Comment.find(params[:id])
    begin
      if @user.nil?
        render json:{
          error: "user not authorized",
          status: :unauthorized
        }, status: :unauthorized

      elsif !@user.voted_comments.include?(@comment)
        render json:{
          error: "user not voted yet",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      elsif @comment.nil?
        render json:{
          error: "contribution not found",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      else
        @comment.points -= 1

        if @comment.save
          @user.voted_comments.delete(@comment)
          if @user.save
            render json:{
              message: "user unvoted",
              status: :ok
            }, status: :ok
          end
        else
          render json:{
            error: "user not unvoted",
            status: :unprocessable_entity
          }, status: :unprocessable_entity
        end
      end
    rescue => e
      render json:{
        error: e.message,
        status: :unprocessable_entity
      }, status: :unprocessable_entity
    end
  end


  def reply
    @comment = Comment.find(params[:id])
    @comment_new = Comment.new
  end

  private
  #Checks if the user trying to modify a comment is the one that created that comment

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to comments_path, notice: "Not Authorized To Modify This Comment" if @comment.nil?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:text, :contribution_id, :replayedComment_id)
  end

end
