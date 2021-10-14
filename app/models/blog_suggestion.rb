class BlogSuggestion < ApplicationRecord
  enum status: [:published, :unpublished, :not_set]
end
