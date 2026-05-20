## 🚀 Como Iniciar um Novo Projeto a partir deste Template

Quando criamos um novo projeto usando este template, todas as configurações internas, pacotes nativos (Android, iOS, Windows) e o próprio `pubspec.yaml` ainda estarão registrados com o nome original do template (`flutter_base_template`). 

Para renomear o projeto de forma automática e segura, sem precisar caçar texto arquivo por arquivo, seguimos o fluxo abaixo:

### 1. Criar e Clonar o seu novo repositório
1. No GitHub, clique em **Use this template** > **Create a new repository**.
2. Dê o nome do seu novo projeto e clone-o em sua máquina.

### 2. Renomear o Projeto (Nativo e Dart)
Abra o terminal na raiz do projeto clonado e execute os seguintes comandos:

```bash
# 1. Ative a ferramenta de renomeação globalmente (caso não tenha ativado antes)
flutter pub global activate rename_app

# 2. Renomeie todo o ecossistema (Substitua "Meu Novo App" pelo nome do seu projeto)
rename_app:main all="Meu Novo App"
