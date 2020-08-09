class ProfilesController < ApplicationController

  def new; end

  def show
    if current_user.nil?
      render file: "/public/404"
    else
      render locals: {user: User.find(current_user.id) }
    end
  end

  def edit
    render locals: {user: User.find(current_user.id) }
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    user.save
    flash[:notice] = 'Profile Updated!'
    redirect_to "/profile/#{user.id}"
  end

  def create
    if current_user
      current_user.update(user_params)
    end
    redirect_to root_path
  end

  def destroy
    User.find(params[:id]).destroy
    session.clear
    redirect_to '/'
    flash[:alert] = "Profile Deleted"
  end

  private

    def user_params
      params.permit(:zip_code, :name)
    end
end
