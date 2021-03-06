%% robo_scara_inicial.m
% 
% Esse script do Matlab fornece o codigo inicial para o problema do robo
% SCARA do Trabalho 2.
% Os alunos devem modifica-lo para criar o seu proprio script
%
% Nome do aluno: XXXXXXX
%
% Modifique o nome deste arquivo substituindo "inicial" por sua matrícula.
% Por exemplo, robo_scara_12001234.m
%

%% SETUP

% Deleta todas variáveis do workspace do Matlab e a command window.
clear all
close all
clc

% Armazene seu nome como uma string
student_name = 'COLOQUE O SEU NOME AQUI';

% Define o vetor de tempo
tStart = 0;   % Instante em que a simulacao inicia, em segundos.
tStep = 0.04; % Step da simulacao, em segundos.
tEnd = 10;    % Instante em que a simulacao termina, sem segundos.
t = (tStart:tStep:tEnd)';  % Vetor de tempo (vetor coluna).

% Configura a animacao do movimento do robo
pause on;  % Se não quiser assistir a animacao, configure como off.
GraphingTimeDelay = 0.05; % Tamanho da pausa entre posicoes quando renderizando, se houver, em segundos.



%% MODOS DE MOVIMENTO

% 0 faz o robo permanecer parado com coordenadas de juntas em zero (home).
% 1 faz apenas a junta 1 se mover.
% 2 faz apenas a junta 2 se mover.
% 3 faz apenas a junta 3 se mover.
% 4 faz todas as juntas se moverem em um padrão interessante da sua escolha.

% Defina o modo de movimento aqui!
motion_mode = 1; % Mude de acordo com o que deseja executar

% Define a coordenada da junta dado o modo de movimento selecionado. Aqui
% estamos determinando valores para theta1, theta2 e d3. Cada um deve ser
% um vetor coluna com as mesmas dimensões de t.

switch motion_mode
    case 0
        disp('O robo deve ficar parado.')
        theta1_history = 0*t; % Define theta1 como zero para todo o tempo.
        theta2_history = 0*t; % Define theta2 como zero para todo o tempo.
        d3_history = 0*t; % Define d3 como zero para todo o tempo.
    case 1
        disp('O robo deve mover apenas a junta 1.')
        theta1_history = 1+.5*sin(1.3*t); % Define theta1 para uma função interessante.
        theta2_history = 0*t; % Define theta2 como zero para todo o tempo.
        d3_history = 0*t; % Define d3 como zero para todo o tempo.
    case 2
        disp('O robo deve mover apenas a junta 2.')
        % Voce deve preencher aqui o que for necessario.
    case 3
        disp('O robo deve mover apenas a junta 3.')
        % Voce deve preencher aqui o que for necessario.
    case 4
        disp('O robo deve mover todas as suas juntas.')
        % Voce deve preencher aqui o que for necessario.
    otherwise
        error('Erro! motion_mode desconhecido')
end

%% PARAMETROS DO ROBO

% Esse problema é sobre as 3 primeiras juntas (RRP) de um manipulador SCARA
% A cinemática direta desse robo (FK) encontra-se nas paginas 91 a 93 do
% livro texto (Spong), apesar de aqui estarmos ignorando a 4a junta do
% punho. Voce pode usar a solucao do livro para resolver essa parte do
% trabalho.

% Define o comprimento dos links do robo.
a1 = 1.0; % Distancia entre juntas 1 e 2, em metros.
a2 = 0.7; % Distancia entre juntas 2 e 3, em metros.

%% SIMULACAO

% Avisa usuario sobre inicio da animacao
disp('Comecando a animacao.')

% Mostra mensagem explicando como cancelar a simulacao
disp('Clique nesta janela e pressione control-c para interromper o codigo')

% Inicializa a matriz para guardar a posicao da ponta do robo ao longo do
% tempo. A primeira linha eh a coordenada x, a segunda eh y, e a terceira
% eh z, todas no frame da base. Voce pode fazer uma 4a linha se desejar
% usar a representacao homogenea dos pontos. A matriz tem o mesmo numero de
% colunas que o vetor t, ou seja, uma posicao da ponta para cada step de 
% tempo na simulacao. O historico eh armazenado para que possamos tracar a
% trajetoria de onde esteve a ponta do robo
tip_history = zeros(3,length(t));

