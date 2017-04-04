class Atm

  attr_accessor :funds

  def initialize
    @funds = 1000
  end


  def withdraw(amount, pin_code,exp_date,account_status,account)

    case

    when insufficient_funds_in_account?(amount,pin_code,account)

      {:status =>true, :message => 'insufficient funds', :date => Date.today}

    when insufficient_funds_in_atm?(amount,pin_code,account)

      {:status => false, :message => 'insufficient funds in ATM', :date => Date.today}

    when incorrect_pin?(pin_code, account.pin_code)
      {:status => false, :message => 'wrong pin', :date => Date.today}

    when card_expired?(account.exp_date)
      {:status => false, :message => 'card expired', :date => Date.today}

    when account_disabled?(account_status)
      {:status => false, :message => 'Account disabled', :date => Date.today }

    else

      perform_transaction(amount, pin_code, account)

    end
  end

  private

  def insufficient_funds_in_account?(amount, pin_code, account)
    amount > account.balance
  end

  def perform_transaction(amount, pin_code,account)
    @funds -= amount
    account.balance = account.balance - amount
    {:status =>true, :message => 'success', :date => Date.today, :amount => amount}

  end

  def insufficient_funds_in_atm?(amount, pin_code,account)
    @funds < amount
  end

  def incorrect_pin?(pin_code, actual_pin)
    pin_code != actual_pin
  end

  def card_expired?(exp_date)
    # binding.pry
    m, y = exp_date.split("/")
    expiry_date = Date.new(y.to_i, m.to_i, -1)
    expiry_date < Date.today
  end

  def account_disabled?(account_status)
    account_status == :disabled
  end

end
