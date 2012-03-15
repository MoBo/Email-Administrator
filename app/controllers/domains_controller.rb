class DomainsController < ApplicationController
  before_filter :authenticate_email!
  
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
    if @domain.update_attributes(params[:domain])
      Email.find_all_by_domain_id(params[:id]).each do |e|
        e.domain = @domain
      end
      redirect_to :action => 'index', notice: 'Domain was successfully updated.'
    else
      render 'edit'
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
      redirect_to @domain, notice: 'Domain was successfully created.'
    else
      redirect_to [:new,:domain]
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
