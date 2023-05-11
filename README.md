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

## 



