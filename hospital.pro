carregar:-
	open(dados, append, BD), write(BD,''),close(BD),
	['dados'],
	nl, write('Base de dados carregada com sucesso!'), nl, nl.

ler(Word) :- get0(Car), ler_resto(Car, List),name(Word, List), !.
ler_resto(10, []).
ler_resto(Car, [Car|Resto]) :- get0(Car2), ler_resto(Car2, Resto).



perguntar_nome :-%usado tanto no cadastro quanto na consulta, !!resolver problema do ponto!!
	write('Qual o nome do paciente?'), nl.
perguntar_idade :- 	
	write('Qual a idade do paciente?'), nl.
perguntar_data_do_exame :-
	write('Qual a data do exame? Ex: 25/12/2013'), nl.
perguntar_tipo_da_consulta :-
	write('Qual o tipo da consulta? (rotina ou circurgia)'), nl.
perguntar_estado :-
	write('Qual o estado de saúde?'),nl.

examinar:-
	perguntar_nome.


sai :-
     write('Bye!').

listar_pacientes :- findall(Ex,nome(_,Ex),S),!,
	write(S).

procura(Paciente) :-

	findall(Ex,nome(Paciente,Ex),N),!,
	findall(Ex,idade(Paciente,Ex),I),!,
	findall(Ex,data_do_exame(Paciente,Ex),Da),!,
	findall(Ex,tipo_da_consulta(Paciente,Ex),T),!,
	findall(Ex,estado(Paciente,Ex),E),!,
	findall(Ex,diagnostico(Paciente,Ex),Di),!,
	findall(Ex,cirurgia(Paciente,Ex),C),!,
	write('nome: '), write(N),nl,
	write('idade: '), write(I),nl,
	write('data do exame: '),write(Da),nl,
	write('tipo da consulta: '),write(T),nl,
	write('estado: '),write(E),nl,
	write('diagnostico: '),write(Di),nl,
	write('cirurgia: '),write(C),nl.

insere_nome(PACIENTE):- assert(nome(PACIENTE,PACIENTE)).
insere_idade(PACIENTE,IDADE):- assert(idade(PACIENTE,IDADE)).
insere_data_do_exame(PACIENTE, DATA_DO_EXAME) :- assert(data_do_exame(PACIENTE,DATA_DO_EXAME)).
insere_tipo_da_consulta(PACIENTE,TIPO_DA_CONSULTA):- assert(tipo_da_consulta(PACIENTE,TIPO_DA_CONSULTA)).
insere_estado(PACIENTE, ESTADO) :- assert(estado(PACIENTE,ESTADO)).
insere_diagnostico(PACIENTE,DIAGNOSTICO) :- assert(diagnostico(PACIENTE,DIAGNOSTICO)).
insere_cirurgia(PACIENTE,FEITA) :- assert(cirurgia(PACIENTE,FEITA)).

exclui_nome(PACIENTE):- retract(nome(PACIENTE,PACIENTE)).
exclui_idade(PACIENTE):- retract(idade(PACIENTE,_)).
exclui_data_do_exame(PACIENTE) :- retract(data_do_exame(PACIENTE,_)).
exclui_tipo_da_consulta(PACIENTE):- retract(tipo_da_consulta(PACIENTE,_)).
exclui_estado(PACIENTE) :- retract(estado(PACIENTE,_)).
exclui_diagnostico(PACIENTE) :- retract(diagnostico(PACIENTE,_)).
exclui_cirurgia(PACIENTE) :- retract(cirurgia(PACIENTE,_)).

atualiza :-
	tell('dados'),
	listing(nome),
	listing(idade),
	listing(data_do_exame),
	listing(tipo_da_consulta),
	listing(estado),
	listing(diagnostico),
	listing(cirurgia),
	told.

cadastrar_paciente :-
	perguntar_nome,
	ler(PACIENTE),
	perguntar_idade,
	ler(IDADE),
	perguntar_data_do_exame,
	ler(DATA_DO_EXAME),
	perguntar_tipo_da_consulta,
	ler(TIPO_DA_CONSULTA),
	insere_nome(PACIENTE),
	insere_idade(PACIENTE, IDADE),
	insere_data_do_exame(PACIENTE, DATA_DO_EXAME),
	insere_tipo_da_consulta(PACIENTE, TIPO_DA_CONSULTA),
	insere_estado(PACIENTE,'x'),
	insere_diagnostico(PACIENTE,'false'),
	insere_cirurgia(PACIENTE,'false'),
	atualiza.

consulta :-
	perguntar_nome,
	ler(NOME),
	procura(NOME).

fazer_cirurgia :-
	perguntar_nome,
	ler(NOME),
	exclui_cirurgia(NOME),
	insere_cirurgia(NOME,'true'),
	atualiza.

fazer_diagnostivo :-
	perguntar_nome,
	ler(NOME),
	exclui_diagnostico(NOME),
	insere_diagnostico(NOME,'true'),
	perguntar_estado,
	ler(ESTADO),
	exclui_estado(NOME),
	insere_estado(NOME,ESTADO),
	atualiza.

dar_alta :-
	perguntar_nome,
	ler(NOME),
	exclui_nome(NOME),
	exclui_idade(NOME),
	exclui_data_do_exame(NOME),
	exclui_tipo_da_consulta(NOME),
	exclui_estado(NOME),
	exclui_diagnostico(NOME),
	exclui_cirurgia(NOME),
	atualiza.		
	

menu :-
	write('----   Operações    ----'),nl,nl,
	write('"listar" para listar todos os pacientes'), nl,
	write('"consultar" para encontrar um paciente pelo nome'), nl,
	write('"cadastrar" para cadastrar um paciente'), nl,
	write('"examinar" para examinar um paciente'), nl,
	write('"cirurgia" para realizar uma cirurgia'), nl,
	write('"alta" para dar alta'),nl,
	write('"sair" para Sair'), nl,
	write('  '), nl,
	ler(Escolha),
	processa(Escolha).

processa(Escolha) :-
	Escolha==cadastrar -> cadastrar_paciente,menu;
	Escolha==consultar -> consulta,menu;
	Escolha==listar -> listar_pacientes,menu;
	Escolha==cirurgia -> fazer_cirurgia,menu;
	Escolha==examinar -> fazer_diagnostivo,menu;
	Escolha==alta -> dar_alta,menu;
	Escolha==sair -> sai.

:-carregar.
:-menu. %chama o menu principal pela primeira vez
