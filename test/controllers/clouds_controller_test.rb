require 'test_helper'

class CloudsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cloud = clouds(:one)
  end

  test "should get index" do
    get clouds_url
    assert_response :success
  end

  test "should get new" do
    get new_cloud_url
    assert_response :success
  end

  test "should create cloud" do
    assert_difference('Cloud.count') do
      post clouds_url, params: { cloud: { name: @cloud.name, vendor: @cloud.vendor } }
    end

    assert_redirected_to clouds_url
  end

  test "should get edit" do
    get edit_cloud_url(@cloud)
    assert_response :success
  end

  test "should update cloud" do
    patch cloud_url(@cloud), params: { cloud: { name: @cloud.name, vendor: @cloud.vendor } }
    assert_redirected_to clouds_url
  end

  test "should destroy cloud" do
    assert_difference('Cloud.count', -1) do
      delete cloud_url(@cloud)
    end

    assert_redirected_to clouds_url
  end
end
