# frozen_string_literal: true

require 'test_helper'

class ComentratingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comentrating = comentratings(:one)
  end

  test 'should get index' do
    get comentratings_url
    assert_response :success
  end

  test 'should get new' do
    get new_comentrating_url
    assert_response :success
  end

  test 'should create comentrating' do
    assert_difference('Comentrating.count') do
      post comentratings_url, params: { comentrating: { star: @comentrating.star } }
    end

    assert_redirected_to comentrating_url(Comentrating.last)
  end

  test 'should show comentrating' do
    get comentrating_url(@comentrating)
    assert_response :success
  end

  test 'should get edit' do
    get edit_comentrating_url(@comentrating)
    assert_response :success
  end

  test 'should update comentrating' do
    patch comentrating_url(@comentrating), params: { comentrating: { star: @comentrating.star } }
    assert_redirected_to comentrating_url(@comentrating)
  end

  test 'should destroy comentrating' do
    assert_difference('Comentrating.count', -1) do
      delete comentrating_url(@comentrating)
    end

    assert_redirected_to comentratings_url
  end
end
