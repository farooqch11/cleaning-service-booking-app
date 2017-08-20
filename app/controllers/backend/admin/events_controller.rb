class Backend::Admin::EventsController < Backend::Admin::AdminsController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    # @events = Event.where(start: params[:start]..params[:end])
    @calendar_events = Event.where(start: params[:start]..params[:end])

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
    @calendar_events = nil
    if @event.save
      if @event.recurring?
        @calendar_events = @event.children
      else
        @calendar_events = [@event]
      end
      flash.now[:success] = "Successfully Created."
      # @calendar_events = @event.calendar_events(params.fetch(:start, Time.zone.now).to_date)
    else
      flash.now[:errors] = @event.errors.full_messages
    end
  end

  def update
    if @event.update(event_params)
      flash.now[:success] = "Successfully Updated."
      @calendar_events = @event.calendar_events(params.fetch(:start, Time.zone.now).to_date)

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
 
