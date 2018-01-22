:-[mensagens].



:- initialization(main).	

% Método que imprime o contato e seu respctivo número.

exibeContatos([]).
exibeContatos([Head|Tail]):-
		write('Nome: '),write(Head),nl,
		contato(Head,Y),
		write('Numero: '),write(Y),nl,nl,
		exibeContatos(Tail).

% Adiciona fato contato(NOME,NUMERO) a base de dados

adicionaContato():-
	read(NOME),nl,
	read(NUMERO),
	assertz(contato(NOME,NUMERO)).

main:-
adicionaContato(),
findall(X, (contato(X,Y)),L),
exibeContatos(L).


halt(0).



