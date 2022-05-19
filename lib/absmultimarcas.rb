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
      parsed_email = @email.body.colons_to_hash(/(Nome|Email|Telefone|Celular|Tipo de Contato|Marca|Modelo|Ano|Versao|Final da Placa|Preco|Cambio|Opcionais|Url do Formulário|Mensagem).*?:/, false)
      source = F1SalesCustom::Email::Source.all[0]
      description = "Ano: #{parsed_email['ano']} - Final da Placa: #{parsed_email['final_da_placa']} - Valor: R$ #{parsed_email['preco']}"

      {
        source: {
          name: source[:name]
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['celular'].split.join.tr('^0-9', ''),
          email: parsed_email['email']
        },
        product: {name: "#{parsed_email['marca']} #{parsed_email['modelo']} #{parsed_email['versao']}" },
        message: parsed_email['mensagem'],
        description: description
      }
    end
  end
end
