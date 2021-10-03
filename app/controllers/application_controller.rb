class ApplicationController < ActionController::Base

	before_action :set_current_user
	protected
	def set_current_user
		# @current_user ||= User.find_by_id(session[:user_id])
		# redirect_to login_path and return unless @current_user
		@current_user = current_user
	end

	require 'themoviedb'
	Tmdb::Api.key("304ab5d77e2bf6ba7526a2ceb0726634")

	def set_config
		@configuration = Tmdb::Configuration.new
	end


end
