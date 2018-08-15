module FareMod

  FARES = {"1"=>[2.4, 2.4], "1-2"=>[2.9, 2.4], 
          "1-3"=>[3.3, 2.8], "1-4"=>[3.9, 2.8],
          "1-5"=>[4.7, 3.1], "1-6"=>[5.1, 3.1],
          "2-6"=>[2.8, 1.5]}

  def peak_price(zones)
    fares.select { |k, v| k == zones }.values.flatten.first
  end

  def fares
    FARES
  end

  def off_peak_price(zones)
    fares.select { |k, v| k == zones }.values.flatten.last
  end

  def index_of(string)
    index = FARES.keys.index(string)
  end

  def keys
    FARES.keys
  end
end

# class NC
#   include FareMod
# end

# nc = NC.new

