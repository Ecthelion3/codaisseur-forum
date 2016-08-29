class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates :vote, inclusion: { in: [-1, 1] }

  validates_presence_of :user, :votable, :vote
  # validates_uniqueness_of :votable, scope: :user
end
