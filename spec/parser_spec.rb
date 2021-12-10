require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when came from the website' do
    let(:email) do
      email = OpenStruct.new
      email.to = [email: 'website@absmultimarcas.f1sales.net']
      email.subject = 'Proposta para o carro usado AUDI A3 1.8 20V 150CV TURBO GASOLINA 4P AUTOMÁTICO 2002'
      email.body = "WebMotors :: Lead de veículo usado   \n  \n   \n   \n   (http://www.webmotors.com.br/?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta/Carro/Usado-PJ-142)    \n  \n \n  Proposta para seu Carro \n  \n \n  Responda seus leads pela Plataforma do Revendedor! \nPara garantir um melhor controle de todas as negociações e manter o histórico de cada venda, a partir de 01/02 este e-mail deixará de trazer o conteúdo das propostas recebidas, levando diretamente para responder na Plataforma do Revendedor. \n Clique aqui e responda este lead agora mesmo. (http://webmotors.vmotors.com.br/gestao-leads/central-de-mensagens) \n  \n\n ABS MULTIMARCAS, \n  \nOlá, fiz uma simulação de financiamento para este veículo e estou interessado nele. Por favor entre em contato. Tenho interesse em realizar a negociação através do Car Delivery. \n  Nome: \n                                    Peter \nE-mail:\n                                        peterjoao.pj@gmail.com \nTel.: (\n                                            12)\n                                                99722-0737 \n \n  \n  \n \n  DADOS DO VEÍCULO ANUNCIADO \n  \n \n  \n   \n  Veículo: \n                                                AUDI A3 1.8 20V 150CV TURBO GASOLINA 4P AUTOMÁTICO \nAno:\n                                                    2002 /\n                                                        2002 \nCor:\n                                                            Prata \n Placa:\n                                                                FAF6767 \n Preço: R$\n                                                                    25900.00 \n  \n   \n   Veja o anúncio >> (http://www.webmotors.com.br/c/39071136?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta/Carro/Usado-PJ-142) \n \n  \n Lembre-se de apagar a placa informada ao lado, caso não queira divulgá-la ao interessado. \nConfira também nossas dicas para uma venda segura! (http://dicas.webmotors.com.br/dicas-de-venda/venda-segura?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta/Carro/Usado-148) \n  \n  \n  \n \n Veículos anunciados em sites do Grupo WebMotors podem aparecer em mais de um classificado \n   \n   (http://www.webmotors.com.br/?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta-Financiamento-wm)    (http://www.meucarango.com.br/?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta-Financiamento-wm)    (http://www.compreauto.com.br/?utm_source=WebMotors&utm_medium=Email_Transacional&utm_campaign=Proposta-Financiamento-wm)  \n  \n   \n  Acompanhe o WebMotors \n         \n    \n  Fale Conosco \n    Dúvidas e perguntas (http://atendimento.webmotors.com.br/perguntas-frequentes?utm_source=WebMotors&utm_medium=Email_Servicos&utm_campaign=agenda/carro/seguro) \nfrequentes \n  \n  \n \n  Essa mensagem foi enviada em 09/12/2021 | 22:01 \nCadastre o domínio @webmotors.com.br como remente confiável. \nWebMotors S.A. Todos os direitos reservados"

      email
    end

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Peter')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('12997220737')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('peterjoao.pj@gmail.com')
    end

    it 'contains product' do
      expect(parsed_email[:product]).to eq('AUDI A3 1.8 20V 150CV TURBO GASOLINA 4P AUTOMÁTICO')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Olá, fiz uma simulação de financiamento para este veículo e estou interessado nele. Por favor entre em contato. Tenho interesse em realizar a negociação através do Car Delivery.')
    end

    it 'contains description' do
      expect(parsed_email[:description]).to eq('Ano: 2002/2002 - Cor: Prata - Placa: FAF6767 - Valor: R$ 25900.00')
    end
  end
end
