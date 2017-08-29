class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id]) # params для получения id пользователя
  end
end
