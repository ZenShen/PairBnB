class ListingsController < ApplicationController
	def index
		
	end

	def new
		@listing = Listing.find[params[:id]]
		redirect_to "listing#form"
	end
end