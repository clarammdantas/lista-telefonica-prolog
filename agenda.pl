:- dynamic
	favorito(contato(_,_)),
	bloqueado(contato(_,_)),
	chamar(contato(_,_),_),
	grupo(_),
	participantes(grupo(_), contato(_,_)),
	contato(_,_).

:-[mensagens].
:- initialization(main).	

%---------------Menu principal.

executaMenu():-
	exibeMenu(),
	read(OPCAO),nl,
	sw(OPCAO).
	
	
%--------------Opcões Menu principal.------------

sw(1):-
	write("Nome: "),read(NOME),nl,
	write("Numero: "),read(NUMERO),
    adicionaContato(NOME,NUMERO,0),
    write("Contato adicionado com sucesso!"),nl, nl,

	executaMenu().

sw(2):-
	findall(X, (contato(X,_)),L),
	exibeContatos(L).

sw(3):-
	write("Nome: "),read(NOME),nl,
	verificaContato(NOME), %se o contato nao existe, executa menu de novo
	apagaContato(NOME),

	write("Contato apagado com sucesso!"), nl, nl,
	executaMenu().

sw(4):-
	write('Digite o nome do contato: '),
	read(NOME),nl,
	buscarContato(NOME,_).

sw(5):-
	findall(X, (contato(X,_)),L),
	sort(L,O),
	exibeContatos(O).

sw(6):-
	write('Digite o nome do contato que deseja chamar:'),
	read(Nome),nl,
	verificaContato(Nome),
	chamaContato(Nome),
	executaMenu().
	
	
sw(7):-
	write("Nome: "), read(NOME), nl,
	verificaContato(NOME),
	adicionarAosFavoritos(NOME).

sw(8):-
	write('Digite o nome do contato que deseja alterar: '),
	read(NOMEANTIGO),nl,
	verificaContato(NOMEANTIGO),
	alteraContato(NOMEANTIGO),
	executaMenu().
sw(9):-
	write("Nome: "), read(NOME), nl,
	verificaContato(NOME),
	bloqueiaContato(NOME).

sw(10):-
	write("Nome: "), read(NOME), nl,
	verificaContato(NOME),
	desbloquearContato(NOME).

sw(11):-
	findall(X, (bloqueado(X)),L),
	listarContatos(L).

sw(12):-
	findall(X, (favorito(X)), L),
	listarContatos(L).
sw(13):-
	write("Nome: "), read(NOME), nl,
	verificaContato(NOME),
	removerFavorito(NOME).

sw(14):-
	menuGrupo(),
	executaMenu().

sw(15):-
	write('Lista telefônica encerrada!'),nl,
	halt(0).

sw(_):-

	executaMenu().

% --------------Adiciona fato contato(NOME,NUMERO) a base de dados----------------

adicionaContato(NOME,NUMERO,CHAMADAS):-
	assertz(contato(NOME,NUMERO)),
	assertz(chamar(contato(NOME,NUMERO),CHAMADAS)).
	
% -------------Método que imprime os contatos e seus respctivos números.-------------

exibeContatos([]):-
	executaMenu().	
exibeContatos([Head|Tail]):-
	call(bloqueado(contato(Head,_))), !,
	exibeContatos(Tail);

	write('Nome: '),writeln(Head),
	contato(Head,Y),
	write('Numero: '),writeln(Y),nl,
	exibeContatos(Tail).

% -------------Método para buscar um fato na base de dados. ------------

buscarContato(NOME,NUMERO):-
    call(contato(NOME,NUMERO)), !,
    write('Nome:'),write(NOME),nl,
    write('Numero:'),write(NUMERO),nl, executaMenu();
    writeln('O contato não existe!'),nl, executaMenu().

% ------------Método que apaga fato contato(NOME, _) da base de dados.------------

apagaContato(NOME):-
	call(bloqueado(contato(NOME,_))), !,
	retract(bloqueado(contato(NOME,_))),
	retract(contato(NOME,_));
	
	call(favorito(contato(NOME,_))),!,
	retract(favorito(contato(NOME,_))),
	retract(contato(NOME,_));
	
	retract(contato(NOME,_)).
	
