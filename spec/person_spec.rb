require 'date'
require 'pry-byebug'
require 'person'
require './lib/account.rb'
require './lib/atm.rb'

describe Person do
  subject { described_class.new(name: 'Dania') }

  it 'is expected to have a :name on initilize' do
    expect(subject.name).not_to be nil
  end

  it 'is expected to raise error if no name is set' do
    expect { described_class.new }.to raise_error 'An account name is required.'
  end

  it 'is expected to have a :cash attribute of 0 on initilization' do
    expect(subject.cash).to eq 0
  end

  it 'is expected to have a :account attribute' do
    expect(subject.account).to be nil
  end

  describe 'Can create an account' do
    before { subject.create_account }
    it 'an instance of Account class' do
      expect(subject.account).to be_an_instance_of Account
    end

    it 'with himself as owner' do
      expect(subject.account.owner).to be subject
    end
  end

  describe 'can manage funds if an account has been created' do
    let(:atm) { Atm.new }
    before { subject.create_account }

    it 'can deposit funds' do
      expect(subject.deposit(100)).to be_truthy
    end
  end

  describe 'can not manage funds if no account been created' do
    it "can't deposit funds" do
      expect { subject.deposit(100) }.to raise_error(RuntimeError, 'No account present')
    end
  end

  describe 'can manage funds if an account been created' do
    before { subject.create_account }
    it 'funds are added to the account balance and deducted from cash' do
      subject.cash = 100
      subject.deposit(100)
      expect(subject.account.balance).to be 100
      expect(subject.cash).to be 0
    end

    let(:atm) { Atm.new }
    it 'can withdraw funds' do
      command = proc {
        subject.withdraw(
          amount: 100,
          pin: account.pin_code,
          account: subject.account,
          atm: atm
        )
      }
      expect(command.call).to be_truthy
    end

    let(:account) { Account.new(owner: self) }
    it 'withdraw is expected to raise error if no ATM is passed in' do
      execute = proc {
        subject.withdraw(
          amount: 100,
          pin: account.pin_code,
          account: subject.account
        )
      }
      expect { execute.call }.to raise_error 'An ATM is required'
    end

    it 'funds are added to cash - deducted from account balance' do
      subject.cash = 100
      subject.deposit(100)
      subject.withdraw(
        amount: 100,
        pin: account.pin_code,
        account: subject.account,
        atm: atm
      )
      expect(subject.account.balance).to be 0
      expect(subject.cash).to be 100
    end
  end
end
