require_relative "absmultimarcas/version"
require "f1sales_custom/source"
require "f1sales_custom/parser"
require "f1sales_helpers"

module Absmultimarcas
  class Error < StandardError; end
  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        }
      ]
    end
  end
  class F1SalesCustom::Email::Parser
    def parse
      # ...
    end
  end
end
