class Home::UserSessionsController < Home::ApplicationController
  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to(root_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end
end
