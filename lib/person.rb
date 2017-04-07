require 'date'
require 'pry-byebug'
require './account.rb'
require './atm.rb'

class Person

  attr_accessor :name, :account, :cash

  def initialize(record= {})
    @name = set_name(record[:name])
    @cash = 0
    @account = nil
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def deposit(amount)
    if @account == nil
      missing_account
    else
      cash_deposit(amount)
    end

  end

  def withdraw(args = {})
    @account == nil ? missing_account : withdraw_funds(args)
  end

  private

  def set_name(obj)
    if obj == nil
      missing_owner_name
    else
      @name = obj
    end
  end

  def missing_owner_name
    raise 'An account name is required.'
  end

  def cash_deposit(amount)
    @account.balance += amount
    @cash -= amount
  end

  def withdraw_funds(args)
    atm = Atm.new
    args[:atm] == nil ? missing_atm : args[:atm] = atm
    account = @account
    amount = args[:amount]
    pin = args[:pin]
    exp_date = args[:exp_date]
    account_status = args[:account_status]
    response = atm.withdraw(amount, pin, exp_date, account_status, account)
    response[:status] == true ? increase_cash(response) : response
    @account.balance -= amount
    @cash += amount

  end

  def increase_cash(response)
    @cash += response[:amount].to_i
  end

  def missing_account
    raise 'No account present'
  end

  def missing_atm
    raise 'An ATM is required'
  end
end
