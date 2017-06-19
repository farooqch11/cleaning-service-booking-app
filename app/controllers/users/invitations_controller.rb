class Users::InvitationsController < Devise::InvitationsController

  # def edit
  #   super
  # end

  def update
    self.resource = resource_class.find_by_invitation_token(update_resource_params[:invitation_token],true)
    if resource.present?
      resource = resource_class.accept_invitation!(update_resource_params.merge!(status: User.statuses[:accepted]))
      if resource && resource.valid?
        sign_in(resource)
        flash[:notice] = "You have successfully completed your on-boarding."
        redirect_to resource.admin? ? admin_dashboard_path : employee_dashboard_path
      else
        resource.invitation_token = update_resource_params[:invitation_token]
        puts flash[:errors] = resource.errors.full_messages
        redirect_to :back
      end
    else
      resource.invitation_token = update_resource_params[:invitation_token] if resource
      flash[:errors] = resource.present? ? resource.errors.full_messages : ['Something is not right, Please try again.']
      redirect_to :back
    end
  end

  protected

  private
  def update_resource_params
    params.require(:user).permit(:type , :first_name, :last_name , :password, :password_confirmation, :phone , :street , :city , :postcode , :invitation_token, :dob, :gender, :phone , :image)
  end
end
