carregar:-
	open(dados, append, BD), write(BD,''),close(BD),
	['dados'],
	nl, write('Base de dados carregada com sucesso!'), nl, nl.





perguntar_nome :-%usado tanto no cadastro quanto na consulta, !!resolver problema do ponto!!
	write('Qual o nome do paciente?'), nl.
perguntar_idade :- 	
	write('Qual a idade do paciente?'), nl.
perguntar_data_do_exame :-
	write('Qual a data do exame? Ex: 25/12/2013'), nl.
perguntar_tipo_da_consulta :-
	write('Qual o tipo da consulta? (rotina ou circurgia)'), nl.

examinar:-
	perguntar_nome.


sair :-
     write('Bye!').

listar_pacientes :-
	tell(dados).

insere_nome(PACIENTE):- assert(nome(PACIENTE)).
insere_idade(PACIENTE,IDADE):- assert(idade(PACIENTE,IDADE)).
insere_data_do_exame(PACIENTE, DATA_DO_EXAME) :- assert(data_do_exame(PACIENTE,DATA_DO_EXAME)).
insere_tipo_da_consulta(PACIENTE,TIPO_DA_CONSULTA):- assert(tipo_da_consulta(PACIENTE,TIPO_DA_CONSULTA)).
insere_estado(PACIENTE, ESTADO) :- assert(estado(PACIENTE,ESTADO)).
insere_diagnostico(PACIENTE,DIAGNOSTICO) :- assert(diagnostico(PACIENTE,DIAGNOSTICO)).

cadastrar_paciente :-
	perguntar_nome,
	read(PACIENTE),
	perguntar_idade, read(IDADE),
	perguntar_data_do_exame,
	read(DATA_DO_EXAME),
	perguntar_tipo_da_consulta,
	read(TIPO_DA_CONSULTA),
	insere_nome(PACIENTE),
	insere_idade(PACIENTE, IDADE),
	insere_data_do_exame(PACIENTE, DATA_DO_EXAME),
	insere_tipo_da_consulta(PACIENTE, TIPO_DA_CONSULTA),
	insere_estado(PACIENTE,'x'),
	insere_diagnostico(PACIENTE,'false'),
	tell('dados'),
	listing(nome),
	listing(idade),
	listing(data_do_exame),
	listing(tipo_da_consulta),
	listing(estado),
	listing(diagnostico),
	told.

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
	Escolha==listar -> listar_pacientes,menu;
	Escolha==sair -> sai.


:-menu. %chama o menu principal pela primeira vez
