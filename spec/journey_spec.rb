require 'journey'

describe Journey do
  let(:oc) { double :oystercard }
  let(:st1) { double :station, station_id: :AB, zone: 1 }
  let(:st2) { double :station, station_id: :XY, zone: 2 }
  let(:st3) { double :station, station_id: :XX, zone: 3 }
  let(:st6) { double :station, station_id: :XI, zone: 6 }

  describe '#start' do
    it 'should start a journey' do
      subject.start(st1)
      expect(subject.entry_station).to eq :AB
    end
  end

  describe '#finish' do
    it 'should finish a journey' do
      subject.start(st1)
      subject.finish(st2)
      expect(subject.exit_station).to eq :XY
    end
  end

  describe '#calculate_fare' do
    it 'should calculate the correct fare, 1-3' do
      subject.start(st3)
      subject.finish(st1)
      expect(subject.peak_price(subject.format_zones)).to eq 3.3
    end

    it 'should calculate the correct fare, 2-6' do
      subject.start(st2)
      subject.finish(st6)
      expect(subject.peak_price(subject.format_zones)).to eq 2.8
    end

    it 'should calculate the correct fare, 1-6' do
      subject.start(st1)
      subject.finish(st6)
      expect(subject.peak_price(subject.format_zones)).to eq 5.1
    end

    it 'charges a penalty fare if no exit station is given' do
      subject.start(st1)
      subject.calculate_fare
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#format_zones' do
    it 'given two zone numbers, return the key required to get fare' do
      subject.start(st1)
      subject.finish(st6)
      expect(subject.format_zones).to eq '1-6'
    end
  end

  describe '#complete?' do
    it 'should show whether or not the journey is complete' do
      subject.start(st1)
      expect(subject.complete?).to be false
    end
  end
end