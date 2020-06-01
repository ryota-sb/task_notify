class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session 

  # APIではCSRFチェックをしない
  skip_before_action :verify_authenticity_token, if: :devise_controller?
end