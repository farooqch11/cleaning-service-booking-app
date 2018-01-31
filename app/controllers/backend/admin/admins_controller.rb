class Backend::Admin::AdminsController < Backend::BackendController

  before_action :check_user

  def check_user
    if current_user.class.name == "Employee"
      redirect_to employee_dashboard_path
      flash[:notice] = "You are not Authorized to Access"
    else
      return true
    end
  end

  def new
    respond_to do |format|
      format.html { }
      format.js   { new_render new_resource}
    end
  end


  def destroy
    respond_to do |format|
      if set_resource.destroy
        flash.now[:success] = 'Successfully Deleted.'
        format.html { redirect_to :back}
        format.js   {destroy_render set_resource }
      else
        format.js   { }
      end
    end
  end

  def show

  end

  def edit
    respond_to do |format|
      format.html { }
      format.js   { new_render set_resource}
    end
  end

  protected


  def new_render resource
    render partial: 'backend/admin/shared/ajax/new' , locals: {resource: resource}
  end

  def update_render resource
    render partial: 'backend/admin/shared/ajax/update' , locals: {resource: resource}
  end

  def destroy_render resource
    render partial: 'backend/admin/shared/ajax/destroy' , locals: {resource: resource}
  end

  def create_render resource
    render partial: 'backend/admin/shared/ajax/create' , locals: {resource: resource}
  end

end
