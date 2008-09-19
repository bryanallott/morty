module SchedulesHelper
  def plot_existing_capital(loan)
    result = ""
  	loan.schedules.each_with_index { |s, idx|
  	  result << "[#{idx}, #{s.existing_capital}]"
      result << "," unless s == loan.schedules.last
  	}
  	result
  end
  def plot_interest_paid(loan)
    sum = 0
    result = ""
  	loan.schedules.each_with_index { |s, idx|
  	  result << "[#{idx}, #{sum}]"
      result << "," unless s == loan.schedules.last
      sum += s.interest_paid
  	}
  	result
  end
  def plot_interest_remaining(loan)
    sum = 0
    result = ""
  	loan.schedules.each_with_index { |s, idx|
  	  result << "[#{idx}, #{loan.total_interest-sum}]"
      result << "," unless s == loan.schedules.last
      sum += s.interest_paid
  	}
  	result
  end
  def plot_capital_sum(loan)
    sum = 0
    result = ""
  	loan.schedules.each_with_index { |s, idx|
  	  result << "[#{idx}, #{sum}]"
      result << "," unless s == loan.schedules.last
  	  sum += s.capital_paid
  	}
  	result
  end
end
