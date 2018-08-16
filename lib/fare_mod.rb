module FareMod
  FARES = {"1"=>[2.4, 2.4], "1-2"=>[2.9, 2.4], 
          "1-3"=>[3.3, 2.8], "1-4"=>[3.9, 2.8],
          "1-5"=>[4.7, 3.1], "1-6"=>[5.1, 3.1],
          "2-6"=>[2.8, 1.5]}

  def peak_price(array)
    FARES[zones_to_key(array)][0]
  end

  def off_peak_price(array)
    FARES[zones_to_key(array)][1]
  end

  private
  def zones_to_key(array)
    return "2-6" if array[0] != 1 && array[1] != 1
    return "1" if array[0] == 1 && array[1] == 1
    FARES.keys[(array.max)-1]
  end
end