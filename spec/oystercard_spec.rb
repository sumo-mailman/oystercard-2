require 'oystercard'

describe Oystercard do
  it "checks balance" do
    expect(subject).to respond_to(:balance)
  end

  it "tops up the balance" do 
    expect(subject).to respond_to(:top_up)
  end
end