class AnswersController < ApplicationController

  def index
    @answers = Answer.order(created_at: :desc)
  end

  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(params.require(:answer).permit(:body, :user_id))
    @answer.question = @question
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(@question)
    end
  end

  def update
    @answer = Answer.find(params[:answer_id])

    if @answer.update(params.permit(:body, :user_id, :question_id))
      render json: @answer
    else
      render json: {error: "could not update answer"}
    end
  end

  def destroy
    @question = Question.find(params[:question_id])

    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end
end
