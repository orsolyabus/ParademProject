class RsvpsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_user!, only: [:create, :destroy]

  def new
    @event = Event.find(params[:event_id])
    authorize_user! @event
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
    # solve autorization!
  end

  def destroy
    rsvp = Rsvp.find(params[:id])
    rsvp.destroy
    redirect_to new_event_rsvp_path params[:event_id]
    # solve autorization!
  end

  private

  def rsvp_params
    params.permit(:response, :contact_id, :event_id)
  end

  def authorize_user!(item = @rsvp)
    unless can? :crud, item
      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
