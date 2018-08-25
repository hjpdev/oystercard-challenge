class Station
  attr_reader :station_id, :name, :zone

  def initialize(station_id=:AB, name = 'unknown', zn=2)
    @station_id = station_id
    @name = name
    @zone = zn
  end
end