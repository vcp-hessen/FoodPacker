class SessionsController < ApplicationController

  layout "sign"

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => t("sessions.messages.logged_in")
    else
      flash.now[:alert] = t("sessions.messages.invalid")
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t("sessions.messages.logged_out")
  end
end
