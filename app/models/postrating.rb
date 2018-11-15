# frozen_string_literal: true

class Postrating < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
