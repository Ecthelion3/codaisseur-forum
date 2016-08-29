class Question < ApplicationRecord
  include Filterable
  include IsVotable

  belongs_to :user
  has_many :answers
  belongs_to :topic

  validates_presence_of :title, :body, :topic_id

  scope :topic, -> (topic_id) { where topic_id: topic_id }

  def self.search(search)
    where("title ILIKE ? ", "%#{search}%")
  end
end
