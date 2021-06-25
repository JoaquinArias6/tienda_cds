class UsersController < ApplicationController
	#Avoids the favorite product list view to be displayed if an user is not logged.
	before_action :authorize, only: :show

	def new
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html { redirect_to login_url, notice: "User #{@user.name} was successfully created." }
			else 
				format.html { render :new, notice: "There was a processing error." }
			end
		end
	end

	def show
		@user = current_user
	end

	private

	def user_params
		params.permit(:name, :username, :password, :favorites)
	end

	#Auxilir method to authorize only logged users to enter certain roots
	def authorize
		if !logged_in?
			redirect_to root_path
		end
	end
end