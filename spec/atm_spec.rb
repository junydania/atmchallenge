require './lib/atm.rb'
require 'date'

describe Atm do
  it 'has $1000 on initialize' do
    expect(subject.funds).to eq(1000)
  end

  it 'funds are reduced at withdraw' do
    subject.withdraw(50, account)
    expect(subject.funds).to eq(950)
  end


let(:account) { instance_double('Account')}

before do
  allow(account).to receive(:balance).and_return(100)
  allow(account).to receive(:balance=)
end

it 'allow withdraw if account has enough balance' do
  expected_output = {:status => true, :message => 'success', :date => Date.today, :amount => 45}
  expect(subject.withdraw(45, account)).to eq expected_output

end


end
