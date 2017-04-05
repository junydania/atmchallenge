require 'date'

class Account
  attr_accessor :pin_code, :balance, :account_status,  :owner
  attr_reader :exp_date

  STANDARD_VALIDITY_YRS = 5

  def initialize
    @pin_code = generate_pin
    @balance = 500
    #@account_status = :active
    #@owner
    @exp_date = set_expire_date
  end

private

def generate_pin
  rand(1000..9999)
end


def set_expire_date
  Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%Y')
end







end
