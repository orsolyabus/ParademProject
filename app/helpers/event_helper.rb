module EventHelper
  def coming
    @event.rsvps.where(response: "yes")
  end
end
