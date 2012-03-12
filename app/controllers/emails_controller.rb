class EmailsController < ApplicationController
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
    email_path = get_or_create_email_path(params[:email_path_name])
    if email_path
      params[:email][:email_path_id] = email_path.id.to_s
      if @email.update_attributes(params[:email])
        redirect_to @email, notice: 'Email was successfully updated.'
      else
        @domains = Domain.all
        @domain = Domain.find(params[:email][:domain_id])
        render 'edit' #redirect_to [:edit,@email]
      end
    else
      redirect_to [:edit,@email]
    end
     
    
  end

  def new
    @email = Email.new
    @domains = Domain.all
  end

  def create
    email_path = get_or_create_email_path(params[:email_path_name])
    if email_path
      params[:email][:email_path_id] = email_path.id.to_s
      @email = Email.new(params[:email])
      if @email.save
        redirect_to @email, notice: 'Email was successfully created.'
      else
        redirect_to new_email_path
      end
    else
      redirect_to new_email_path
    end
  end
  
  # def search
     # @emails = Email.find(:all, :conditions => ["email LIKE ?","%#{params[:email]}%"])
    # render "index"
  # end
  
  private
  
  def get_or_create_email_path(email_path_name)
    # Check if email path already exits otherwise create new path
    if not email_path_name.empty?
      email_path = EmailPath.find_by_path(email_path_name)
      if not email_path
        email_path = EmailPath.create(:path => params[:email_path_name], :path_type => "custom")
      end
      email_path
    end
  end
  
  def sort_column
    Email.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
