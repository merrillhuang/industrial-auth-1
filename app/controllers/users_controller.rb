class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]

  def feed
    authorize @user
  end

  def show
    authorize @user
  end

  def liked
    authorize @user
  end

  def discover
    authorize @user
  end

  def followers
    authorize @user
  end

  def following
    authorize @user
  end

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end
end
