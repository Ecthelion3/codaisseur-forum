class VotesController < ApplicationController
  def create
    vote = current_user.votes.where(votable: votable, vote: -1).first
    if vote.present?
      vote.destroy
    else
      vote = current_user.votes.where(votable: votable, vote: 1).first
      vote ||= Vote.new(vote_params)
      vote.vote = 1
      vote.save
    end
    render json: votable_json
  end

  def destroy
    vote = current_user.votes.where(votable: votable, vote: 1).first
    if vote.present?
      vote.destroy
    else
      vote = current_user.votes.where(votable: votable, vote: -1).first
      vote ||= Vote.new(vote_params)
      vote.vote = -1
      vote.save
    end
    render json: votable_json
  end

  private

  def votable_json
    votable.attributes.merge(
      rating: votable.rating,
      can_vote: votable.can_vote?(current_user),
      voted_down: votable.voted_down?(current_user),
      voted_up: votable.voted_up?(current_user))
  end

  def votable
    @votable ||= begin
      return Answer.find(params[:answer_id]) if params[:answer_id].present?
      return Question.find(params[:question_id]) if params[:question_id].present?
      nil
    end
  end

  def vote_params
    { votable: votable, user: current_user }
  end
end
