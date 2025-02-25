module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def include_searchable_scopes(*scopes)
      scopes.each do |scope|
        send("searchable_#{scope}")
      end
    end

    private

    def searchable_by_name
      scope :by_name, ->(name) { where("name = ?", name) }
    end

    def searchable_by_code
      scope :by_code, ->(code) { where("code = ?", code) }
    end
  end
end
