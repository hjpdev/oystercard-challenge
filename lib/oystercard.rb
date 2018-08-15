require_relative 'station'
require_relative 'journey_log'

class OysterCard

  MAX_BALANCE = 90

  attr_reader :balance, :journey_log

  def initialize(journey_log_klass=JourneyLog)
    @balance = 0
    @journey_log = journey_log_klass.new
  end

  def journey_history
    @journey_log.journeys
  end

  def in_journey?
    !!@journey_log.in
  end

  def top_up(amount)
    raise "Balance can't be greater than £#{MAX_BALANCE}." if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station=nil)
    raise 'Balance not high enough.' if @balance < Journey::MIN_FARE
    @journey_log.start(station)
  end

  def touch_out(station=nil)
    @journey_log.finish(station)
    deduct(Journey::MIN_FARE)
  end

private

  def deduct(amount)
    @balance -= amount
  end
end

oc = OysterCard.new
s1 = Station.new(:XX, 1)
s2 = Station.new(:YY, 6)
s3 = Station.new(:AA, 2)

oc.top_up(20)
oc.touch_in(s1)
oc.touch_out(s2)

p oc.journey_log.journey.calculate_fare

oc.touch_in(s1)
oc.touch_out(s2)

p oc.journey_log.journey.calculate_fare
p oc.journey_log.journeys
