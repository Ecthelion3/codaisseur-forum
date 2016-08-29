class QuestionsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    if user_signed_in?
      if current_user.disabled == true
        sign_out_and_redirect(current_user)
      end
    end

    if params[:search]
      @questions = Question.search(params[:search]).order(created_at: :desc).paginate(:page =>params[:page], :per_page => 5)
    else
      @questions = Question.order("#{sort_column} #{sort_direction}").filter(params.slice(:topic)).paginate(:page =>params[:page], :per_page => 5)
    end

    @random = Question.includes(:answers).where( :answers => { :question_id => nil } ).sample(1)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    authorize! :create, @question
    if @question.save()
      redirect_to @question
    else
      render :new
    end
  end


  def update
    @question = Question.find(params[:question_id])

    if @question.update(question_params)
      render json: @question
    else
      render json: {error: "could not update question"}
    end
  end

  def destroy

    @question = Question.find(params[:id])

    @question.destroy
    flash.notice = "Question '#{@question.title}' Deleted!"
    redirect_to questions_path
  end

  def user
    @user = User.find( params[:user_id] )
    authorize! :read, @user

    @question = Question.where( user: @user ).order( created_at: :desc )
    authorize! :read, @user
  end

  private
  def sortable_columns
    [ "created_at", "title", "topic_id"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def question_params
    params.require(:question).permit(:body, :title, :topic_id)
  end
end
