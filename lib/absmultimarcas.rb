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

      #message = @email.body.split('ABS MULTIMARCAS,').last.split('Nome:').first.strip

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


{
  "nome"=>"Nathan Fsales",
  "email"=>"nathanael@f1sales.com.br",
  "telefone"=>"(11) 0000-0000",
  "celular"=>"(11) 9623-53444", 
  "tipo_de_contato"=>"E-mail",
  "mensagem"=>"Teste pelo Website. HR-V  - 12:31", 
  "marca"=>"HONDA", 
  "modelo"=>"HR-V",
  "ano"=>"2016/2016",
  "versao"=>"1.8 16V FLEX EX 4P AUTOMÁTICO", 
  "preco"=>"96.900,00", 
  "cambio"=>"CVT \n Portas: 4 \n Combustivel: Gasolina e álcool \n Km: 90.000",
  "final_da_placa"=>"1",
  "opcionais"=>"Ar condicionado, Travas elétricas, Vidros elétricos, Alarme, Freio ABS, Air bag do motorista, Rodas de liga leve, Desembaçador traseiro, Air bag duplo, Limpador traseiro, Retrovisores elétricos, Volante com Regulagem de Altura, Controle automático de velocidade, Farol de neblina, Direção Elétrica, Comando de áudio e telefone no volante, Controle de estabilidade, Distribuição eletrônica de frenagem, MP3 Player, Pára-choques na cor do veículo \n Observacoes Adicionais: Com mais de 150 veículos em estoque, a ABS MULTIMARCAS tem opções para todos os gostos. Está procurando um HONDA HR-V?\nNossa equipe está pronta para auxiliar você em todas as etapas do processo.\n\nEntre em contato também pelo WhatsApp (12) 99189-7444. \n Loja: ABS MULTIMARCAS \n Url do Site: https://www.absmultimarcas.com.br", 
  "url_do_formulrio"=>"https://www.absmultimarcas.com.br/estoque/veiculo/31837112/honda_hr-v_1.8-16v-flex-ex-4p-automatico"
}
