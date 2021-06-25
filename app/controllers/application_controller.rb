class ApplicationController < ActionController::Base
	helper_method :current_user
	helper_method :logged_in?
	
	#Auxiliar method to find the instance of the logged user.
	def current_user
   		User.find_by(id: session[:user_id])
	end

	#Auxiliar method that checks if a user is logged in. It's not really necessary, but helps to not be confused.
	def logged_in?
    	!current_user.nil?
	end
end