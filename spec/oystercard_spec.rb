require '/Users/harryjames/Documents/MA/Projects/oystercard_challenge/lib/oystercard.rb'
require 'date'

date = Date.today.strftime('%F').split('-').reverse.join('-')

describe OysterCard do
  let(:mock_station) { double :station, station_id: :AB, zone: 1 }

  it "sets the maximum balance to #{OysterCard::MAX_BALANCE}" do
    expect { subject.top_up(100) }.to raise_error 'Balance can\'t be greater than £90.'
  end

  it 'initiates with an empty journey log' do
    expect(subject.journey_log.log.empty?).to be true
  end

  describe '#balance' do
    it 'has a starting balance of 0 by default' do
      expect(subject.balance).to eq 0
    end

    it 'can be initiated with credit' do
      oc = OysterCard.new(27)
      expect(oc.balance).to eq 27
    end

    it 'does not let you travel with a balance below the minimum fare' do
      expect { subject.touch_in(mock_station) }.to raise_error('Balance not high enough.')
    end
  end

  context 'with £10 already added' do
    before(:each) do
      subject.top_up(10)
    end

    describe '#top_up do' do
      it 'tops up by given amount' do
        subject.top_up(10)
        expect(subject.balance).to eq 20
      end
    end
  
    describe '#deduct' do
      it 'reduces the balance by a specified amount' do
        expect{subject.send(:deduct, 3)}.to change{subject.balance}.by (-3)
      end
    end

    describe '#touch_out' do
      it 'deducts a fare from the card balance on touch out' do
        expect { subject.touch_out(mock_station) }.to change { subject.balance }.by(-Journey::MIN_FARE)
      end

      it 'records the exit station id' do
        subject.touch_out(mock_station)
        expect(subject.journey_log.out).to eq :AB
      end
    end
   
    describe '#touch_in' do
      it 'raises error if balance os too low to travel' do
        oc = OysterCard.new
        expect{ oc.touch_in(mock_station) }.to raise_error('Balance not high enough.')
      end
    end
  end
end