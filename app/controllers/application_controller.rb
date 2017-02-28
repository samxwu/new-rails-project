class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  private
  
  def user_not_authorized
  
    flash[:notice] = "Not authorized to make that change."
    redirect_to edit_wiki_path
  end
  
  def change_plan(current_user)
    updated_role = if current_user.role == 'standard' then 1 elsif current_user.role == 'premium' then 0 end 
    User.where('email = ?', current_user.email).update_all(role: updated_role)
  end

  
end
