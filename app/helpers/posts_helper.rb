# frozen_string_literal: true

module PostsHelper
  def starstring(stars)
    return 'onestar' if stars == 1
    return 'twostar' if stars == 2
    return 'threestar' if stars == 3
    return 'fourstar' if stars == 4
    return 'fivestar' if stars == 5
    'nostar'
  end
end
