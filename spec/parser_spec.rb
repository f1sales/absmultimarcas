require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website after update' do
    let(:email) do
      email = OpenStruct.new
      email.to = [email: 'website@absmultimarcas.f1sales.net']
      email.subject = 'Formulário de Proposta de Veículo | ABS MULTIMARCAS | https://www.absmultimarcas.com.br'
      email.body = "Formulário de Proposta de Veículo \n Nome Completo: Michelangelo Splinter \n Email: michelangelo.davi@gmail.com \n Telefone: (11) 0000-0000 \n Celular: (13) 9666-53551 \n Tipo de Contato: E-mail \n Mensagem: Teste pelo Website. HR-V  - 12:31 \n Marca: HONDA \n Modelo: HR-V \n Ano: 2016/2016 \n Versao: 1.8 16V FLEX EX 4P AUTOMÁTICO \n Preco: 96.900,00 \n Cambio: CVT \n Portas: 4 \n Combustivel: Gasolina e álcool \n Km: 90.000 \n Final da Placa: 1 \n Opcionais: Ar condicionado, Travas elétricas, Vidros elétricos, Alarme, Freio ABS, Air bag do motorista, Rodas de liga leve, Desembaçador traseiro, Air bag duplo, Limpador traseiro, Retrovisores elétricos, Volante com Regulagem de Altura, Controle automático de velocidade, Farol de neblina, Direção Elétrica, Comando de áudio e telefone no volante, Controle de estabilidade, Distribuição eletrônica de frenagem, MP3 Player, Pára-choques na cor do veículo \n Observacoes Adicionais: Com mais de 150 veículos em estoque, a ABS MULTIMARCAS tem opções para todos os gostos. Está procurando um HONDA HR-V?\nNossa equipe está pronta para auxiliar você em todas as etapas do processo.\n\nEntre em contato também pelo WhatsApp (12) 99189-7444. \n Loja: ABS MULTIMARCAS \n Url do Site: https://www.absmultimarcas.com.br \n Url do Formulário: https://www.absmultimarcas.com.br/estoque/veiculo/31837112/honda_hr-v_1.8-16v-flex-ex-4p-automatico"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Michelangelo Splinter')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('13966653551')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('michelangelo.davi@gmail.com')
    end

    it 'contains product' do
      expect(parsed_email[:product][:name]).to eq('HONDA HR-V 1.8 16V FLEX EX 4P AUTOMÁTICO')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Teste pelo Website. HR-V  - 12:31')
    end

    it 'contains description' do
      expect(parsed_email[:description]).to eq('Ano: 2016/2016 - Final da Placa: 1 - Valor: R$ 96.900,00')
    end
  end
end
