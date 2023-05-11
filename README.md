# 📚 Sistema de Biblioteca com Recomendação de Livros
Esse é um sistema de biblioteca com recomendação de livros, que permite que usuários se cadastrem, consultem, emprestem e devolvam livros, além de receberem recomendações personalizadas baseadas em suas preferências de gêneros e histórico de leitura.

## ⚙️ Como usar o sistema
- Observação 1: Primeiramente é necessário que você tenha uma versão de [Haskell](https://www.haskell.org/ghcup/ "Página inicial de Haskell") instalada no seu sistema .
- Observação 2: O books.csv deve estar na raiz do projeto.

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

### Exibir Histórico de Leitura
- O usuário poderá visualizar os últimos 10 livros lidos por ele.

### Editar Perfil
- O usuário poderá editar seu email, senha e gêneros favoritos.

### Logout
- O sistema encerra a execução.

## 💻 Equipe
<table>
  <tr align="center">
    <td><a href="https://github.com/GabrielYuriRF0" title="Gabriel Yuri"><img src="" width="115px" alt="Foto de perfil de Gabriel Yuri" /><br /><sub>Gabriel Yuri</sub></a></td>
    <td><a href="https://github.com/elipcs" title="Lucas Emmanuel"><img src="https://avatars.githubusercontent.com/u/88330410?v=4" width="115px" alt="Foto de perfil de Lucas Emmanuel" /><br /><sub>Lucas Emmanuel</sub></a></td>
    <td><a href="https://github.com/joaovictorsl" title="joão Vitor"><img src="https://avatars.githubusercontent.com/u/79459468?v=4" width="115px" alt="Foto de perfil de João Vitor" /><br /><sub>João Vitor</sub></a></td>
    <td><a href="https://github.com/lucas-q-c" title="Lucas Queiroz"><img src="https://cdn.discordapp.com/attachments/873188956928348250/1106358403082768444/41b3f9cb-cfa9-4106-ab57-7c36520b5e0b.jpeg" width="115px" alt="Foto de perfil de Lucas Queiroz" /><br /><sub>Lucas Queiroz</sub></a></td>
    <td><a href="https://github.com/Rafael81716" title="Rafael de Sousa><img src="https://avatars.githubusercontent.com/u/88330410?v=4" width="115px" alt="Foto de perfil de Rafael de Sousa" /><br /><sub>Rafael de Sousa</sub></a></td>
  </tr>
</table>



