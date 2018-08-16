class Station
  attr_reader :station_id, :zone

  def initialize(station_id=:AB, zn=2)
    @station_id = station_id
    @zone = zn
  end
end