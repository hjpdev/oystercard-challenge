require 'date'
require_relative 'journey'

class JourneyLog
  
  attr_reader :journey, :in, :out

  def initialize(journey_klass=Journey.new)
    @journey = journey_klass
    @log = []
  end

  def log
    @log.dup
  end

  def start_log(station)
    @in, @s = station.station_id, station.zone
    @journey.start(station)
    @log << current_journey
  end

  def finish_log(station)
    @out, @f = station.station_id, station.zone
    @journey.finish(station)
    @log[-1] = current_journey unless log.empty?
  end

  private

  def current_journey
    { time: time_format(journey.t0), in: @in, out: @out, zonei: @s, zoneii: @f, fare: @journey.fare }
  end

  def time_format(t0)
    "#{t0.to_s[0..1]}:#{t0.to_s[2..3]}"
  end
end