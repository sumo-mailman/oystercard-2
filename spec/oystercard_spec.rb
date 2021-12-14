require 'oystercard'
require 'station'

describe Oystercard do

  it "checks balance" do
    expect(subject).to respond_to(:balance)
  end

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
      subject.top_up(5)
      expect { subject.send(:deduct, Oystercard::MINIMUM_FARE) }.to change { subject.balance }.from(5).to(4)
    end
  end

  describe "#in_journey" do
    it "checks if card is in_journey" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "touches in" do
      subject.top_up(5)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "touches out" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end

    it "touchs in and requires minimum balance" do
      expect {subject.touch_in}.to raise_error "Min balance of £1 required"
    end

    it "touches out and minimum fare" do
      subject.top_up(5)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by(-1)
    end
  end
end


describe Station do 
end