% Percorre o vetor de step do tempo para animar o robo.
for i = 1:length(t)
    
    % Coloca os dados atuais de theta1, theta2, e d3 nos historicos
    theta1 = theta1_history(i);
    theta2 = theta2_history(i);
    d3 = d3_history(i);

    % Faça seus cálculos. Se você fizer as coisas de forma direta, 
    % todo seu código deverá ficar entre as linhas de asteriscos.
    % *******************************************************************
    
    % Coloque seus calculos aqui!
      
    % Se seu codigo roda, mas voce nao consegue ver nada no seu plot,
    % comente ou modifique o comando axis([...]) na secao de plot abaixo.
        
    % Coloque os pontos juntos
    points_to_plot = [[0 0 -2]' [0 0 0]' [.5 0 1]' [2 0 1]' [theta1 theta2 d3]'];
    
    % Todos os seus calculos devem ser feitos aqui. Sua lista com os pontos
    % do robo a plotar devem estar em points_to_plot, indo da base para a
    % ponta. Cada coluna representa as coordenadas x, y e z de um ponto. A
    % ultima coluna de points_to_plot deve ser a posicao da ponta do robo
    % *******************************************************************
    
    % Grab the final plotted point for the trajectory graph.
    tip_history(:,i) = points_to_plot(:,end);

    % Abre a figura 1 e da clear para estar pronto para plotagem.
    figure(1);

    % Formata o plot se for desenhar pela primeira vez
    if (i == 1)
        % Na primeira vez, plota os pontos do robo e guarda o handle do
        % plot. Esse eh um plot 3D com esferas conectando os pontos e
        % linhas conectando pontos vizinhos em cinza escuro
        hrobot = plot3(points_to_plot(1,:),points_to_plot(2,:),points_to_plot(3,:),'.-','linewidth',5,'markersize',20,'color',[.3 .3 .3]);
        
        % Tambem plota a posicao da ponta do robo usando hold on e hold off
        % Mantem um handle para poder atualizar esses dados depois
        hold on;
        htip = plot3(tip_history(1,i),tip_history(2,i),tip_history(3,i),'r.');
        hold off;

        % Label dos eixos, incluindo unidades de medida entre parentesis.
        xlabel('X (m)');
        ylabel('Y (m)');
        zlabel('Z (m)');

        % Liga os grids e o box.
        grid on;
        box on;

        % Seta os limites dos eixos.
        axis([-2 2 -2 2 -2 2])

        % Seta as propriedades do eixo para visualizacao 3D, deixando a
        % mesma unidade em todas as direcoes e permitindo rotacao
        axis vis3d;

        % Coloca texto no plot para mostrar quanto tempo passou.
        % O texto é centralizado.
        htime = text(1,1,1,sprintf('t = %.2f s',t(i)),'horizontalAlignment','center');

        % Adiciona um titulo incluindo o nome do estudante.
        title('Robo SCARA de COLOQUE SEU NOME AQUI'); % Atualize com seu nome
    else
        % Uma vez que a animacao esteja setada, nao precisamos reformatar
        % todo o plot. Precisamos apenas atualizar os dados para corrigir
        % os novos valores para a animacao do robo, o historico da ponta
        % (tip_history) e o texto que mostra o tempo decorrido.
        set(hrobot,'xdata',points_to_plot(1,:),'ydata',points_to_plot(2,:),'zdata',points_to_plot(3,:))
        set(htip,'xdata',tip_history(1,1:i),'ydata',tip_history(2,1:i),'zdata',tip_history(3,1:i))
        set(htime,'string', (sprintf('t = %.2f s',t(i))));
    end
    
    % Pausa por um curto período de tempo para permitir visualizar animação
    pause(GraphingTimeDelay)
    
end

disp('Fim da animacao.')
