
require './lib/account.rb'
require 'date'
require 'pry-byebug'

describe Account do
  let (:person) {instance_double ('Person'), :name => 'Dania'}

  it 'checks the length of a number' do
    pin_length = Math.log10(subject.pin_code).to_i + 1
    expect(pin_length).to eq 4
  end

  it 'is expected to have a balance of 0 on initilize' do
    expect(subject.balance).to eq 500
  end
end
