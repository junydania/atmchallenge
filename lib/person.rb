require 'date'
require 'pry-byebug'
require 'account.rb'
require 'atm.rb'

class Person

  attr_accessor :name, :account, :cash

  def initialize(record= {})

    @name = set_name(record [:name])
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

  def missing_account
    raise 'No account present'
  end
end
