class Devise::UnlocksController < DeviseController
  prepend_before_filter :require_no_authentication

  # GET /resource/unlock/new
  def new
    build_resource({})
  end

  # POST /resource/unlock
  def create
    self.resource = resource_class.send_unlock_instructions(params[resource_name])

    if successfully_sent?(resource)
      respond_with({}, :location => new_session_path(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    self.resource = resource_class.unlock_access_by_token(params[:unlock_token])

    if resource.errors.empty?
      set_flash_message :notice, :unlocked if is_navigational_format?
      expires_on = Date.today + APP_CONFIG["email_default_expires_in"]
      resource.update_attribute("active",true)
      resource.update_attribute("expires_on",expires_on)
      respond_with_navigational(resource){ render :text => "Your account was extended till #{expires_on}" }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end
end