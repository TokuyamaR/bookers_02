class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?


  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  	end

	def after_sign_in_path_for(resource)
	  user_path(resource)
	end

	def after_sign_out_path_for(resource)
	  top_path
	end

    def forbid_login_user
      if current_user
        flash[:notice] = "You have log-in yet."
        redirect_to user_path(current_user.id)
      end
    end

    def ensure_correct_user
      if current_user.id != params[:id].to_i
        flash[:notice] = "Permission denied"
        redirect_to user_path(current_user.id)
      end
    end
end
