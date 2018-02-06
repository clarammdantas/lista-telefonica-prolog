
:-[mensagens].
:- initialization(main).	

%Menu principal.

executaMenu():-
	exibeMenu(),
	read(OPCAO),nl,
	sw(OPCAO).
	
	
%--------------Opcões Menu principal.------------

sw(1):-
    adicionaContato().
sw(2):-
	findall(X, (contato(X,Y)),L),
	exibeContatos(L).
sw(3):-
	apagaContato().
sw(4):-
	write('Digite o nome do contato: '),
	read(NOME),nl,
	buscarContato(NOME,X).
sw(8):-
	write('Digite o nome do contato que deseja alterar: '),
	read(NOMEANTIGO),nl,
	alteraContato(NOMEANTIGO,X).
sw(9):- 
	write('Lista telefônica encerrada!'),nl,
	halt(0).


% --------------Adiciona fato contato(NOME,NUMERO) a base de dados----------------

adicionaContato():-
	write("Nome: "),read(NOME),nl,
	write("Numero: "),read(NUMERO),
	assertz(contato(NOME,NUMERO)),
	executaMenu().
	
% -------------Método que imprime os contatos e seus respctivos números.-------------

exibeContatos([]):-
		executaMenu().
exibeContatos([Head|Tail]):-
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
	call(contato(NOME,NUMERO)), !,
    retract(contato(NOME, X)),
    executaMenu();
    write('O contato não existe!'),nl,
	executaMenu().

%-------------Método que altera o fato contato da base de dados ------------------


alteraContato(NOMEANTIGO,NUMEROANTIGO):- 
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

	





main:-
executaMenu().
halt(0).



