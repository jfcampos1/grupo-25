# frozen_string_literal: true

module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    if user.avatar.file.nil?
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://upload.wikimedia.org/wikipedia/commons/9/93/Default_profile_picture_%28male%29_on_Facebook.jpg#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: 'gravatar')
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = user.avatar.url
      image_tag(gravatar_url, alt: user.name, class: 'gravatar')

    end
  end

  def profile_picture(user)
    if user.avatar.file.nil?
      image_url('https://upload.wikimedia.org/wikipedia/commons/9/93/Default_profile_picture_%28male%29_on_Facebook.jpg')
    else
      user.avatar.url
    end
  end

  def request_button(tema)
    return unless current_user
    sent_request = tema.moderator_requests.detect do |relation|
      (relation.user_id == current_user.id) && (relation.tema_id == tema.id)
    end
    received = tema.moderator_requests.detect do |relation|
      relation.tema_id == tema.id
    end
    admin = current_user.role == 'admin'
    options(sent_request, admin, tema, received)
  end

  def options(sent_request, admin, tema, received)
    sent_request2 = tema.moderators.detect do |relation|
      (relation.user_id == current_user.id) && (relation.tema_id == tema.id)
    end
    message = 'Accept Moderator request'
    if sent_request
      link_to 'Cancel mod request', moderator_request_path(sent_request), method: 'delete', id: 'not_hover',
                                                                          class: 'btn btn-danger not_visit',
                                                                          remote: false,
                                                                          data: { type: 'json', 'tema-id': tema.id }
    elsif admin || moderator?(tema)
      link_to message, tema_moderators_path(tema, usu_id: received.user_id), method: 'post', id: 'not_hover',
                                                                             class: 'btn btn-success not_visit',
                                                                             remote: false
    elsif !sent_request2
      link_to 'Send mod request', tema_moderator_requests_path(tema), method: 'post', id: 'not_hover',
                                                                      class: 'btn btn-m_request not_visit',
                                                                      remote: false,
                                                                      data: { type: 'json', 'tema-id': tema.id }
    end
  end

  def request_cancel_button(tema)
    return unless current_user
    return if current_user.moderators.include?(tema)
    received = tema.moderator_requests.detect do |relation|
      relation.tema_id == tema.id
    end
    mess2 = 'Cancel Moderator request'
    link_to mess2, moderator_request_path(received), method: 'delete', id: 'not_hover',
                                                     class: 'btn btn-danger not_visit',
                                                     remote: false
  end

  def moderator_cancel_button(tema)
    return unless current_user
    received = tema.moderators.detect do |relation|
      relation.tema_id == tema.id
    end
    mess2 = 'Delete Moderator'
    link_to mess2, moderator_path(received), method: 'delete', id: 'not_hover',
                                             class: 'btn btn-danger not_visit',
                                             remote: false, data: { confirm: 'Are you sure?' }
  end

  def sub_request_button(tema)
    return unless current_user
    sent_request = tema.subscriptions.detect do |relation|
      (relation.user_id == current_user.id) && (relation.tema_id == tema.id)
    end
    sub_options(sent_request, current_user, tema)
  end

  def sub_options(sent_request, current_user, tema)
    if sent_request
      link_to 'Unsubscribe', subscription_path(sent_request), method: 'delete', id: 'not_hover',
                                                              class: 'btn btn-danger not_visit', remote: false,
                                                              data: { type: 'json', 'tema-id': tema.id }
    elsif current_user
      link_to 'Subscribe', tema_subscriptions_path(tema), method: 'post', id: 'not_hover',
                                                          class: 'btn btn-success not_visit', remote: false,
                                                          data: { type: 'json', 'tema-id': tema.id }
    end
  end

  def fav_request_button(post)
    return unless current_user
    sent_request = post.favorites.detect do |relation|
      (relation.user_id == current_user.id) && (relation.post_id == post.id)
    end
    fav_options(sent_request, current_user, post)
  end

  def fav_options(sent_request, current_user, post)
    if sent_request
      link_to 'No Favorite', post_path(sent_request), method: 'delete', id: 'not_hover',
                                                      class: 'btn btn-danger not_visit', remote: false,
                                                      data: { type: 'json', 'post-id': post.id }
    elsif current_user
      link_to 'Favorite', post_favorites_path(post), method: 'post', id: 'not_hover',
                                                     class: 'btn btn-success not_visit', remote: false,
                                                     data: { type: 'json', 'post-id': post.id }
    end
  end

  def moderator?(tema)
    return unless current_user
    return if current_user.moderators.include?(tema)
    sent_request = tema.moderators.detect do |relation|
      (relation.user_id == current_user.id) && (relation.tema_id == tema.id)
    end
    sent_request
  end
end
