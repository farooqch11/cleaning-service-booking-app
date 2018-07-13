class Backend::Admin::EventsController < Backend::Admin::AdminsController
  # respond_to :json , :js , :html
  before_action :set_event, only: [:show, :edit, :update, :destroy, :update_all_future_events]
  before_action :new_resource , only: [:new]
  def index
    @calendar_events = Event.includes(:employee , :customer).where(start: params[:start]..params[:end])
    # respond_with @events ,  each_serializer: EventSerializer
  end

  def new

  end

  def show
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @calendar_events = []
    if @event.save
      if @event.recurring?
        @calendar_events = [@event] + @event.children.includes(:customer , :employee)
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

  def diffdate_in_days(start_date, end_date)
    a=end_date.strftime("%Y-%m-%d")
    b=start_date.strftime("%Y-%m-%d")
    a=Date.parse(a)
    b=Date.parse(b)
    days=(a-b).to_i
    return days
  end
  # def check_event_already_exist_future_day? all_events, start_date
  #
  #   end_date = all_events.last.end
  #   diff_date = diffdate_in_days start_date, end_date
  #   puts "Start Date is #{start_date}"
  #   puts "End date is #{end_date}"
  #   puts "Diff date is #{diff_date}"
  #   i = 1
  #
  #   while start_date <= end_date  do
  #     start_date = start_date + (i * diff_date).day
  #     return true if all_events.where("parent_id = #{@event.parent_id} and events.start >= '#{start_date.beginning_of_day.strftime("%Y-%m-%d %I:%M%P")}' and events.end <= '#{start_date.end_of_day.strftime("%Y-%m-%d %I:%M%P")}'").present?
  #     puts("Inside the loop i = #{i}" )
  #     i = i + 1
  #   end
  #   return false
  # end

  def update_all_future_events
    if @event.recurring?
      if event_params[:start]
        start_date = @event.start
        all_events = Event.where("events.parent_id = #{@event.parent_id} and events.start >= '#{start_date.strftime("%Y-%m-%d %I:%M%P")}'").order(start: :asc)
        if all_events.empty?
          update
        else
          end_date = all_events.last.end
          diff_date = diffdate_in_days start_date,  Time.zone.parse(event_params[:end]).to_date
          diff_date = diff_date * -1 if diff_date < 0
          puts "Start Date is #{start_date}"
          puts "End date is #{end_date}"
          puts "Diff date is #{diff_date}"
          i = 1
          is_terminate = true
          while (is_terminate and diff_date > 0 and start_date <= end_date)  do
            start_date = start_date + 7.day + diff_date.day
            puts("Inside the loop i = #{i}" )
            puts "Start Date is #{start_date}"
            # start_date = start_date + (i * diff_date).day
            if Event.where("parent_id = #{@event.parent_id} and events.start >= '#{start_date.beginning_of_day.strftime("%Y-%m-%d %I:%M%P")}' and events.end <= '#{start_date.end_of_day.strftime("%Y-%m-%d %I:%M%P")}'").present?
              is_terminate = false
              puts "terminating on  #{start_date}"
            end
            i = i + 1
          end
          if not is_terminate
            puts "Event Exist"
          else
            puts "Event Not Exist"
          end

          # if check_event_already_exist_future_day? all_events, start_date
          #   puts "Event Exist"
          # else
          #   puts "Event Not Exist"
          # end
        end
      end
    end

    #
    # else
    #   if @event.update(event_params)
    #     respond_to do |format|
    #       flash.now[:success] = "Successfully Updated."
    #       format.js do
    #         if @event.recurring?
    #           @calendar_events = [@event] + @event.children
    #         else
    #           @calendar_events = [@event]
    #         end
    #       end
    #       format.json { render json: {success: true , data: render_to_string( template: 'backend/admin/events/show.json.jbuilder', event: @event) , message: "Successfully Updated."} }
    #     end
    #   else
    #     respond_to do |format|
    #       flash.now[:errors] = @event.errors.full_messages
    #       format.js {}
    #       format.json { render json: {success: false , errors: @event.errors.full_messages} }
    #     end
    #   end
    # end

  end
  def destroy
    @event.destroy
  end

  private

  def new_resource
    @event = Event.new(start: params[:start].to_time , end: params[:start].to_time + 1.hour)
  end

  def set_event
    @event = Event.find_by_id(params[:id] || params[:event_id])
  end

  def event_params
    params.require(:event).permit(:title, :street , :city , :total_cost , :is_parent_update , :status , :priority ,:cost_type ,  :address_line , :contact , :zip , :date_range, :type , :description , :start, :end, :color , :customer_id , :employee_id ,:recurring_type , :recurring_end_at ,:recurring_end_time ,:recurring , :job_duration , :job_duration_type, :payment_type)
  end
end
 
