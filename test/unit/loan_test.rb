require 'test_helper'
require 'type'

class LoanTest < ActiveSupport::TestCase

  def test_create_overload
    loan = Loan.new(:start=>"1Jun2007", :principal=>350000, :annual_interest=>12, :compounding_periods=>240)
    assert_equal Date.parse("1Jun2007"), loan.start
    assert_equal 350000, loan.principal
    assert_equal 12, loan.annual_interest
    assert_equal 240, loan.compounding_periods
  end
  def test_total_payments
    loan = loans(:two)
    assert_equal 108309.97, loan.total_payments.precision(2)
  end
  def test_total_interest
    loan = loans(:two)
    assert_equal 8309.97, loan.total_interest.precision(2)
  end
  def test_repayment
    loan = loans(:one)
    assert_equal 2083.47, loan.repayment.precision(2)
  end
end
