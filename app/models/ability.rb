class Ability
  include CanCan::Ability

  def initialize(user)
    # Anonymous users don't have access to anything
    return if user.nil?

    if user.is_admin?
      can :manage, :all
    elsif user.is_teacher?
      can :manage, Question, user: user
      can :manage, Answer, user: user
      can [:create, :edit], Profile, user: user
    elsif user.is_student?
      can :manage, Question, user: user
      can :manage, Answer, user: user
      can [:create, :edit], Profile, user: user
    end
  end
end
