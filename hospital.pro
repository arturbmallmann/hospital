carregar:-
	open(dados, append, BD), write(BD,''),close(BD),
	['dados'],
	nl, write('Base de dados carregada com sucesso!'), nl, nl.


menu :-
	carregar,
    write('----   Operações    ----'),nl,nl,
	write('"listar" para listar todos os pacientes'), nl,
	write('"consultar" para encontrar um paciente pelo nome'), nl,
	write('"cadastrar" para cadastrar um paciente'), nl,
	write('"examinar" para examinar um paciente'), nl,
	write('"cirurgia" para realizar uma cirurgia'), nl,
	write('"sair" para Sair'), nl,
	write('  '), nl,
	read(Escolha),
	processa(Escolha).

processa(Escolha) :-
	Escolha==cadastrar -> cadastrar_paciente,menu;
	Escolha==consultar -> consulta,menu;
	Escolha==listar -> lista,menu;
	Escolha==sair -> sai.


:-menu. %chama o menu principal pela primeira vez


perguntar_nome :-%usado tanto no cadastro quanto na consulta, !!resolver problema do ponto!!
	write('Qual o nome do paciente?'), nl.
perguntar_idade :- 	
	write('Qual a idade do paciente?'), nl.
perguntar_data_do_exame :-
	write('Qual a data do exame? Ex: 25/12/2013'), nl.
perguntar_tipo_da_consulta :-
	write('Qual o tipo da consulta? (rotina ou circurgia)'), nl.

examinar:-
	perguntar_nome(Nome).


sair :-
     write('Bye!').

cadastrar_paciente :-
	perguntar_nome, read(NOME),
	perguntar_idade, read(IDADE),
	perguntar_data_do_exame, read(DATA_DO_EXAME),
	perguntar_tipo_da_consulta, read(TIPO_DA_CONSULTA),
	open(dados, append, BD),
	write(BD, 'nome('), write(BD, NOME), write(BD, '),'), % nome('nome')
	write(BD,'idade('), write(BD,IDADE), write(BD,'),'), %  idade('idade')
	write(BD,'data_do_exame('), write(BD,DATA_DO_EXAME), write(BD,'),'), %  data_do_exame('data_do_exame')
	write(BD,'tipo_da_consulta('), write(BD,TIPO_DA_CONSULTA), write(BD,'),'), %  tipo_da_consulta('tipo_da_consulta')
	write(BD, 'estado('), write(BD, 'x'), write(BD, '),'), % estado('x') : Estado inicial do paciente sempre será x (x,baixa,alta)
	write(BD, 'diagnosticado('), write(BD,'false'), write(BD,').\n'), % diagnosticado('false')
	close(BD).

listar_pacientes :-
	tell(dados).


