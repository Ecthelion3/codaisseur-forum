class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Filterable
  scope :role, -> (role) { where role: role }
  scope :approved, -> (approved) { where approved: approved }

  has_one :profile
  has_many :votes

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def self.search(search)
    where("first_name ILIKE ? ", "%#{search}%")
  end

  ROLES = %w(student teacher admin)

  def is_admin?
    role == 'admin' && disabled == false
  end

  def is_teacher?
    role == 'teacher' && disabled == false
  end

  def is_student?
    role == 'student' && disabled == false
  end
end
