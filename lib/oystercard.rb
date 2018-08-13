class OysterCard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
  end

  def in_journey?
    @entry_station ? true : false
  end

  def top_up(amount)
    raise "Balance can't be greater than £#{MAX_BALANCE}." if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance not high enough.' if @balance < MINIMUM_FARE
    @entry_station = station.station_id
    @in_journey = true
  end

  def touch_out(station)
    @exit_station = station.station_id
    @balance -= MINIMUM_FARE
    @entry_station = nil
    @in_journey = false
  end

private

  def deduct(amount)
    @balance -= amount
  end
end
