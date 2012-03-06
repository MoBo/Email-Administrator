class GroupUsersController < ApplicationController
  has_scope \
    :without_group
    
  def index 
      @users = User.find_all_by_group_id(params[:group_id])
      @group = Group.find(params[:group_id]);
  end
  
  def add
    @users = User.without_group();
  end
end