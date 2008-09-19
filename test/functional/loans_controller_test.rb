require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_loan
    assert_difference('Loan.count') do
      post :create, :loan => { }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  def test_should_show_loan
    get :show, :id => loans(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => loans(:one).id
    assert_response :success
  end

  def test_should_update_loan
    put :update, :id => loans(:one).id, :loan => { }
    assert_redirected_to loan_path(assigns(:loan))
  end

  def test_should_destroy_loan
    assert_difference('Loan.count', -1) do
      delete :destroy, :id => loans(:one).id
    end

    assert_redirected_to loans_path
  end
end
