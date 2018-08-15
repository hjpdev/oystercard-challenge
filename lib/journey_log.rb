require 'date'
require_relative 'journey'

class JourneyLog
  attr_reader :journey, :journeys, :in, :out

  def initialize(journey_klass=Journey.new)
    @journey = journey_klass
    @journeys = []
  end

  def start(station)
    @in = station.station_id
    @journey.start(station)
  end

  def finish(station)
    @out = station.station_id
    @journeys << current_journey.merge(balance: @journey.fare)
  end

  def current_journey
    { date: date_format, in: @in, out: @out }
  end

  private

    def date_format
      Date.today.strftime('%F').split('-').reverse.join('-')
    end
end
