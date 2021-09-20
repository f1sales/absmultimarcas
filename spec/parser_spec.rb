require 'ostruct'
require 'byebug'
require "f1sales_custom/parser"
require "f1sales_custom/source"

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website' do
    let(:email) do
      email = OpenStruct.new
      email.to = [email: 'website@absmultimarcas.f1sales.net']
      email.subject = 'Formulário de Proposta de Veículo | ABS MULTIMARCAS | https://www.absmultimarcas.com.br'
      email.body = "\n\nFormulário de Proposta de Veículo \n Nome Completo: Teste Lead Site ABS MULTIMARCAS \n Email: Absmultimarcassjc@gmail.com \n Telefone: 13) 9313-13131 \n Celular: (19) 9969-28688 \n Melhor forma de iniciar a negociacao: Trocar_meu_veículo_por_um_novo_e_ainda_receber_um_valor_em_dinheiro \n Mensagem: Agora vai funcionar direitinho... \n Marca: RENAULT \n Modelo: LOGAN \n Ano: 2019/2020 \n Versao: 1.0 12V SCE FLEX LIFE MANUAL \n Preco: 53.900,00 \n Cambio: Manual \n Portas: 4 \n Combustivel: Gasolina e álcool \n Km: 45.127 \n Final da Placa: 2 \n Opcionais: Ar condicionado, Travas elétricas, Vidros elétricos, Freio ABS, Air bag do motorista, Desembaçador traseiro, Air bag duplo, Ar quente, Encosto de cabeça traseiro, Direção Elétrica, Distribuição eletrônica de frenagem, Pára-choques na cor do veículo \n Observacoes Adicionais: ?Com uma vasta gama de veículos em estoque, a ABS MULTIMARCAS tem opções para todos os gostos. Ajudamos os clientes a encontrar os melhores veículos do mercado desde 2000. Está procurando um RENAULT LOGAN 1.0 12V SCE FLEX LIFE MANUAL? Nossa equipe está pronta para auxiliar você em todas as etapas do processo. \n Loja: ABS MULTIMARCAS \n Url do Site: https://www.absmultimarcas.com.br \n Url do Formulário: https://www.absmultimarcas.com.br/estoque/veiculo/27913322/renault_logan_1.0-12v-sce-flex-life-manual"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Teste Lead Site ABS MULTIMARCAS')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('19996928688')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('Absmultimarcassjc@gmail.com')
    end

    it 'contains product' do
      expect(parsed_email[:product]).to eq('Renault Logan')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Trocar meu veículo por um novo e ainda receber um valor em dinheiro - Agora vai funcionar direitinho...')
    end

    it 'contains description' do
      expect(parsed_email[:description]).to eq('Versão: 1.0 12V SCE FLEX LIFE MANUAL - Ano: 2019/2020 - Valor: 53.900,00')
    end
  end
end
