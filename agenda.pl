:- dynamic
	bloqueado(contado(_,_)),
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
    adicionaContato(NOME,NUMERO).

sw(2):-
	findall(X, (contato(X,_)),L),
	exibeContatos(L).

sw(3):-
	apagaContato().

sw(4):-
	write('Digite o nome do contato: '),
	read(NOME),nl,
	buscarContato(NOME,_).

sw(5):-
	findall(X, (contato(X,_)),L),
	sort(L,O),
	exibeContatos(O).

sw(8):-
	write('Digite o nome do contato que deseja alterar: '),
	read(NOMEANTIGO),nl,
	alteraContato(NOMEANTIGO,_).

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
	listaContatosBloqueados(L).

sw(12):-
	write('Lista telefônica encerrada!'),nl,
	halt(0).

sw(_):- 
	write('Opção invalida,tente novamente!'),nl,
	executaMenu().

% --------------Adiciona fato contato(NOME,NUMERO) a base de dados----------------

adicionaContato(NOME,NUMERO):-
	assertz(contato(NOME,NUMERO)),
	write("Contato adicionado com sucesso!"),nl,
	executaMenu().
	
% -------------Método que imprime os contatos e seus respctivos números.-------------

exibeContatos([]):-
	executaMenu().	
exibeContatos([Head|Tail]):-
	call(bloqueado(contato(Head,_))), !,
	exibeContatos(Tail);

	write('Nome: '),write(Head),nl,
	contato(Head,Y),
	write('Numero: '),write(Y),nl,nl,
	exibeContatos(Tail).

% -------------Método para buscar um fato na base de dados. ------------

buscarContato(NOME,NUMERO):-
    call(contato(NOME,NUMERO)), !,
    write('Nome:'),write(NOME),nl,
    write('Numero:'),write(NUMERO),nl, executaMenu();
    write('O contato não existe!'),nl, executaMenu().

% ------------Método que apaga fato contato(NOME, _) da base de dados.------------

apagaContato():-
	write("Nome: "),read(NOME),nl,
	call(contato(NOME,_)), !,
	apagaBloqueado(NOME);

	write('O contato não existe!'),nl,
	executaMenu().

apagaBloqueado(NOME):-
	call(bloqueado(contato(NOME,_))), !,
	retract(bloqueado(contato(NOME, _))),
	retract(contato(NOME, _)),
	write("Contato apagado com sucesso!"),
	executaMenu();

	retract(contato(NOME, _)),
	write("Contato apagado com sucesso!"),nl,
	executaMenu().
	

%-------------Método que altera o fato contato da base de dados ------------------


alteraContato(_,_):- 
    write('Digite a opção desejada:'),nl,
	write('1: Nome.'),nl,
	write('2: Telefone.'),nl,
	write('3: Nome e telefone.'),nl,
	read(OP),nl,
	write("falta implementar"),
	subMenuAlteraContato(OP).
	
subMenuAlteraContato(1):- 
	write("Falta implementar").
	
subMenuAlteraContato(2):- 
	write("Falta implementar").	
	
subMenuAlteraContato(3):- 
	write("Falta implementar").	

	
%------------Bloqueia contato-----------------------------------------------------

verificaContato(NOME):-
	call(contato(NOME,_)), !;

	write("Contato nao existe!"), nl,
	executaMenu().

bloqueiaContato(NOME):-
	call(bloqueado(contato(NOME,_))), !,
	write("Contato já está bloqueado!"), nl,
	executaMenu();

	contato(NOME,X),
	assertz(bloqueado(contato(NOME,X))),
	write("Contato bloqueado com sucesso!"),nl,
	executaMenu().


%---------Listar contatos bloqueados----------------------------------------

listaContatosBloqueados([]):-
	executaMenu().
listaContatosBloqueados([contato(X,Y)|Tail]):-
	write("Nome: "),write(X),nl,
	write("Numero: "),write(Y),nl,
	listaContatosBloqueados(Tail).


%--------Desbloquear contato-------------------------------------------------

desbloquearContato(NOME):-
	call(bloqueado(contato(NOME,X))), !,
	retract(contato(NOME,X)),
	retract(bloqueado(contato(NOME,X))),
	assertz(contato(NOME,X)),
	write("Contato desbloqueado!"),nl,
	executaMenu(), nl;

	write("Contato já é desbloqueado!"), nl,
	executaMenu().

main:-
executaMenu(),
halt(0).
