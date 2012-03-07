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
    @email = Email.new
  end

  def create
    @email = Email.new(params[:email])
    if @email.save
      redirect_to @email, notice: 'Email was successfully created.'
    else
      redirect_to [:new,:emails]
    end
  end
  
  def search
     @emails = Email.find(:all, :conditions => ["address LIKE ?","%#{params[:address]}%"])
    render "index"
  end
end
