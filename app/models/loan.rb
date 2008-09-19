class Loan < ActiveRecord::Base
  has_many :schedules
  has_many :advances
  has_many :rate_changes
  @monthly_repayment

  def repayment
    if(!@monthly_repayment)
      @monthly_repayment = calculate_repayment(self.annual_interest, self.compounding_periods, self.principal)
    end
    return @monthly_repayment
  end

  def total_payments
    return (repayment * self.compounding_periods)
  end

  def total_interest
    return (total_payments - self.principal)
  end

  def after_save
    Schedule.find_all_by_loan_id(self.id).each {|s| s.destroy }
    create_schedules
  end
  
private  
  def calculate_repayment(annual_interest, compounding_periods, principal)
    interest = annual_interest/100.0/12.0
    a = (1+interest)**compounding_periods
    return principal/((a-1)/(a*interest))
  end
  def create_schedules
    repayment = self.repayment
    existing_capital = self.principal
    interest = self.annual_interest/100.0/12.0
    #document the start of the loan agreement
    #Schedule.new(:loan=>self, :period=>(self.start), :existing_capital=>existing_capital, :interest_earned=>0, :repayment=>repayment, :interest_paid=>0, :capital_paid=>0).save
          
    month = 0
    (1..self.compounding_periods).each { |p|
      advance = self.advances.find_by_when(self.start >> month)
      if(advance)
        existing_capital -= advance.amount 
      end
      interest_earned = existing_capital*(1 + interest) - existing_capital
      if(repayment>interest_earned)
        interest_paid = interest_earned
      else
        interest_paid = repayment
      end
      capital_paid = repayment-interest_paid
      Schedule.new(:loan=>self, :period=>(self.start>>p), :existing_capital=>existing_capital, :interest_earned=>interest_earned, :repayment=>repayment, :interest_paid=>interest_paid, :capital_paid=>capital_paid).save!
      existing_capital -= capital_paid
      if(existing_capital<=0)
        break
      end
      month += 1
    }
  end
end