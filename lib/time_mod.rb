module TimeMod
  def time
    hour + minute
  end

  def peak?(time)
    return true if time > '0629' && time < '0931'
    return true if time > '1559'&& time < '1901'
    false
  end

  private

  def hour
    h = rand(24)
    h.to_s[1].nil? ? ("0" + h.to_s) : h.to_s
  end

  def minute
    m = rand(60)
    m.to_s[1].nil? ? ("0" + m.to_s) : m.to_s
  end
end