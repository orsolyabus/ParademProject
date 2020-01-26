class RsvpsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @rsvp = Rsvp.new
  end
  
  def create
    @rsvp = Rsvp.new(rsvp_params)
    
    if @rsvp.save
      redirect_to @rsvp.event, notice: "RSVP saved!"
    else
      render :new, notice: @rsvp.errors.messages
    end
    # do something
  end
  
  def destroy
    rsvp = Rsvp.find(params[:id])
    rsvp.destroy
    redirect_to rsvp.event
  end
  
  private
  
  def rsvp_params
    params.permit(:response, :contact_id, :event_id)
  end
    
end
