Clearance.configure do |config|
  config.allow_sign_up = false
  config.cookie_domain = 'kyc.bitex.com'
  config.cookie_expiration = ->(_cookies) { 1.year.from_now.utc }
  config.cookie_name = 'remember_token'
  config.cookie_path = '/'
  config.routes = false
  config.httponly = false
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = '/'
  config.secure_cookie = false
  config.sign_in_guards = []
  config.user_model = User
  config.mailer_sender = 'kyc@bitex.com'
  config.rotate_csrf_on_sign_in = true
end
