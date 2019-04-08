class ApplicationController < ActionController::Base
	include Pundit
  	protect_from_forgery
  	after_action :verify_authorized, except: [:index, :medline, :services, :ipe, :team], unless: :devise_controller?
  	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  	def current_user
  		@current_user = current_doctor
  	end
 
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
