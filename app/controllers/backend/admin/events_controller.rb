class Backend::Admin::EventsController < Backend::Admin::AdminsController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.where(start: params[:start]..params[:end])
    @calendar_events = @events.flat_map{ |e| e.calendar_events(params[:start])}
  end

  def show
  end

  def edit
  end


  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash.now[:success] = "Successfully Created."
    else
      flash.now[:errors] = @event.errors.full_messages
    end
  end

  def update
    if @event.update(event_params)
      flash.now[:success] = "Successfully Updated."
    else
      flash.now[:errors] = @event.errors.full_messages
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
    params.require(:event).permit(:title, :street , :city , :address_line , :contact , :zip , :date_range, :type , :description , :start, :end, :color , :customer_id , :employee_id ,:recurring)
  end
end
 
