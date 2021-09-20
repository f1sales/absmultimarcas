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
      parsed_email = @email.body.colons_to_hash
      source = F1SalesCustom::Email::Source.all[0]
      product = "#{parsed_email['marca'].capitalize} #{parsed_email['modelo'].capitalize}"
      description = "Versão: #{parsed_email['versao']} - Ano: #{parsed_email['ano']} - Valor: #{parsed_email['preco']}"
      message = "#{parsed_email['melhor_forma_de_iniciar_a_negociacao'].gsub('_', ' ')} - #{parsed_email['mensagem']}"

      {
        source: {
          name: source[:name]
        },
        customer: {
          name: parsed_email['nome_completo'],
          phone: parsed_email['celular'].tr('^0-9', ''),
          email: parsed_email['email']
        },
        product: product,
        message: message,
        description: description
      }
    end
  end
end
