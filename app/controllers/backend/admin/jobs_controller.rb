class Backend::Admin::JobsController < Backend::Admin::EventsController

  def index
    @search = Job.where(parent_id: nil).order(created_at: :asc).search(params[:q])
    @jobs = @search.result.paginate(page: params[:page], per_page: 10) || []

  end

  def show
    @parent_job = @event.root.children.paginate(page: params[:page], per_page: 10) || []
  end

  private

  def set_event
    @event =  Event.find_by_id_and_type(params[:id] , 'Job')
  end



  def event_params
    params.require(:job).permit(:title, :street , :city , :total_cost , :is_parent_update , :status , :priority ,:cost_type ,  :address_line , :contact , :zip , :date_range, :type , :description , :start, :end, :color , :customer_id , :employee_id ,:recurring_type , :recurring_end_at ,:recurring_end_time ,:recurring , :job_duration , :job_duration_type)
  end

end
