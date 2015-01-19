%% caixa_voadora_inicial.m
% 
% Este script de Matlab fornece o codigo inicial para o problema da caixa
% voadora do Trabalho 1.
% Os alunos devem modifica-lo para criar seu proprio script
% 
% Nome do aluno: XXXXXXX
%
% Modifique o nome deste arquivo substituindo "inicial" por sua matricula.
% Por exemplo, caixa_voadora_12001234.m
%

%% SETUP

% Deleta todas variaveis do workspace do Matlab.
clear

% Carrega os dados do rastreador gravados durante o video.
% Esse arquivo de dados do MATLAB inclui o historico temporal das coordenadas
% em x, y, e z em centimetros, assim como o historico temporal dos angulos
% a, e, r em graus.

load caixa_voadora;

% Abre a figura 1 e de clear para estar pronto para plotagem.
figure(1);
clf;

%% DEFINICOES

% Precisamos trabalhar com 3 frames nesta simulacao
%
% Frame 0 eh o frame da camera, com x positivo para a direita,
% y positivo para tras, z positivo para cima.  Este eh o frame de referencia
% e eh o que plotamos no grafico. Sua origem coincide com a origem do frame 1.
%
% Frame 1 eh o frame do transmissor do sistema de rastreamento magnetico que
% fica sobre a mesa. Ele tem x positivo para frente, y positivo para a
% esquerda, e z positivo para baixo. Este eh o frame no qual as posicoes e
% orientacoes do sensor sao representadas. Sua origem eh proxima ao centro
% do transmissor (o cubo bege no video).
%
% Frame 2 eh o frame do sensor, que eh movido junto com a caixa.
% Seu eixo x sai horizontalmente da face frontal da caixa, na direcao da 
% palma da mao do usuario manipulando a caixa. Seu eixo x eh praticamente 
% horizontal durante o video e seu eixo z eh praticamente vertical.

% Defina a localizacao dos quatro vertices da caixa no frame do sensor
% (frame 2). O comprimento da caixa eh na direcao do eixo x do sensor e a
% largura eh na direcao do eixo y do sensor. Nos chamamos os vertices de
% pontos a, b, c, d (variaveis pa, pb, pc, and pd), e assumimos que o
% sensor estao no centro da caixa. Incluimos o escalar 1 no fim de cada um  
% desses vetores coluna para usa-los em transformacoes homogeneas. Voce 
% pode remover os 1's se nao for precisar deles, mas nao se esqueca de 
% comentar essa modificacao apropriadamente

box_length = 20;  % comprimento da caixa (cm)
box_width = 15;   % largura da caixa (cm)
pa2 = [-box_length/2 -box_width/2 0 1]';
pb2 = [ box_length/2 -box_width/2 0 1]';
pc2 = [ box_length/2  box_width/2 0 1]';
pd2 = [-box_length/2  box_width/2 0 1]';

% skipfactor eh o numero de dados a pular entre plotagens
% Aumente para aumentar a velocidade da animacao
% Valor minimo de 1
skipfactor = 2; 

%% ANIMACAO
% Anima o movimento da caixa voadora

% Percorre os dados do comeco ao fim, pulando a um fator dado por skipfactor.
for i = 1:skipfactor:length(x_cm_history)
    % Carrega as posicoes x, y, z atuais do sensor a partir do historico.
    x = x_cm_history(i);
    y = y_cm_history(i);
    z = z_cm_history(i);
    
    % Carrega os angulos a, e, r atuais do sensor a partir do historico
    % Lembre-se que estes valores estao em graus. Se quiser converte-los
    % para outra unidade, aqui eh um bom lugar para faze-lo.
    a = a_degrees_history(i);
    e = e_degrees_history(i);
    r = r_degrees_history(i);

    % Faca seus calculos. Se voce fizer as coisas de forma direta, 
    % todo seu codigo devera ficar entre as linhas de asteriscos.
   % *******************************************************************
    
    % Coloque seus calculos aqui!
    
    % Voce nao pode usar nenhuma funcao do MATLAB, biblioteca ou codigo 
    % externo que trabalhe com matrizes de rotacao, transformadas homogeneas,
    % angulos de Euler, roll/pitch/yaw ou topicos relacionados. 
    % Ao inves disso, voce devera codificar todos os cilculos voce mesmo, 
    % usando apenas funcoes de baixo nivel como sind, cosd, e matematica 
    % de vetor/matriz.
    
    % Calcule a posicao de cada vertice no frame da camera. Por enquanto,
    % nos apenas setamos os vertices para serem iguais as posicoes no frame 2, 
    % com um aumento no vertice c. Voce deve mudar isso!
    pa0 = pa2;
    pb0 = pb2;
    pc0 = pc2 + [0 0 i/30 0]'; % Fazer esse vertice crescer com o tempo para voce ver o codigo rodando.
    pd0 = pd2;
    
    % Se seu codigo roda, mas voce nao consegue ver nada no seu plot,
    % comente ou modifique o comando axis([...]) na secao de plot abaixo.
    
    % Todos os seus calculos devem ser feitos aqui. Sua resposta para as 
    % coordenadas dos vertices da caixa no frame 0 devem ser armazenadas
    % nas variaveis pa0, pb0, pc0, and pd0. 
    % *******************************************************************

    % Coloca os quatro pontos juntos para facilitar plotagem
    % Os pontos estaoo todos no frame da camera (frame 0)
    points0 = [pa0 pb0 pc0 pd0];
    
    % Formata o plot se for desenhar pela primeira vez
    if (i == 1)

        % Plota os pontos como uma regiao cinza (caixa)
        h = fill3(points0(1,:),points0(2,:),points0(3,:),[.2 .2 .2]);
        
        % Reforca simetria entre x, y, e z
        axis equal;
        
        % Seta o volume de vizualizacao. Se nao conseguir ver nada no seu
        % plot, voce devera aumentar o range ou comentar esse comando.
        % A ordem eh xmin xmax ymin ymax zmin zmax.
        axis([-64 60 -40 40 -12 64])
        
        % Seta o angulo de visao para ficar similar ao da camera.
        view(-35,20)
        
        % Label dos eixos, incluindo unidades de medida entre parentesis.
        xlabel('x0 (cm)')
        ylabel('y0 (cm)')
        zlabel('z0 (cm)')
        
        % Liga os grids para facilitar vizualizacao das paredes
        grid on
        title('Caixa Voadora de COLOQUE SEU NOME AQUI') % Atualize com seu nome
    else
        
        % Seta a localizacao dos vertices para os pontos atuais
        % Usando set e o handle de plot desta forma eh mais rapido
        % que replotar tudo
        set(h,'xdata',points0(1,:),'ydata',points0(2,:),'zdata',points0(3,:))
        
    end
    
    % Pausa por um curto periodo de tempo para permitir visualizar animacao
    pause(0.015)
    
end
