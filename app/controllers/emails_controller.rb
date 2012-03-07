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
     @emails = Email.find_all_by_address(params[:address])
    render "index"
  end
end
