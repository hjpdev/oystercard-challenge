require 'journey'

describe Journey do
  let(:oc) { double :oystercard }
  let(:st1) { double :station, station_id: :AB, zone: 1 }
  let(:st2) { double :station, station_id: :XY, zone: 2 }
  let(:st3) { double :station, station_id: :XX, zone: 3 }
  let(:st6) { double :station, station_id: :XI, zone: 6 }

  describe '#start' do
    it 'should start a journey' do
      expect(subject.start(st1)).to eq 1
    end
  end

  describe '#finish' do
    it 'should finish a journey' do
      subject.start(st1)
      expect(subject.finish(st2)).to eq 2
    end
  end

  describe '#fare' do
    it 'should calculate the correct fare, 1-3' do
      subject.start(st3)
      subject.finish(st1)
      expect(subject.peak_price([st3.zone, st1.zone])).to eq 3.3
    end

    it 'should calculate the correct fare, 2-6' do
      subject.start(st2)
      subject.finish(st6)
      expect(subject.peak_price([st2.zone, st6.zone])).to eq 2.8
    end

    it 'should calculate the correct fare, 1-6' do
      subject.start(st1)
      subject.finish(st6)
      expect(subject.peak_price([st1.zone, st6.zone])).to eq 5.1
    end

    it 'charges a penalty fare if no exit station is given' do
      subject.start(st1)
      subject.fare
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end