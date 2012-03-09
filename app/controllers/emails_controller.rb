class EmailsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    #@emails = Email.all
    @emails = Email.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end

  def show
    @product = Product.find(params[:id])
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
  
  # def search
     # @emails = Email.find(:all, :conditions => ["email LIKE ?","%#{params[:email]}%"])
    # render "index"
  # end
  
  private
  
  def sort_column
    Email.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
