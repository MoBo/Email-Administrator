class GroupUsersController < ApplicationController
  
  def show
    
  end
    
  def index 
      @users = User.find_all_by_group_id(params[:group_id])
      @group = Group.find(params[:group_id]);
  end
  
  def new
    @users = User.without_group();
  end
  
end