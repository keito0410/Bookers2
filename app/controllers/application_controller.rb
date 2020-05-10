class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	protected

    def after_sign_in_path_for(resource_or_scope)
      books_path
    end

	def configure_permitted_parameters
        added_attrs = [ :email, :name, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    def authenticate_user
        if current_user == nil
            flash[:notice] = "アクセス権限がありません"
            redirect_to("/login")
        end
    end

    def ensure_correct_user
        if current_user.id != params[:id].to_i
            redirect_to user_path(current_user)
        end
    end

end
