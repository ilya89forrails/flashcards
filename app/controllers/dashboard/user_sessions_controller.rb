class Dashboard::UserSessionsController < Dashboard::ApplicationController
  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end
