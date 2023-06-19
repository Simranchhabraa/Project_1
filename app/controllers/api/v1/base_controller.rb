class Api::V1::BaseController < ApplicationController
    def render_with_success message = "", user = ""
        render json: {status: "success", message: message, user: user}
    end
  
    def render_with_error message = ""
        render json: {status: "error", message: message}
    end
  
    def authenticate_current_user
      logger.info "token::=== #{params[:token]}"
      @user = AuthToken.find_by(token: params[:token]).user rescue nil
      render_with_error("User not found with this token") unless @user
    end
end
