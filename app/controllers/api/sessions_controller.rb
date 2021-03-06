module Api
  class SessionsController < ActionController::Base
    after_filter :set_csrf_header, only: [:create]

    def create
      user = User.where(email: params[:email]).first

      if valid_username_password?(user, params[:password])
        sign_in user
        render_success_message_for(user)
        return
      end

      render_invalid_login
    end

    private

    def valid_username_password?(user, password)
      user.present? && user.valid_password?(password)
    end

    def render_success_message_for(user)
      render json: {message: 'success', email: user.email}, status: 200
    end

    def render_invalid_login
      render json: {message: 'invalid email/password combination'}, status: 401
    end

    def set_csrf_header
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end
end