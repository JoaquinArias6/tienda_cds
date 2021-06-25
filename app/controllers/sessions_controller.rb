class SessionsController < ApplicationController
	#Avoids the login view to be displayed if an user is logged.
	before_action :authorize, only: :new

	def new
	end

	#Creates an unique session. It will not be followed by any other until this one is destroyed
	def create
		@user = User.find_by(username: params[:username])
   		if @user && @user.authenticate(params[:password])
      		session[:user_id] = @user.id

      		redirect_to root_path, notice: "Logged in succesfully"
   		else
      		redirect_to '/login', notice: "Wrong Username and/or Password"
   		end
	end

	def destroy
		session.delete(:user_id)
    	redirect_to root_path
	end

	private

	#Auxilir method to authorize only logged users to enter certain roots
	def authorize
		if logged_in?
			redirect_to root_path
		end
	end
end