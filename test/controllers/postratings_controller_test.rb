# frozen_string_literal: true

require 'test_helper'

class PostratingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postrating = postratings(:one)
  end

  test 'should get index' do
    get postratings_url
    assert_response :success
  end

  test 'should get new' do
    get new_postrating_url
    assert_response :success
  end

  test 'should create postrating' do
    assert_difference('Postrating.count') do
      post postratings_url, params: { postrating: {} }
    end

    assert_redirected_to postrating_url(Postrating.last)
  end

  test 'should show postrating' do
    get postrating_url(@postrating)
    assert_response :success
  end

  test 'should get edit' do
    get edit_postrating_url(@postrating)
    assert_response :success
  end

  test 'should update postrating' do
    patch postrating_url(@postrating), params: { postrating: {} }
    assert_redirected_to postrating_url(@postrating)
  end

  test 'should destroy postrating' do
    assert_difference('Postrating.count', -1) do
      delete postrating_url(@postrating)
    end

    assert_redirected_to postratings_url
  end
end
