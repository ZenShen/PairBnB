class WelcomeController < ActionController::Base
	def index
		render template: "welcome/index"
	end
end