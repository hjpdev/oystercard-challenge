require 'journey_log'
require 'date'

def date
  Date.today.strftime('%F').split('-').reverse.join('-')
end

describe JourneyLog do
  let(:mock_info) { double :journey, { in: :XX, out: :YY } }
  let(:mock_station1) { double :station, station_id: :AA, zone: 1 }
  let(:mock_station2) { double :station, station_id: :BB, zone: 2 }

  describe '#start' do
    it 'sets the @in instance variable to entry station' do
      subject.start(mock_station1)
      expect(subject.in).to eq :AA
    end
  end

  describe '#journeys' do
    it 'holds a list of previous journeys' do
      subject.start(mock_station1)
      subject.finish(mock_station2)
      expect(subject.journeys).to eq [{ date: date, in: :AA, out: :BB }]
    end
  end
end