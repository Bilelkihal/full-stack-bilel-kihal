class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  private

  def authenticate_user
    if Rails.env.development?
      @current_user = User.find(1)
    else
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.find_by(auth_token: token)
      end
    end
  end

  def current_user
    @current_user
  end
end
