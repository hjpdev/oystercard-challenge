require_relative 'station'
require_relative 'journey'

class OysterCard

  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :log

  def initialize(journey_klass=Journey.new)
    @balance = 0
    @log = journey_klass
  end

  def journey_history
    @log.history
  end

  def in_journey?
    !!@log.entry_station
  end

  def top_up(amount)
    raise "Balance can't be greater than £#{MAX_BALANCE}." if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance not high enough.' if @balance < MINIMUM_FARE
    @log.start(station)
  end

  def touch_out(station)
    @log.finish(station)
    deduct(MINIMUM_FARE)
  end

private

  def deduct(amount)
    @balance -= amount
  end
end

oc = OysterCard.new
s1 = Station.new(:XX)
s2 = Station.new(:YY)

oc.top_up(20)
oc.touch_in(s1)
oc.touch_out(s2)
oc.touch_in(s2)
oc.touch_out(s1)
oc.touch_in(s1)
oc.touch_out(s2)
oc.touch_in(s2)
oc.touch_out(s1)

puts oc.log.history
