class SessionsController < ApplicationController
  
  def new
  # will simply render the form
  end

  def create
 chef =Chef.find_by(email: params[:session][:email].downcase)
if chef && chef.authenticate(params[:session][:password])
session[:chef_id]= chef.id
cookies.signed[:chef_id] = chef.id
flash[:success]= "you have successfully login"
redirect_to chef
else
flash.now[:danger]= "There is somthing wrong with your login information"
render 'new'
end
  end 

  def destroy
  # will end the session or simulate logged out state
session[:chef_id]= nil
flash[:success]= "you have logged out"
redirect_to root_path
  
end

end 