%-------------Método que altera o fato contato da base de dados ------------------


alteraContato(NOMEANTIGO):- 
	alterarContatoMenu(),
	read(OP),nl,
	subMenuAlteraContato(OP,NOMEANTIGO).
	
subMenuAlteraContato(1,NomeAntigo):- 
	write("digite o novo nome:"),
	read(NovoNome),nl,
	
	contato(NomeAntigo,X),
	alteraBloqueado(NomeAntigo,NovoNome,X),
	chamar(contato(NomeAntigo,_),CHAMADAS),
	retract(chamar(contato(NomeAntigo,_),_)),

	apagaContato(NomeAntigo),
	adicionaContato(NovoNome, X,CHAMADAS),
	write("Nome alterado com sucesso!"),nl,nl.
	
	
subMenuAlteraContato(2,NomeAntigo):- 
	write("digite o novo número:"),
	read(NovoNumero),nl,
	apagaContato(NomeAntigo),
	assertz(contato(NomeAntigo,NovoNumero)),
	write("Numero alterado com sucesso!"),nl,nl.
	
subMenuAlteraContato(3,NomeAntigo):- 
	write("digite o novo nome:"),
	read(NovoNome),nl,
	write("digite o novo número:"),
	read(NovoNumero),nl,
	contato(NomeAntigo,_),
	chamar(contato(NomeAntigo,_),CHAMADAS),
	retract(chamar(contato(NomeAntigo,_),_)),
	alteraBloqueado(NomeAntigo,NovoNome,NovoNumero),
	apagaContato(NomeAntigo),
	adicionaContato(NovoNome, NovoNumero,CHAMADAS),
	write("Nome e número alterados com sucesso!"),nl,nl.

alteraBloqueado(Nome,NovoNome,Numero):-
	call(bloqueado(contato(Nome,_))), !,
	
		retract(bloqueado(contato(Nome,_))),
			assertz(bloqueado(contato(NovoNome,Numero)));contato(Nome,_).

%------------Utils-----------------------------------------------------

verificaContato(NOME):-
	call(contato(NOME,_)), !;

	write("Contato nao existe!"), nl,nl,
	executaMenu().

%------------Adicionar um contato aos favoritos-----------------------------------------------------
adicionarAosFavoritos(NOME):-
	call(favorito(contato(NOME,_))), !,
	write("Contato já está na sua lista de favoritos :)"), nl,nl,
	executaMenu;

	contato(NOME,X),
	assertz(favorito(contato(NOME,X))),
	write("Contato adicionado aos favoritos com sucesso!"),nl,nl,
	executaMenu().


%------------Remover um contato da lista de favoritos-----------------------------------------------------
removerFavorito(NOME):-
	call(favorito(contato(NOME,X))), !,
	apagaContato(NOME),
	adicionaContato(NOME, X),
	write("Contato removido da lista de favoritos!"),nl,nl,
	executaMenu(), nl;

	write("Esse contato não está na sua lista de favoritos atualmente."),
	executaMenu().
%------------Bloqueia contato-----------------------------------------------------

bloqueiaContato(NOME):-
	call(bloqueado(contato(NOME,_))), !,
	write("Contato já está bloqueado!"), nl,nl,
	executaMenu();

	contato(NOME,X),
	assertz(bloqueado(contato(NOME,X))),
	write("Contato bloqueado com sucesso!"),nl,nl,
	executaMenu().


%---------Printa uma lista de contatos----------------------------------------

listarContatos([]):-
	executaMenu().
listarContatos([contato(X,Y)|Tail]):-
	write("Nome: "),writeln(X),
	write("Numero: "),writeln(Y),
	listarContatos(Tail).


%--------Desbloquear contato-------------------------------------------------

desbloquearContato(NOME):-
	call(bloqueado(contato(NOME,X))), !,
	apagaContato(NOME),
	adicionaContato(NOME,X),
	write("Contato desbloqueado!"), nl, nl,
	executaMenu(), nl;

	write("Contato já é desbloqueado!"), nl, nl,
	executaMenu().
	
