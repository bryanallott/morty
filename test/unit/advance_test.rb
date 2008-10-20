require 'test_helper'
require 'type'

class AdvanceTest < ActiveSupport::TestCase
  
  def test_advance_creates_a_saving
    lut = Loan.new(:start=>'1Jun2007', :principal=>350000, :annual_interest=>12, :compounding_periods=>240)
    lut.save
    assert_equal 928766.15, lut.total_payments.precision(2)
    advance = Advance.new(:when=>'1Aug2007', :amount=>20000)
    advance.save
    lut.advances << advance
    lut.save
    assert_equal 755345.09, lut.total_payments.precision(2)
  end
  def test_advance_keep_same_period
    lut = Loan.new(:start=>'1Jun2007', :principal=>350000, :annual_interest=>12, :compounding_periods=>240)
    lut.save
    assert_equal (3853.80).to_f, lut.repayment.precision(2)
    assert_equal 350000.00, lut.schedules.first.existing_capital.precision(2)
    assert_equal 349646.20, lut.schedules[1].existing_capital.precision(2)
    assert_equal 349288.86, lut.schedules[2].existing_capital.precision(2)

    advance = Advance.new(:when=>'1Aug2007', :amount=>20000)
    assert_equal 240, lut.schedules.length
    advance.save
    lut.advances << advance
    lut.save
    
    lut = Loan.find(lut.id)
    assert_equal 196, lut.schedules.length

    puts "period___\texisting_capital\tinterest_paid\tcapital_paid\r\n"  
    lut.schedules.each_with_index { |s, idx|
      puts "#{s.period}\t#{s.existing_capital.display}\t#{s.interest_paid.display}\t#{s.capital_paid.display}\r\n"  
      break if(3<idx) 
    }

    assert_equal 350000.00, lut.schedules[0].existing_capital.precision(2)
    assert_equal 349646.20, lut.schedules[1].existing_capital.precision(2)
    assert_equal 329288.86, lut.schedules[2].existing_capital.precision(2)
    assert_equal 328727.95, lut.schedules[3].existing_capital.precision(2)
    assert_equal (3853.80).to_f, lut.repayment.precision(2)
  end
  def test_advance_keep_same_repayment
=begin
    start loan
    add advance but keep same repayment
    calculate new repayment period
=end
  end
end
