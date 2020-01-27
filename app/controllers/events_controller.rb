class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!
  before_action :authorize_user!, except: [:new, :index, :create]
  
  def index
    @events = current_user.events
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
    @event.user = current_user
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully deleted.'
  end

  private
    def set_event
      @event = Event.includes(rsvps: :contact).find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date, :attendees)
    end
    
    def authorize_user!
      unless can? :crud, @event
        render :file => "public/401.html", :status => :unauthorized
      end
    end
end
