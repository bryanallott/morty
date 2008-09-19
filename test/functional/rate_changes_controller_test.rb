require 'test_helper'

class RateChangesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rate_changes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_rate_change
    assert_difference('RateChange.count') do
      post :create, :rate_change => { }
    end

    assert_redirected_to rate_change_path(assigns(:rate_change))
  end

  def test_should_show_rate_change
    get :show, :id => rate_changes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => rate_changes(:one).id
    assert_response :success
  end

  def test_should_update_rate_change
    put :update, :id => rate_changes(:one).id, :rate_change => { }
    assert_redirected_to rate_change_path(assigns(:rate_change))
  end

  def test_should_destroy_rate_change
    assert_difference('RateChange.count', -1) do
      delete :destroy, :id => rate_changes(:one).id
    end

    assert_redirected_to rate_changes_path
  end
end
