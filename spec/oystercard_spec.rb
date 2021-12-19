require 'oystercard'
require 'station'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }


  it 'checks balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journey).to be_empty
  end

  # it "responds to journey" do
  #   expect(subject).to respond_to (:journey)
  # end

  describe '#tops_up' do
    it 'tops up the balance' do
      expect(subject).to respond_to(:top_up)
    end
    it 'tops up the balance by 5' do
      expect { subject.top_up(5) }.to change { subject.balance }.from(0).to(5)
    end
    it 'prevents top up above max limit' do
      subject.top_up(Oystercard::DEFAULT_LIMIT)
      expect { subject.top_up(1) }.to raise_error "Max limit of #{subject.limit} reached"
    end
  end

  describe '#deducts' do
    it 'deducts balance by amount' do
      subject.balance = Oystercard::MINIMUM_FARE
      expect { subject.send(:deduct, Oystercard::MINIMUM_FARE) }.to change { subject.balance }.by(-1)
    end
  end

  describe '#in_journey' do
    it 'checks if card is in_journey' do
      expect(subject).to respond_to(:in_journey?)
    end

    context 'touches in to station' do
      it 'succesfully' do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(entry_station)
        expect(subject.in_journey?).to eq true
      end
      it 'requiring minimum balance' do
        expect { subject.touch_in(entry_station) }.to raise_error 'Min balance of £1 required'
      end

      it 'card saves entry_station' do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end
    end

    context 'touches out of station' do
      it 'successful' do
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq false
      end

      it 'deduction of balance by fare' do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-(Oystercard::MINIMUM_FARE))
      end

      it 'card saves exit_station' do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_out(:station)
        expect(subject.exit_station).to eq nil
      end
    end
  end

  describe '#add_journey' do
    it 'saves journey to journey_history' do 
      subject.balance = Oystercard::DEFAULT_LIMIT
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to_not contain_exactly(
        {:entry_station=> entry_station}, 
        {:exit_station=> exit_station})
    end
  end
end

describe Station do 
  let(:name) {'Angel'}
  let(:zone) {1}

  it 'is initialised' do 
    arrival = Station.new(name: name, zone: zone)
    expect(arrival.name).to eq "Angel"
    expect(arrival.zone).to eq 1
  end
end 
