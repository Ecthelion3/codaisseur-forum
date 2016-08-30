class VotesController < ApplicationController
  after_action :broadcast_votes

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
  end

  private

  def broadcast_votes
    ActionCable.server.broadcast 'votes',
      votable_attributes

    head :ok
  end

  def votable_attributes
    votable.attributes.merge(
      rating: votable.rating,
      can_vote: votable.can_vote?(current_user),
      voted_down: votable.voted_down?(current_user),
      voted_up: votable.voted_up?(current_user),
      user_id: current_user.id,
      dom_id: "#{votable.class.name}_#{votable.id}")
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
