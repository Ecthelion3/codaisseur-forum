class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
    
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
