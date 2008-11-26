require 'test_helper'

class SavingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:savings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_savings
    assert_difference('Savings.count') do
      post :create, :savings => { }
    end

    assert_redirected_to savings_path(assigns(:savings))
  end

  def test_should_show_savings
    get :show, :id => savings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => savings(:one).id
    assert_response :success
  end

  def test_should_update_savings
    put :update, :id => savings(:one).id, :savings => { }
    assert_redirected_to savings_path(assigns(:savings))
  end

  def test_should_destroy_savings
    assert_difference('Savings.count', -1) do
      delete :destroy, :id => savings(:one).id
    end

    assert_redirected_to savings_path
  end
end
