class Loan < ActiveRecord::Base
  has_many :schedules
  has_many :advances
  has_many :rate_changes

  def repayment
    if(!@monthly_repayment)
      @monthly_repayment = calculate_repayment
    end
    return @monthly_repayment
  end
  
  def future_value
    if(!@future_value)
      @future_value = calculate_future_value
    end
    return @future_value
  end

  def total_payments
    return self.schedules.inject(0) { |result, s| result + s.repayment }
  end

  def total_interest
    return (total_payments - self.principal)
  end

  def after_save
    Schedule.find_all_by_loan_id(self.id).each {|s| s.destroy }
    create_schedules
  end
  
private  
  def calculate_future_value
    interest = self.annual_interest/100.0/12.0
    a = (1+interest)**self.compounding_periods
    return self.repayment*((a-1)/interest)
  end
  
  def calculate_repayment
    interest = self.annual_interest/100.0/12.0
    a = (1+interest)**self.compounding_periods
    return self.principal/((a-1)/(a*interest))
  end
  def create_schedules
    repayment = self.repayment
    existing_capital = self.principal
    interest = self.annual_interest/100.0/12.0
    capital_paid = 0
    start_date = Date.new(self.start.year, self.start.month, 1)
    month = 0
    (1..self.compounding_periods).each { |p|
      from = Date.new(start_date.year, start_date.month, 1) >> month
      to = Date.new(from.year, from.month, -1)
      advances = self.advances.find(:all, :conditions => ["[when] between :from and :to", { :from => from, :to => to }])
      advances.each { |a|
        existing_capital -= a.amount 
        capital_paid += a.amount
      }
      interest_earned = existing_capital*(1 + interest) - existing_capital
      if(repayment>interest_earned)
        interest_paid = interest_earned
      else
        interest_paid = repayment
      end
      capital_paid = (repayment-interest_paid)
      Schedule.new(:loan=>self, :period=>(to), :existing_capital=>existing_capital, :interest_earned=>interest_earned, :repayment=>repayment, :interest_paid=>interest_paid, :capital_paid=>capital_paid).save!
      existing_capital -= capital_paid
      if(existing_capital<=0)
        break
      end
      month += 1
    }
  end
end