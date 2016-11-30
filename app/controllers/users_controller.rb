class UsersController < Clearance::UsersController
 # if respond_to?(:before_action)
 #   before_action :redirect_signed_in_users, only: [:create, :new]
 #   skip_before_action :require_login, only: [:create, :new], raise: false
 #   skip_before_action :authorize, only: [:create, :new], raise: false
 # else
 #   before_filter :redirect_signed_in_users, only: [:create, :new]
 #   skip_before_filter :require_login, only: [:create, :new], raise: false
 #   skip_before_filter :authorize, only: [:create, :new], raise: false
 # end

 def index
 end

 def show
	@user = User.find(params[:id])
end

 def new
  if params[:user]
    @user = user_from_params
  else
    @user = User.new
  end
  render 'new'
 end

 def create
   @user = user_from_params

   if @user.save
     sign_in @user
     # byebug
   #   redirect_back_or url_after_create
   # else
     redirect_to edit_user_path @user
   end
 end

 def edit
   @user = User.find(params[:id])
   # u = User.new
   # u.avatar = params[:file] 
   render 'edit'
 end

def update
	@user = User.find(params[:id])
	# byebug
		 if @user.update(user_params)
			render 'show', notice: "Success!"
		else
			puts @user.errors.full_messages
			render 'edit'
		end
end

# def destroy
# 	User.find(params[:id]).destroy
# 	redirect_to root_path
# end

 private

 def avoid_sign_in
   warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
     "deprecated. Use `redirect_signed_in_users` instead. " +
     "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
     " or `skip_before_action :avoid_sign_in` as well"
   redirect_signed_in_users
 end

 def redirect_signed_in_users
   if signed_in?
     redirect_to Clearance.configuration.redirect_url
   end
 end

 def url_after_create
   Clearance.configuration.redirect_url
 end

 def user_from_params
   email = user_params.delete(:email)
   password = user_params.delete(:password)

   Clearance.configuration.user_model.new(user_params).tap do |user|
     user.email = email
     user.password = password
   end
 end

 def user_params
   params.require(:user).permit(:email, :password, :role, :avatar)
 end

# def user_params
#     params[Clearance.configuration.user_parameter] || Hash.new
# end
 # def user_params
 #   params.require(:user).permit(:first_name, :last_name, :email, :role, :avatar)
 # end
end

# class UsersController < ApplicationController
#   def index
#   end
# end
 # class Clearance::UsersController < Clearance::BaseController
#   if respond_to?(:before_action)
#     before_action :redirect_signed_in_users, only: [:create, :new]
#     skip_before_action :require_login, only: [:create, :new], raise: false
#     skip_before_action :authorize, only: [:create, :new], raise: false
#   else
#     before_filter :redirect_signed_in_users, only: [:create, :new]
#     skip_before_filter :require_login, only: [:create, :new], raise: false
#     skip_before_filter :authorize, only: [:create, :new], raise: false
#   end

#   def new
#     @user = user_from_params
#     render template: "users/new"
#   end

#   def create
#     @user = user_from_params

#     if @user.save
#       sign_in @user
#       redirect_back_or url_after_create
#     else
#       render template: "users/new"
#     end
#   end

#   private

#   def avoid_sign_in
#     warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
#       "deprecated. Use `redirect_signed_in_users` instead. " +
#       "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
#       " or `skip_before_action :avoid_sign_in` as well"
#     redirect_signed_in_users
#   end

#   def redirect_signed_in_users
#     if signed_in?
#       redirect_to Clearance.configuration.redirect_url
#     end
#   end

#   def url_after_create
#     Clearance.configuration.redirect_url
#   end

#   def user_from_params
#     email = user_params.delete(:email)
#     password = user_params.delete(:password)

#     Clearance.configuration.user_model.new(user_params).tap do |user|
#       user.email = email
#       user.password = password
#     end
#   end

#   def user_params
#     params[Clearance.configuration.user_parameter] || Hash.new
#   end
# end