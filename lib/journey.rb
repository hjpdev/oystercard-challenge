require '/Users/harryjames/Documents/MA/Projects/oystercard_challenge/lib/fare_mod.rb'

class Journey
  include FareMod

  attr_reader :entry_station, :exit_station, :sz, :ez

  PENALTY_FARE = 10
  MIN_FARE = 6

  def fare
    @fare = peak_price(format_zones)
  end

  def start(station)
    @entry_station = station.station_id
    @sz = station.zone
  end

  def finish(station)
    @exit_station = station.station_id
    @ez = station.zone
  end

  def calculate_fare
    @fare = peak_price(format_zones)
  end

  def format_zones
    return '1' if @sz == 1 && @ez == 1
    return '2-6' if @sz != 1 && @ez != 1
#Needs sorting
  end

  def complete?
    !!@exit_station
  end
end