class AnswersController < ApplicationController
  before_action :load_question

  def index
    @answers = Answer.order(created_at: :desc)
  end

  def new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user = current_user

    if @answer.save
      if request.xhr?
        answer_out = render_to_string "/answers/_answer", layout: false
        ActionCable.server.broadcast 'answers', answer_out
        head :ok
      else
        redirect_to question_path(@question)
      end
    end
  end

  def update
    @answer = Answer.find(params[:answer_id])

    if @answer.update(answer_params)
      render json: @answer
    else
      render json: {error: "could not update answer"}
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
