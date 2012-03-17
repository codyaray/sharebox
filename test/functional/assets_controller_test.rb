require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Asset.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Asset.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Asset.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to asset_url(assigns(:asset))
  end

  def test_edit
    get :edit, :id => Asset.first
    assert_template 'edit'
  end

  def test_update_invalid
    Asset.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Asset.first
    assert_template 'edit'
  end

  def test_update_valid
    Asset.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Asset.first
    assert_redirected_to asset_url(assigns(:asset))
  end

  def test_destroy
    asset = Asset.first
    delete :destroy, :id => asset
    assert_redirected_to assets_url
    assert !Asset.exists?(asset.id)
  end
end
