class EmailsController < ApplicationController
  
  def index
    @emails = Email.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end
  
  def search
     @emails = Email.find(:all, :conditions => ["address LIKE ?","%#{params[:address]}%"])
    render "index"
  end
end
