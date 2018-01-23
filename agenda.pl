:-[mensagens].
:- initialization(main).	

%Menu principal.

executaMenu():-
	exibeMenu(),
	read(OPCAO),nl,
	sw(OPCAO).
	
%Opcões Menu principal.

sw(1):-
    adicionaContato().
sw(2):-
	findall(X, (contato(X,Y)),L),
	exibeContatos(L).
sw(3):-
	apagaContato().

% Adiciona fato contato(NOME,NUMERO) a base de dados

adicionaContato():-
	write("Nome do Contato: "),read(NOME),nl,
	write("Numero do Contato: "), read(NUMERO),
	assertz(contato(NOME,NUMERO)),
	executaMenu().
	
% Método que imprime os contatos e seus respctivos números.

exibeContatos([]):-
		executaMenu().
exibeContatos([Head|Tail]):-
		write('Nome: '),write(Head),nl,
		contato(Head,Y),
		write('Numero: '),write(Y),nl,nl,
		exibeContatos(Tail).

% Método que apaga fato contato(NOME, _) da base de dados.
% FIXME: Programa quebra se tentar apagar um contato nao existente.

apagaContato():-
	write("Nome do Contato: "),read(NOME),nl,
	retract(contato(NOME, X)),
	executaMenu().

main:-
executaMenu().
halt(0).



