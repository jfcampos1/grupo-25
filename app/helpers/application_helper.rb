# frozen_string_literal: true

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    if page_title.empty?
      'Grupo 25'
    else
      page_title + ' | ' + 'Grupo 25'
    end
  end
end
