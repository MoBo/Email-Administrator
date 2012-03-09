class EmailsController < ApplicationController
  helper_method :sort_column, :sort_direction
    
  def index
    #@emails = Email.all
    @emails = Email.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
  end

  def update
    email_path = get_or_create_email_path(params[:email_path_name])
    params[:email][:email_path_id] = email_path.id.to_s
     
    @email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      redirect_to @email, notice: 'Email was successfully updated.'
    else
      redirect_to [:edit,@email]
    end
  end

  def new
    @email = Email.new
  end

  def create
    email_path = get_or_create_email_path(params[:email_path_name])
    params[:email][:email_path_id] = email_path.id.to_s
     
    @email = Email.new(params[:email])
    if @email.save
      redirect_to @email, notice: 'Email was successfully created.'
    else
      redirect_to [:new,@email]
    end
  end
  
  # def search
     # @emails = Email.find(:all, :conditions => ["email LIKE ?","%#{params[:email]}%"])
    # render "index"
  # end
  
  private
  
  def get_or_create_email_path(email_path_name)
    # Check if email path already exits otherwise create new path
    email_path = EmailPath.find_by_path(email_path_name)
    if not email_path
      email_path = EmailPath.create(:path => params[:email_path_name], :path_type => "custom")
    end
    email_path
  end
  
  def sort_column
    Email.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
