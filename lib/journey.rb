class Journey
  attr_reader :entry_station, :exit_station, :fare, :history

  PENALTY_FARE = 10

  def initialize
    @history = []
  end

  def start(station)
    @entry_station = station.station_id
  end

  def finish(station)
    @exit_station = station.station_id
    journey_hash = { in: @entry_station }
    journey_hash[:out] = @exit_station
    @history << journey_hash
  end

  def calculate_fare
    return (@fare = PENALTY_FARE) if @entry_station == nil || @exit_station == nil
    @fare = 1
  end

  def complete?
    @exit_station ? true : false
  end
end