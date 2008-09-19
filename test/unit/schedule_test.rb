require 'test_helper'
require 'type'

class ScheduleTest < ActiveSupport::TestCase
  def test_schedules
    loan = loans(:two)
    loan.save
    assert_equal 12, loan.schedules.length
    assert_equal 7775.83, loan.schedules.first.capital_paid.precision(2)
    assert_equal 8914.40, loan.schedules.last.capital_paid.precision(2)
  end
  def test_print_schedule
    lut = Loan.new(:start=>'1Jan2007', :principal=>100000, :annual_interest=>15, :compounding_periods=>12)
    lut.save
    puts "period___\texisting_capital\tinterest_paid\tcapital_paid\r\n"  
    lut.schedules.each { |s|
      puts "#{s.period}\t#{s.existing_capital.display}\t#{s.interest_paid.display}\t#{s.capital_paid.display}\r\n"  
    }
  end
end
