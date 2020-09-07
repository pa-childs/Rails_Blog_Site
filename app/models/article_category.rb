# frozen_string_literal: true

# Defines ArticleCategory model
class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
