require_relative 'fare_mod'

class Journey
  include FareMod

  attr_reader :entry_station, :exit_station, :sz, :ez, :fare

  PENALTY_FARE = 10
  MIN_FARE = 6

  def start(station)
    @entry_station = station.station_id
    @sz = station.zone
  end

  def finish(station)
    @exit_station = station.station_id
    @ez = station.zone
  end

  def calculate_fare
    return (@fare = PENALTY_FARE) if @sz == nil || @ez == nil
    @fare = peak_price(format_zones)
  end

  def format_zones
    return '1' if @sz == 1 && @ez == 1
    return '2-6' if @sz != 1 && @ez != 1
    arr = ['1-2', '1-3', '1-4', '1-5', '1-6']
    @sz > @ez ? arr[@sz-2] : arr[ez-2]
  end

  def complete?
    !!@exit_station
  end
end