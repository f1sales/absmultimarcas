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
      parsed_email = @email.body.colons_to_hash(/(Nome|E-mail|Tel|Veículo|Ano|Cor|Placa|Preço).*?:/, false)
      source = F1SalesCustom::Email::Source.all[0]
      description = "Ano: #{parsed_email['ano'].split.join} - Cor: #{parsed_email['cor']} - Placa: #{parsed_email['placa']} - Valor: #{parsed_email['preo'].split[0..1].join(' ')}"

      message = @email.body.split('ABS MULTIMARCAS,').last.split('Nome:').first.strip

      {
        source: {
          name: source[:name]
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['tel'].split[0..2].join.tr('^0-9', ''),
          email: parsed_email['email']
        },
        product: parsed_email['veculo'],
        message: message,
        description: description
      }
    end
  end
end
