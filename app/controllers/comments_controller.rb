class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index ]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  skip_before_action :verify_authenticity_token, only: [:like, :dislike]
  
  
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  def show_comments
    @comments = Comment.where(user_id: params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.create(comment_params) 
    #logger.debug "Person attributes hash: #{params.inspect}"
    @contribution = Contribution.find(@comment.contribution_id)
    respond_to do |format|
      if @comment 
        format.html { redirect_to @contribution }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @contribution = Contribution.find(@comment.contribution_id)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @contribution , notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  # TODO: add logic to check if user is logged in before let make vote 
def like 
  @comment = Comment.find(params[:id])
  @comment.points += 1
  if @comment.save!
    current_user.voted_comments << @comment
    if current_user.save
      head :ok
    end
  else
    head :unprocessable_entity
  end
end
  
def dislike 
  @comment = Comment.find(params[:id])
  @comment.points -= 1
  
  if @comment.save
    current_user.voted_comments.delete(@comment)
    if current_user.save
      head :ok
    end
  else
    head :unprocessable_entity
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
