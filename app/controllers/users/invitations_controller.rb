class Users::InvitationsController < Devise::InvitationsController

  def edit
  end

  def update
    self.resource = resource_class.find_by_invitation_token(update_resource_params[:invitation_token],true)
    if resource.present?
      resource = resource_class.accept_invitation!(resource_params.merge!(status: User.statuses[:accepted]))
      if resource && resource.valid?
        sign_in(resource)
        flash[:notice] = "You have successfully completed your on-boarding."
        redirect_to resource.admin? ? admin_dashboard_path : employee_dashboard_path
      else
        resource.invitation_token = update_resource_params[:invitation_token]
        flash[:errors] = resource.errors.full_messages
        redirect_to :back
      end
    else
      resource.invitation_token = update_resource_params[:invitation_token] if resource
      flash[:errors] = resource.present? ? resource.errors.full_messages : ['Something is not right, Please try again.']
      redirect_to :back
    end
  end

  private

  def resource_params
    params.require(:user).permit(:invitation_token , :password, :password_confirmation, :dob, :gender, :phone, :image,:first_name, :last_name)
  end
end
