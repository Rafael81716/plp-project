# 📚 Sistema de Biblioteca com Recomendação de Livros
Esse é um sistema de biblioteca com recomendação de livros, que permite que usuários se cadastrem, consultem, emprestem e devolvam livros, além de receberem recomendações personalizadas baseadas em suas preferências de gêneros e histórico de leitura.

## ⚙️ Como usar o sistema
- Primeiramente é necessário que você tenha uma versão de [Haskell](https://www.haskell.org/ghcup/ "Página inicial de Haskell") instalada no seu sistema .

- Clone o repositório:
```
git clone https://github.com/GabrielYuriRF0/plp-project.git
```

- Acesse a pasta haskell:
```
cd haskell
```
- Execute o Cabal Run
```
cabal run
```

## 💻 Organização do Terminal
Ao iniciar o sistema, o usuário verá a opção de cadastrar ou logar com um usuário. Caso ele não esteja cadastrado, ele precisará realizar o cadastro fornecendo nome, email, senha e até cinco gêneros de livros em ordem de preferência. O email será validado e o sistema não permitirá o cadastro de usuários com o mesmo email.

<a href="https://cdn.discordapp.com/attachments/873188956928348250/1106352205012926464/5832416.png"><img alt="book" height="200" width="200" border="0" align="right" background-color="transparent" src="https://cdn.discordapp.com/attachments/873188956928348250/1106352205012926464/5832416.png"></a>

Caso o usuário já esteja cadastrado, ele verá as seguintes opções disponíveis:
- Realizar empréstimo
- Devolver livro
- Ver todos os livros cadastrados no sistema
- Listar recomendações
- Cadastrar favoritos
- Remover favoritos
- Lista de favoritos
- Mostrar histórico de leitura
- Editar perfil
- Logout 

## 🖱️ Funcionalidades do Sistema
### Cadastrar Usuários
- Ao se cadastrar no sistema, o usuário precisará fornecer seu nome, email, senha e até cinco gêneros de livros em ordem de preferência. O email será validado e o sistema não permitirá o cadastro de usuários com o mesmo email. O usuário será automaticamente logado após o cadastro.

### Logar
- Para logar no sistema, o usuário precisará fornecer seu email e senha. O email será validado e a senha deve ter no mínimo 6 caracteres. Caso as credenciais sejam inválidas, o usuário receberá uma mensagem de erro.

### Realizar Empréstimo
- O usuário poderá associar até 10 livros em sua conta. Para isso, ele poderá consultar o livro desejado através do título, gênero ou autor.

### Devolver Livro
- O usuário poderá desassociar um livro de sua conta. Antes de desassociar o livro, o sistema perguntará se o usuário leu o livro e, caso afirmativo, o livro será adicionado ao histórico de leitura.

### Exibir Livros do Sistema
- O sistema permite que o usuário liste todos os livros cadastrados nos arquivos.

### Visualizar Livros
- O usuário poderá selecionar um livro para visualizar suas informações.

### Listar Recomendações
- O sistema recomenda até 10 livros baseados nas escolhas do usuário na hora do cadastro e no histórico de leitura.

### Cadastrar Favoritos
- O usuário poderá cadastrar um favorito, informando o nome do livro, podendo ter no máximo 10 favoritados.

### Remover Favoritos
- O usuário poderá selecionar um de seus livros favoritos para remover da lista.
### Listar Favoritos
- O usuário poderá listar os livros classificados como favoritos.





