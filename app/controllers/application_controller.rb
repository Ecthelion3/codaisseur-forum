class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_profile

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_path
  end

  def check_profile
    return unless user_signed_in?
    return if current_user.profile.present? || devise_controller?
    return if request.path.match(/^\/profile/)
    redirect_to new_profile_path, notice: "Please create a profile first"
  end
end
