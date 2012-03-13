class EmailPathsController < ApplicationController
  def index
    @email_paths = EmailPath.all
  end

  def show
    @email_path = EmailPath.find(params[:id])
  end

  def edit
     @email_path = EmailPath.find(params[:id])
  end

  def update
    @email_path = EmailPath.find(params[:id])
    if @email_path.update_attributes(params[:email_path])
      redirect_to  @email_path, notice: 'Path was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def new
     @email_path = EmailPath.new    
     respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @email_path = EmailPath.new(params[:email_path])
    if  @email_path.save
      redirect_to  @email_path, notice: 'User was successfully created.'
    else
      redirect_to [:new,:email_paths]
    end
  end
  
  def destroy
    e = Email.find_all_by_domain_id(params[:id])
    e.each do |e|
      e.destroy
    end
    Domain.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end