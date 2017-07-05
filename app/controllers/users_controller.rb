class UsersController < ApplicationController
  include Godmin::Resources::ResourceController

  def reset_auth_token
    User.find(params[:id]).reset_auth_token!

    redirect_to users_path
  end
end