%--------Chama contato-------------------------------------------------------
chamaContato(Nome):-
	call(bloqueado(contato(Nome,_))),!,
	write('contato bloqueado!'),nl;
	chamar(contato(Nome,_),X),
	A is X + 1,
	realizaChamada(Nome, A).

realizaChamada(Nome,X):-
	retract(chamar(contato(Nome,_),_)),
	assertz(chamar(contato(Nome,_),X)),
	verificaFavorito(Nome,X).
	
verificaFavorito(Nome,5):-call(favorito(contato(Nome,_))), !;contato(Nome,X),
	assertz(favorito(contato(Nome,X))).

%----------Menu grupo------------------------------------------------------------

exibeContatoss([]).
exibeContatoss([Head|Tail]):-


	write(Head),nl,
	
	exibeContatos(Tail).

menuGrupo():-
	exibeMenuGrupo(),
	read(OP),
	subMenuGrupo(OP).
	
subMenuGrupo(1):- 
		write('Digite o nome do grupo:'),
		read(NomeGrupo),nl,
		assertz(grupo(NomeGrupo)),
		writeln('Grupo criado com sucesso!'),
		menuGrupo().
		
subMenuGrupo(2):-
	write('Digite o nome do contato: '),
	read(NomeContato), nl,
	write('Digite o nome do grupo: '),
	read(NomeGrupo), nl,
	adicionaContatoAGrupo(NomeContato, NomeGrupo),
	writeln('Contato adicionado a grupo com sucesso!'),nl,
	menuGrupo().

subMenuGrupo(3):-
	findall(X, (grupo(X)), L),
	listarGrupos(L).
	
subMenuGrupo(4):-
	write('Digite o nome do contato: '),
	read(NomeContato), nl,
	write('Digite o nome do grupo: '),
	read(NomeGrupo), nl,
	removeContatoDeGrupo(NomeContato,NomeGrupo),
	writeln('Contato removido com sucesso!'),nl,
	menuGrupo().

subMenuGrupo(5):-
	write('Digite o nome do grupo'),
	read(NomeGrupo),nl,
	removeGrupo(NomeGrupo).
subMenuGrupo(6):-
	write('Digite o nome do grupo: '),
	read(NomeGrupo), nl,
	listarContatosPorGrupo(NomeGrupo),
	menuGrupo().
	
subMenuGrupo(7):- executaMenu().	
subMenuGrupo(_):- menuGrupo().	
	

adicionaContatoAGrupo(NomeContato, NomeGrupo):-
	verificaContato(NomeContato),
	verificaGrupo(NomeGrupo),
	assertz(participantes(grupo(NomeGrupo), contato(NomeContato,_))).

removeContatoDeGrupo(NomeContato,NomeGrupo):-
	verificaContato(NomeContato),
	verificaGrupo(NomeGrupo),
	call(participantes(grupo(NomeGrupo), contato(NomeContato,_))), !,
	retract(participantes(grupo(NomeGrupo), contato(NomeContato,_)));
	nl, write('Contato não pertence a este grupo'),nl,nl.
	
listarGrupos([]):- menuGrupo().
listarGrupos([X|Tail]):-
	write("Nome: "),write(X),nl,
	listarGrupos(Tail).	

listarContatosPorGrupo(NomeGrupo):-
	verificaGrupo(NomeGrupo),
	call(participantes(grupo(NomeGrupo), contato(_,_))), !,
	write(NomeGrupo),nl,nl,
	findall(X, participantes(grupo(NomeGrupo), contato(X,_)),L),
	exibeContatos(L);
	write('Este grupo esta vazio'),nl.
	
verificaGrupo(NomeGrupo):-
	call(grupo(NomeGrupo)), !;
	write('Este grupo ainda não existe'),nl, menuGrupo().

	
esvaziaGrupo(NomeGrupo):-
	call(participantes(grupo(NomeGrupo), contato(_,_))), !,
	retractall(participantes(grupo(NomeGrupo), contato(_,_)));
	menuGrupo().
	
removeGrupo(NomeGrupo):-
	verificaGrupo(NomeGrupo),
	retract(grupo(NomeGrupo)),
	esvaziaGrupo(NomeGrupo),
	write('Grupo removido com sucesso'),nl,nl.
	


main:-
executaMenu(),
halt(0).

