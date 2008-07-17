require File.dirname(__FILE__) + '/../test_helper'
require 'columns_controller'

# Re-raise errors caught by the controller.
class ColumnsController; def rescue_action(e) raise e end; end

class ColumnsControllerTest < Test::Unit::TestCase
  fixtures :columns

  def setup
    @controller = ColumnsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = columns(:first).id
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

    assert_not_nil assigns(:columns)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:column)
    assert assigns(:column).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:column)
  end

  def test_create
    num_columns = Column.count

    post :create, :column => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_columns + 1, Column.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:column)
    assert assigns(:column).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Column.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Column.find(@first_id)
    }
  end
end
