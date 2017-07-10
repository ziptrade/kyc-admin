class UserService
  include Godmin::Resources::ResourceService

  attrs_for_index :email, :auth_token
  attrs_for_export :id, :email

  # attrs_for_show :email
  # attrs_for_form :email, :password
end
