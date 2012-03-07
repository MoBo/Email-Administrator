class DomainsController < ApplicationController
  
  
  def index
    @domains = Domain.all
  end

  def show
    @domain = Domain.find(params[:id])
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    @domain.update_attributes(params[:domain])
    if @domain.update_attributes(params[:user])
      redirect_to @domain, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def new
    @domain = Domain.new #(:name =>"bimbam", :id => Domain.last.id)
    
     respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      redirect_to @domain, notice: 'User was successfully created.'
    else
      redirect_to [:new,:dmoains]
    end
  end
end
