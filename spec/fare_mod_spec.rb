require 'fare_mod'

describe FareMod do
  let(:dummy_class) { Class.new { include FareMod } }
  let(:subject) { dummy_class.new }

  context 'Peak' do
      it 'calculates correct fare for just zone 1' do
      expect(subject.peak_price('1')).to eq 2.4
      end

      it 'calculates the correct fare for zones 1-2' do
        expect(subject.peak_price('1-2')).to eq 2.9
      end

      it 'calculates the correct fare for zones 1-3' do
        expect(subject.peak_price('1-3')).to eq 3.3
      end

      it 'claculates the correct fare zones 1-4' do
        expect(subject.peak_price('1-4')).to eq 3.9
      end

      it 'calculates the correct fare zones 1-5' do
        expect(subject.peak_price('1-5')).to eq 4.7
      end

      it 'calculates the correct fare for zones 1-6' do
        expect(subject.peak_price('1-6')).to eq 5.1
      end

      it 'calculates the correct fare for zones 2-6' do 
        expect(subject.peak_price('2-6')).to eq 2.8
      end
    end

    context 'Offpeak' do
      it 'calculates correct fare for just zone 1' do
      expect(subject.off_peak_price('1')).to eq 2.4
      end

      it 'calculates the correct fare for zones 1-2' do
        expect(subject.off_peak_price('1-2')).to eq 2.4
      end

      it 'calculates the correct fare for zones 1-3' do
        expect(subject.off_peak_price('1-3')).to eq 2.8
      end

      it 'claculates the correct fare zones 1-4' do
        expect(subject.off_peak_price('1-4')).to eq 2.8
      end

      it 'calculates the correct fare zones 1-5' do
        expect(subject.off_peak_price('1-5')).to eq 3.1
      end

      it 'calculates the correct fare for zones 1-6' do
        expect(subject.off_peak_price('1-6')).to eq 3.1
      end

      it 'calculates the correct fare for zones 2-6' do 
        expect(subject.off_peak_price('2-6')).to eq 1.5
      end
    end
  end

