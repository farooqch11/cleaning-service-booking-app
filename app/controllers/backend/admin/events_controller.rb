class Backend::Admin::EventsController < Backend::Admin::AdminsController
  # respond_to :json , :js , :html
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @calendar_events = Event.includes(:employee , :customer).where(start: params[:start]..params[:end])
    # respond_with @events ,  each_serializer: EventSerializer
  end

  def show
  end

  def edit
  end


  def new
    e_date = params[:start].present? ? (params[:start].to_time + 1.hour).to_datetime || DateTime.now : DateTime.now
    @event = Event.new(start: params[:start] , end: e_date)

  end

  def create
    @event = Event.new(event_params)
    @calendar_events = nil
    if @event.save
      if @event.recurring?
        @calendar_events = [@event] + @event.children
      else
        @calendar_events = [@event]
      end
      flash.now[:success] = "Successfully Created."
    else
      flash.now[:errors] = @event.errors.full_messages
    end
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        flash.now[:success] = "Successfully Updated."
        format.js do
          if @event.recurring?
            @calendar_events = [@event] + @event.children
          else
            @calendar_events = [@event]
          end
        end
        format.json { render json: {success: true , data: render_to_string( template: 'backend/admin/events/show.json.jbuilder', event: @event) , message: "Successfully Updated."} }
      end
    else
      respond_to do |format|
        flash.now[:errors] = @event.errors.full_messages
        format.js {}
        format.json { render json: {success: false , errors: @event.errors.full_messages} }
      end
    end
  end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.find_by_id(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :street , :city , :total_cost , :is_parent_update , :status , :priority ,:cost_type ,  :address_line , :contact , :zip , :date_range, :type , :description , :start, :end, :color , :customer_id , :employee_id ,:recurring_type , :recurring_end_at ,:recurring_end_time ,:recurring , :job_duration , :job_duration_type)
  end
end
 
