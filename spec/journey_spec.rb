require 'journey'

describe Journey do
  let(:oc) { double :oystercard }
  let(:st1) { double :station, station_id: :AB, zone_number: 1 }
  let(:st2) { double :station, station_id: :XY, zone_number: 1 }

  it 'should start a journey' do
    subject.start(st1)
    expect(subject.entry_station).to eq :AB
  end

  it 'should finish a journey' do
    subject.start(st1)
    subject.finish(st2)
    expect(subject.exit_station).to eq :XY
  end

  it 'should calculate the correct fare' do
    subject.start(st1)
    subject.finish(st2)
    subject.calculate_fare
    expect(subject.fare).to be 1
  end

  it 'should show whether or not the journey is complete' do
    subject.start(st1)
    expect(subject.complete?).to be false
  end

  it 'charges a penalty fare if no exit station is given' do
    subject.start(st1)
    subject.calculate_fare
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end