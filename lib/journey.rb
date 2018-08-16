require_relative 'fare_mod'
require_relative 'time_mod'

class Journey
  
  include FareMod
  include TimeMod

  PENALTY_FARE = 10
  MIN_FARE = 6

  attr_reader :t0

  def start(station)
    @t0 = time
    @zoneI = station.zone
  end

  def finish(station)
    @zoneII = station.zone
  end

  def fare
    return PENALTY_FARE unless complete?
    peak ? peak_price([@zoneI, @zoneII]) : off_peak_price([@zoneI, @zoneII])
  end

  private
  def peak
    raise 'Not started' if @t0.nil?
    peak?(@t0)
  end

  def complete?
    !!@zoneI && !!@zoneII
  end
end