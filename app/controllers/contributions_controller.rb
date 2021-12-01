class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :destroy, :like, :dislike, :update]

  # special actions on this actions because they are called by js and doesnt work fine, i dont know why
  before_action :get_user, only: [:like, :dislike, :create, :new, :destroy, :update]

  skip_before_action :verify_authenticity_token 

  # GET /contributions
  # GET /contributions.json
  def index
    @contributions = Contribution.where(contribution_type: "url").order(points: :desc)
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @contribution, status: @contribution.nil? ? :not_found : :ok}
    end
  end

  # GET /contributions/show_news
  def show_news
    @contributions = Contribution.all.order(created_at: :desc)
    respond_to do |format|
      format.html { render :index}
      format.json { render json: @contributions }
    end
  end

  def show_user
    @contributions = Contribution.where(user_id: params[:id])
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @contributions}
    end
  end

  def show_ask
    @contributions = Contribution.where(contribution_type: "ask").order(points: :desc)
    render :index
  end
  # GET /contributions/new
  def new
    respond_to do |format|
      puts @user.inspect
      if @user.nil?
        format.html {redirect_to contributions_path, notice: 'You need to be logged in to create a contribution'}
        format.json {render json: {error: "user unauthorized", status: :unauthorized}, status: :unauthorized}
      else
        @contribution = Contribution.new
        format.html {render :new}
        format.json {render json: @contribution}
      end
    end
  end

  # POST /contributions
  # POST /contributions.json
  def create
    begin
      if @format == "json" 
        request.format = :json
      end
      if @user.nil?
        respond_to do |format|
          format.html { redirect_to contributions_url, notice: 'You need to be logged in to create a contribution'}
          format.json {
            render json: {
              error: "user not found",
              status: :unauthorized
            }, status: :unauthorized
          }
          return;
        end
      else
        @contribution = ContributionServices::CreateContributionService.new(contribution_params).call
        if @contribution.url.blank?
          @user.contributions << @contribution
          respond_to do |format|
            if @user.save
              format.html { redirect_to show_news_contributions_url }
              format.json { render :json => @contribution, status: :created}
            else
              format.html { redirect_to new_contribution_contributions_path(@user.token), alert: @contribution.errors.full_messages.join(', ') }
              format.json { render json: @contribution.errors, status: :unprocessable_entity }
            end
          end
        else
          @contribution_existing = Contribution.find_by_url(@contribution.url)
          respond_to do |format|
            if @contribution_existing.present?
              format.html { redirect_to @contribution_existing, alert: @contribution_existing.errors.full_messages.join(', ') }
              format.json { render json: @contribution_existing, status: :created}

            else
              if !@contribution.text.blank?
                @contribution_new = Contribution.new
                @contribution_new.url = @contribution.url
                @contribution_new.title = @contribution.title
                @contribution_new.user_id = @contribution.user_id
                @contribution_new.created_at = @contribution.created_at
                @contribution_new.updated_at = @contribution.updated_at
                @contribution_new.points = @contribution.points
                @contribution_new.contribution_type = @contribution.contribution_type

                @user.contributions << @contribution_new


                @user.comments.create({ :text => @contribution.text, :contribution_id => @contribution_new.id, :replayedComment_id => nil})
                @comment = @contribution_new.comments.create({ :text => @contribution.text, :contribution_id => @contribution_new.id, :replayedComment_id => nil})
                if @user.save
                  format.html { redirect_to @contribution_new }
                  format.json { render json: @contribution_new, status: :created}
                else
                  format.html { redirect_to new_contribution_contributions_path(@user.token), alert: @contribution_new.errors.full_messages.join(', ') }
                  format.json { render json: @contribution_new.errors, status: :unprocessable_entity }
                end
              else
                @user.contributions << @contribution
                if @user.save
                  format.html { redirect_to show_news_contributions_url }
                  format.json { render json: @contribution, status: :created }
                else
                  format.html { redirect_to new_contribution_contributions_path(@user.token), alert: @contribution.errors.full_messages.join(', ') }
                  format.json { render json: @contribution.errors, status: :unprocessable_entity }
                end
              end
            end
          end
        end
      end
    rescue => e
      respond_to do |format|
        if @user.nil?
          format.html { redirect_to contribution_path, alert: e.message }
        else
          format.html { redirect_to new_contribution_contributions_path(@user.token), alert: "something went wrong"}
        end
        format.json { render json: e.message, status: :unprocessable_entity }
      end
    end
  end

  
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
        elsif @contribution.user_id != @user.id.to_s
          format.html { redirect_to :contributions, alert: 'You are not authorized to update this contribution' }
          format.json { render json: {
            error: "You need to be the creator of the contribution to update it",
            status: :unauthorized
          }, status: :unauthorized
        }
        else 
          puts contribution_params
          puts @contribution.inspect
          @contribution.update(contribution_params)
          format.html { redirect_to :contributions, notice: 'Contribution was successfully updated.' }
          format.json { render json: @contribution, status: :ok}
        end

      end
    rescue => exception
      puts exception.message
      format.html { redirect_to :contributions, alert: exception.message }
      format.json { render json: { error: exception.message, status: :unprocessable_entity }, status: :unprocessable_entity }
      
    end
  end


  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    respond_to do |format|
      if @contribution.nil?
        format.html { redirect_to :contributions, notice: 'Contribution not found', status: :not_found }
        format.json {
          render json:{
            error: "Contribution not found",
          }, status: :not_found
        }
      elsif @user.nil? || @user.id.to_s != @contribution.user_id.to_s
        format.html { redirect_to :contributions, notice: 'You need to be logged in to create a contribution', status: :unauthorized }
        format.json {
          render json: {
            error: "User not authorized to delete this contribution",
            status: :unauthorized
          }, status: :unauthorized
        }
      else
        @contribution.destroy
        format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
        format.json { render json: 
          {
            msg: "Contribution deleted", 
            contribution: @contribution
          }, status: :ok 
        }
      end
    end
  end



  # TODO: add logic to check if user is logged in before let make vote
  def like
    begin
      if @user.nil? || !@user.contributions.find_by_id(params[:id]).nil?
        render json:{
          error: "You're not allowed to vote this contribution ",
          status: :unauthorized
        }, status: :unauthorized
      elsif @user.voted_contributions.include?(@contribution)
        render json:{
          error: "user already voted",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      elsif @contribution.nil?
        render json:{
          error: "contribution not found",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      else
        puts @user.contributions
        @contribution.points += 1
        if @contribution.save
          @user.voted_contributions << @contribution
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
    begin
      if @user.nil?
        render json:{
          error: "user not authorized",
          status: :unauthorized
        }, status: :unauthorized

      elsif !@user.voted_contributions.include?(@contribution)
        render json:{
          error: "user not voted yet",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      elsif @contribution.nil?
        render json:{
          error: "contribution not found",
          status: :unprocessable_entity
        }, status: :unprocessable_entity
      else
        @contribution.points -= 1

        if @contribution.save
          @user.voted_contributions.delete(@contribution)
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

  def show_upvoted_contributions
    begin
      user = User.find(params[:id])
      @contributions = user.voted_contributions
      puts @contributions.inspect
      respond_to do |format|
        if @contributions
          format.html { render :show_news }
          format.json { render :json => @contributions, status: :ok}
        end
      end
    rescue => e
      render json:{
        error: e.message,
        status: :unprocessable_entity
      }, status: :unprocessable_entity
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contribution
    begin
      @contribution = Contribution.find(params[:id])
    rescue
      @contribution = nil
    end
  end

  # Only allow a list of trusted parameters through.
  def contribution_params
    params.require(:contribution).permit(:contribution_type, :text, :title, :url)
  end
end
