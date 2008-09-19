require 'test_helper'

class AdvancesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:advances)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_advance
    assert_difference('Advance.count') do
      post :create, :advance => { }
    end

    assert_redirected_to advance_path(assigns(:advance))
  end

  def test_should_show_advance
    get :show, :id => advances(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => advances(:one).id
    assert_response :success
  end

  def test_should_update_advance
    put :update, :id => advances(:one).id, :advance => { }
    assert_redirected_to advance_path(assigns(:advance))
  end

  def test_should_destroy_advance
    assert_difference('Advance.count', -1) do
      delete :destroy, :id => advances(:one).id
    end

    assert_redirected_to advances_path
  end
end
