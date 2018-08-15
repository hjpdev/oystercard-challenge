require 'station'

describe Station do

  it 'has an associated zone number, that defaults to 1' do
    expect(subject.zone_number).to eq 2
  end

  it 'has an associated station_id, that defaults to :AB' do
    expect(subject.station_id).to eq :AB
  end
end