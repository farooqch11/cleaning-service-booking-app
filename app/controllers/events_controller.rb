class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @events = Event.all
  end 

  def show
  end 

  def new 
    @event = Event.new
  end 

  def edit
  end 

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end 

  def update
    @event.update(event_params)
    flash[:notice] = 'Event was successfully updated.'
    respond_with(@event)
  end 

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end 

  private
    def set_event
      @event = Event.find(params[:id])
    end 

    def event_params
      params.require(:event).permit(:title , :date_range , :start , :end , :color)

    end 
end
 
