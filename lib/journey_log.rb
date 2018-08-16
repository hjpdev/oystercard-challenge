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
    @in = station.station_id
    @log << current_journey
    @journey.start(station)
  end

  def finish_log(station)
    @out = station.station_id
    @journey.finish(station)
    @log[-1] = current_journey unless log.empty?
  end

  private

  def current_journey
    { date: date_format, in: @in, out: @out, fare: @journey.fare}
  end

  def date_format
    Date.today.strftime('%F').split('-').reverse.join('-')
  end
end