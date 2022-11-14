class ApplicationController < ActionController::Base

	def rates
		render json: Rate.get_rates
	end
end
