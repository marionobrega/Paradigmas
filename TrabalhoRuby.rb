
# Classe para representar uma tarefa
class Tarefa
  # Define os atributos que podem ser acessados e modificados externamente
  attr_accessor :descricao, :concluida

  # Método inicializador que define a descrição da tarefa e a marca como não concluída
  def initialize(descricao)
    @descricao = descricao  # Atribui a descrição passada como argumento
    @concluida = false      # Inicializa a tarefa como "não concluída"
  end

  # Método para marcar a tarefa como concluída
  def marcar_concluida
    @concluida = true       # Altera o status da tarefa para "concluída"
  end

  # Método para representar a tarefa como uma string
  def to_s
    status = concluida ? "[Concluída]" : "[Pendente]"  # Verifica se a tarefa está concluída
    "#{status} - #{@descricao}"  # Retorna a string formatada com o status e a descrição da tarefa
  end
end

# Classe para gerenciar a lista de tarefas
class GerenciadorDeTarefas
  # Inicializa o Gerenciador com uma lista vazia de tarefas
  def initialize
    @tarefas = []  # Lista para armazenar as tarefas
  end

  # Método para adicionar uma nova tarefa
  def adicionar_tarefa(descricao)
    tarefa = Tarefa.new(descricao)  # Cria uma nova tarefa com a descrição fornecida
    @tarefas << tarefa               # Adiciona a tarefa à lista
    puts "Tarefa adicionada: #{tarefa.descricao}"  # Informa que a tarefa foi adicionada
  end

  # Método para listar todas as tarefas
  def listar_tarefas
    puts "=== Lista de Tarefas ==="  # Cabeçalho da lista
    @tarefas.each_with_index do |tarefa, index|  # Itera sobre as tarefas e seus índices
      puts "#{index + 1}. #{tarefa}"  # Exibe cada tarefa com seu número
    end
  end

  # Método para marcar uma tarefa como concluída pelo índice
  def concluir_tarefa(indice)
    if indice > 0 && indice <= @tarefas.length  # Verifica se o índice está dentro do intervalo válido
      @tarefas[indice - 1].marcar_concluida  # Marca a tarefa correspondente como concluída
      puts "Tarefa '#{@tarefas[indice - 1].descricao}' marcada como concluída."  # Confirma a conclusão da tarefa
    else
      puts "Índice inválido."  # Informa se o índice fornecido é inválido
    end
  end

  # Método para salvar as tarefas em um arquivo
  def salvar_em_arquivo(nome_arquivo)
    File.open(nome_arquivo, 'w') do |file|  # Abre um arquivo em modo de escrita
      @tarefas.each { |tarefa| file.puts("#{tarefa.descricao},#{tarefa.concluida}") }  # Escreve cada tarefa e seu status no arquivo
    end
    puts "Tarefas salvas no arquivo '#{nome_arquivo}'"  # Confirma que as tarefas foram salvas
  end

  # Método para carregar as tarefas de um arquivo
  def carregar_de_arquivo(nome_arquivo)
    if File.exist?(nome_arquivo)  # Verifica se o arquivo existe
      File.readlines(nome_arquivo).each do |linha|  # Lê cada linha do arquivo
        descricao, concluida = linha.chomp.split(',')  # Divide a linha em descrição e status
        tarefa = Tarefa.new(descricao)  # Cria uma nova tarefa com a descrição
        tarefa.marcar_concluida if concluida == "true"  # Marca a tarefa como concluída se o status for "true"
        @tarefas << tarefa  # Adiciona a tarefa à lista
      end
      puts "Tarefas carregadas do arquivo '#{nome_arquivo}'"  # Confirma que as tarefas foram carregadas
    else
      puts "Arquivo '#{nome_arquivo}' não encontrado."  # Informa se o arquivo não foi encontrado
    end
  end
end

# Programa principal para interagir com o usuário
gerenciador = GerenciadorDeTarefas.new  # Cria uma nova instância do gerenciador de tarefas

puts "Bem-vindo ao Gerenciador de Tarefas!"  # Mensagem de boas-vindas

# Loop principal para o menu de interação com o usuário
loop do
  # Exibe o menu de opções
  puts "\n1. Adicionar Tarefa"
  puts "2. Listar Tarefas"
  puts "3. Marcar Tarefa como Concluída"
  puts "4. Salvar Tarefas"
  puts "5. Carregar Tarefas"
  puts "6. Sair"
  print "Escolha uma opção: "

  opcao = gets.to_i  # Lê a opção do usuário

  # Estrutura de controle que executa a ação com base na opção escolhida
  case opcao
  when 1
    print "Digite a descrição da tarefa: "  # Solicita a descrição da nova tarefa
    descricao = gets.chomp  # Lê a descrição do usuário
    gerenciador.adicionar_tarefa(descricao)  # Adiciona a nova tarefa ao gerenciador
  when 2
    gerenciador.listar_tarefas  # Exibe a lista de tarefas
  when 3
    print "Digite o número da tarefa para marcar como concluída: "  # Solicita o número da tarefa a ser concluída
    indice_tarefa = gets.to_i  # Lê o número da tarefa
    gerenciador.concluir_tarefa(indice_tarefa)  # Marca a tarefa como concluída
  when 4
    print "Digite o nome do arquivo para salvar: "  # Solicita o nome do arquivo para salvar as tarefas
    nome_arquivo = gets.chomp  # Lê o nome do arquivo
    gerenciador.salvar_em_arquivo(nome_arquivo)  # Salva as tarefas no arquivo
  when 5
    print "Digite o nome do arquivo para carregar: "  # Solicita o nome do arquivo para carregar as tarefas
    nome_arquivo = gets.chomp  # Lê o nome do arquivo
    gerenciador.carregar_de_arquivo(nome_arquivo)  # Carrega as tarefas do arquivo
  when 6
    puts "Saindo..."  # Informa que o programa está encerrando
    break  # Encerra o loop
  else
    puts "Opção inválida, tente novamente."  # Informa que a opção escolhida é inválida
  end
end
