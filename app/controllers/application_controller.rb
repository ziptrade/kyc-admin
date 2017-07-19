class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Godmin::ApplicationController
  include Godmin::Authorization
  include AppendLoggerInfo
  include KYCApplicationRailsModule

  protect_from_forgery with: :exception

  def authenticate_admin_user
    require_login
  end

  def admin_user
    current_user
  end

  def admin_user_signed_in?
    signed_in?
  end
end
