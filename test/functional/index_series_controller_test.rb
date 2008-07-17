require File.dirname(__FILE__) + '/../test_helper'
require 'index_series_controller'

# Re-raise errors caught by the controller.
class IndexSeriesController; def rescue_action(e) raise e end; end

class IndexSeriesControllerTest < Test::Unit::TestCase
  fixtures :index_series

  def setup
    @controller = IndexSeriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = index_series(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:index_series)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:index_series)
    assert assigns(:index_series).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:index_series)
  end

  def test_create
    num_index_series = IndexSeries.count

    post :create, :index_series => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_index_series + 1, IndexSeries.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:index_series)
    assert assigns(:index_series).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      IndexSeries.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      IndexSeries.find(@first_id)
    }
  end
end
