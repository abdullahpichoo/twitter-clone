class View < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :views_count
end
