class RsvpsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event
  before_action :authorize_user!, only: [:new, :create, :destroy]

  def new
    @rsvp = Rsvp.new
    @contacts = current_user.contacts.includes(:rsvps)
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.save
      redirect_to new_event_rsvp_path(params[:event_id])
    else
      render :new, notice: @rsvp.errors.messages
    end
  end

  def destroy
    rsvp = Rsvp.find(params[:id])
    rsvp.destroy
    redirect_to new_event_rsvp_path params[:event_id]
  end

  private

  def rsvp_params
    params.permit(:response, :contact_id, :event_id)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
  
  def authorize_user!
    unless can? :rsvp, @event
      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
