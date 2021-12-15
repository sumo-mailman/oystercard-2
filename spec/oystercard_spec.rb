require 'oystercard'
require 'station'

describe Oystercard do

  let(:station) { double :station }
  let(:station) { double :station }

  it "checks balance" do
    expect(subject).to respond_to(:balance)
  end

  # it "responds to journey" do 
  #   expect(subject).to respond_to (:journey)
  # end
  

  describe "#tops_up" do
    it "tops up the balance" do 
      expect(subject).to respond_to(:top_up)
    end
    it "tops up the balance by 5" do  
      expect { subject.top_up(5) }.to change { subject.balance }.from(0).to(5)
    end
    it "prevents top up above max limit" do
      expect {subject.top_up(91)}.to raise_error "Max limit of #{subject.limit} reached"
    end
  end

  describe "#deducts" do
    it "deducts balance by amount" do
      subject.balance = Oystercard::MINIMUM_FARE
      expect { subject.send(:deduct, Oystercard::MINIMUM_FARE) }.to change { subject.balance }.by(-1)
    end
  end

  describe "#in_journey" do
    it "checks if card is in_journey" do
      expect(subject).to respond_to(:in_journey?)
    end
    
    context "touches in to station" do

      it "succesfully" do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
      it "requiring minimum balance" do
        expect {subject.touch_in(station)}.to raise_error "Min balance of £1 required"
      end

      it "card saves entry_station" do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    context "touches out of station" do
      it "successful" do
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
      it "deduction of balance by fare" do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change{ subject.balance }.by(-1)
      end

      it "card saves exit_station" do
        subject.balance = Oystercard::MINIMUM_FARE
        subject.touch_out(station)
        expect(subject.exit_station).to eq station
      end

      it "saves the entry/exit as a journey"do
      subject.balance = Oystercard::MINIMUM_FARE
      subject.touch_in(station)
      subject.touch_out(station)  
      expect(subject.journey).to include(
        :entry_station => station,
        :exit_station => station
      )
    end
    end
  end
end


describe Station do 
end