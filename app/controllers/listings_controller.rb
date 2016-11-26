class ListingsController < ApplicationController
	def index
		@user = current_user
		
		if @user.role == "landlord"
			@listings = Listing.where(user_id: current_user.id)
			@listings = @listings.paginate(:page => params[:page], :per_page => 5)
		else
			@listings = Listing.all
			@listings = @listings.paginate(:page => params[:page], :per_page => 5)		
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to @listing
		else
			render 'new'
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing, notice: "Success!"
		else 
			render 'edit'
		end
	end

	def destroy
		Listing.find(params[:id]).destroy
		redirect_to root_path
	end

	private

	def listing_params
		params.require(:listing).permit(:property_name, :country, :city_town, :home_type, :guest, :description, :price, {photos: []})
	end
end