
require './lib/account.rb'
require 'date'
require 'pry-byebug'

describe Account do
  let (:person) {instance_double ('Person'), :name => 'Dania'}
  subject {described_class.new({:owner => person})}

  it 'checks the length of a number' do
    pin_length = Math.log10(subject.pin_code).to_i + 1
    expect(pin_length).to eq 4
  end

  it 'is expected to have a balance of 0 on initilize' do
    expect(subject.balance).to eq 0
  end

  it 'deactivates account' do
    subject.deactivate
    expect(subject.account_status).to eq :deactivated
  end

  it 'is expected to have an owner' do
    expect(subject.owner).to eq person
  end

  it'is expected to raise error if no owner is set' do
    expect { described_class.new }.to raise_error 'An Account owner is required.'
  end

end
