class Backend::Employee::EventsController < Backend::Employee::EmployeesController

  def index
    @events = Event.where(start: params[:start]..params[:end] , employee_id: current_user.id)
  end
end
 
