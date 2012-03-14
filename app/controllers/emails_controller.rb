class EmailsController < ApplicationController
  before_filter :authenticate_admin!
  helper_method :sort_column, :sort_direction
    
  def index
    #@emails = Email.all
    @emails = Email.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
    @domains = Domain.all
    @domain = @email.domain
  end

  def update
    @email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      redirect_to emails_path, notice: 'Email was successfully updated.'
    else
      @domains = Domain.all
      @domain = Domain.find(params[:email][:domain_id])
      render 'edit' #redirect_to [:edit,@email]
    end
  end

  def new
    @email = Email.new
    @domains = Domain.all
  end

  def create
    @email = Email.new(params[:email])
    if @email.save
      redirect_to emails_path, notice: 'Email was successfully updated.'
    else
      @domains = Domain.all
      render 'new'
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
