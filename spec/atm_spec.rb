require './lib/atm.rb'
require 'date'
require 'debugger'

describe Atm do

  let(:account) { instance_double('Account', :pin_code => '1234', :exp_date => '04/17')}

  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
  end

  it 'has $1000 on initialize' do
    expect(subject.funds).to eq(1000)
  end

  it 'funds are reduced at withdraw' do
    debugger
    subject.withdraw(50,'1234','04/17', account)
    expect(subject.funds).to eq(950)
  end


it 'allow withdraw if account has enough balance' do
  amount = 45
  expected_output = {:status =>true, :message => 'success', :date => Date.today, :amount => amount}
  expect(subject.withdraw(45, '1234','04/17', account)).to eq expected_output
end

it 'reject withdraw if account has sufficient funds' do
  expected_output = {:status => true, :message => 'insufficient funds', :date => Date.today}
  expect(subject.withdraw(105,'1234', '04/17',account)).to eq expected_output
end

it 'rejects withdraw if ATM has insufficient funds' do
  subject.funds = 50
  expected_output = {:status => false, :message => 'insufficient funds in ATM', :date => Date.today}
  expect(subject.withdraw(100, '1234', '04/17', account)).to eq expected_output
end

it 'reject withdraw if pin is wrong' do
    expected_output = {:status => false, :message => 'wrong pin', :date => Date.today}
    expect(subject.withdraw(50, 9999, '04/17', account)).to eq(expected_output)
end

it 'rejects withdraw if card is expired' do
  allow(account).to receive(:exp_date).and_return('12/15')
  expected_output = {:status => false, :message => 'card expired', :date => Date.today}
  expect(subject.withdraw(6, '1234', '12/15',account)).to eq (expected_output)
end
end
