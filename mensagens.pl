exibeMenu():-
   
   write('_________________________________________________________________________________________'),nl, 
	write('|| 1.Adicionar contato    '),                                                        
	write('   6.Chamar                 '),
	write('   11.Listar contatos bloqueados ||'),nl,


	write('|| 2.Listar contatos      '),
	write('   7.Adicionar favorito     '),
	write('   12.Listar favoritos           ||'),nl,
	
	write('|| 3.Apagar contato       '),
	write('   8.Alterar contato        '),
	write('   13.Remover favorito           ||'),nl,
	
	write('|| 4.Buscar contato       '),
	write('   9.Bloquear contato       '),
    write('   14.Grupos                     ||'),nl,


	write('|| 5.Ordenar              '),
	write('   10.Desbloquear contato   '),
	write('   15.Sair                       ||'),nl,
	write('||_____________________________________________________________________________________||'),nl, nl,
	write('Digite sua opcao: ').
	
exibeMenuGrupo():-
	write('1. Adicionar novo grupo.'),nl,
	write('2. Adicionar contato a um grupo.'),nl,
	write('3. Listar grupos'),nl,
	write('4. Remover contato de um grupo.'),nl,
	write('5. Remover grupo.'),nl,
	write('6. Listar contatos de um grupo'),nl,
	write('7. Voltar ao menu principal'),nl.

alterarContatoMenu():-
	write('Digite a opção desejada:'),nl,
	write('1: Nome.'),nl,
	write('2: Telefone.'),nl,
	write('3: Nome e telefone.'),nl.
	
