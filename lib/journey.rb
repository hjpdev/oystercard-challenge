require_relative 'fare_mod'

class Journey
  include FareMod

  PENALTY_FARE = 10
  MIN_FARE = 6

  def start(station)
    @zoneI = station.zone
  end

  def finish(station)
    @zoneII = station.zone
  end

  def complete?
    !!@zoneI && !!@zoneII
  end

  def fare
    return PENALTY_FARE unless complete?
    peak_price([@zoneI, @zoneII])
  end
end