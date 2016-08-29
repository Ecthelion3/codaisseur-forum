class Answer < ApplicationRecord
  include IsVotable

  belongs_to :user
  belongs_to :question

  validates_presence_of :body, :user, :question
end
