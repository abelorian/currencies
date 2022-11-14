class ApplicationController < ActionController::Base


  def root
    render json: { status: :ok }
  end

	def rates
		render json: Rate.get_rates
	end
end
