module IsVotable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable

    def rating
      votes.sum(:vote).to_i
    end

    def voted_up?(user)
      votes.where(user: user, vote: 1).count > 0
    end

    def voted_down?(user)
      votes.where(user: user, vote: -1).count > 0
    end

    def voted?(user)
      !can_vote?(user)
    end

    def can_vote?(user)
      votes.where(user: user).count == 0
    end
  end
end
