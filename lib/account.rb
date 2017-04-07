require 'date'

class Account
  attr_accessor :pin_code, :balance, :account_status,  :owner
  attr_reader :exp_date

  STANDARD_VALIDITY_YRS = 5

  def initialize(attrs = {})
    @pin_code = generate_pin
    @balance = 0
    @account_status = :active
    set_owner(attrs[:owner])
    @exp_date = set_expire_date
  end

  def deactivate
    @account_status = :deactivated
  end


private

def set_owner(obj)
  obj == nil ? missing_owner : @owner = obj
end

def missing_owner
  raise "An Account owner is required."
end

def generate_pin
  rand(1000..9999)
end


def set_expire_date
  Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%Y')
end

end
