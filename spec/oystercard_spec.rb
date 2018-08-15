require '/Users/harryjames/Documents/MA/Projects/oystercard_challenge/lib/oystercard.rb'

describe OysterCard do
  let(:mock_station) { double :station, station_id: :AB }

  it 'sets the maximum balance to 90' do
    expect { subject.top_up(100) }.to raise_error 'Balance can\'t be greater than £90.'
  end

  it 'initiates with an empty journey log' do
    expect(subject.journey_history).to eq []
  end

  describe '#balance' do
    it 'has a starting balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'does not let you travel with a balance below the minimum fare' do
      expect { subject.touch_in(mock_station) }.to raise_error('Balance not high enough.')
    end
  end

  context 'with £10 already added' do
    before(:each) do
      subject.top_up(10)
    end

    describe '#in_journey?' do
      
      it 'returns true if an entry station is registered' do
        subject.touch_in(mock_station)
        expect(subject.in_journey?).to be true
      end

      it 'returns false if an entry station is not registered' do
        expect(subject.in_journey?).to be false
      end
    end

    describe '#top_up do' do
      it 'tops up by given amount' do
        subject.top_up(10)
        expect(subject.balance).to eq 20
      end
    end
  
    describe '#deduct' do
      it 'reduces the balance by a specified amount' do
        subject.send(:deduct, 3)
        expect(subject.balance).to eq 7
      end
    end
  
    describe '#touch_in' do

      it 'registers the oystercard as in a journey after touch_in' do
        subject.touch_in(mock_station)
        expect(subject.in_journey?).to be true
      end
    end

    describe '#touch_out' do

      it 'checks if the oystercard is in a journey after touch_out' do
        subject.touch_out(mock_station)
        expect(subject.in_journey?).to be false
      end

      it 'deducts a fare from the card balance on touch out' do
        expect { subject.touch_out(mock_station) }.to change { subject.balance }.by(-OysterCard::MINIMUM_FARE)
      end

      it 'records the exit station id' do
        subject.touch_out(mock_station)
        expect(subject.log.exit_station).to eq :AB
      end

      it 'sets the entry_station variable to nil on exit' do
        subject.touch_out(mock_station)
        expect(subject.entry_station).to be nil
      end

      it 'creates a hash of the journey information' do
        subject.touch_in(mock_station)
        subject.touch_out(mock_station)
        expect(subject.journey_history).to eq [{in: :AB, out: :AB}]
      end
    end
  end
end