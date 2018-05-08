clear
commandwindow
% Simple program for solving the advection equation
%%%%%%%%%%%%
%% Set up parameters
tau=.1; %input('Enter timestep:');
N = 700;% input('Enter N steps:');    
c = 1;                  % Wave speed
L = 5.0;                % Length of domain
h = L/N;                % Space grid size
x = -L/2+h/2+(0:N-1)*h; % Space coordinate
tau = h/c;             % Stability limit
clf
ylim([0, 8]); xlim([1,2])
title('Floaty Shape', 'Color', 'black', 'FontSize', 25, 'FontName','Goudy Stout')
axis off
text(1.1, 4, '"W" to Float and "S" to Dive', 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
text(1.1, 3, 'Good Luck!', 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
text(1.1, 2, 'Press any button to continue...', 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
lives=1
xofy = 1.2/h;
b = zeros(N+1,1);
b = b+4;
a = zeros(N+1,1);       % Numerical solution vector
xi = 1:N;               % Index counters
xm = [2:N 1];
xp = [N 1:N-1];
colorshift = 1;
color ='blue';
shapeshift = 0;
shape = 's';
bottom = 5;
top = 5;
space = 50;
level = 0;
c1x=0
c2x=0
c1y=0
c2y=0
% coins = zeros(20, 2);
% coinsubtract = [-h, 0; -h, 0; -h, 0; -h, 0; -h, 0; -h, 0; -h, 0; -h, 0; -h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0;-h, 0] 
ylowlimit = 0;
yuplimit = 8;
coinnumber = 0;
CoinCounter = 0;
% Define initial pulse
a=  2./cosh(5*x.^2/h).^2;    % initial bottom pulse
b= - 2./cosh(5*x.^2/h).^2 +7; % initial top pulse
%%%%%%%%%%%%
%% Run the loop
pause;
clf
%plot(x,a,'-o'); ylim([-1,1.5]);


coeff_ftcs = -c*tau/(2.*h);
istep = 1;
t=0;
v = 0;
accel = -100;
America = 0
set(gcf,'CurrentCharacter','@'); % set to a dummy character for flapping
while lives > 0
    lives = lives -1;
    y= (b(700*h*1.2 +350) + a(700*h*1.2 +350))/2
    v = 0;
while((y > a(round(1.2/h + 700/2 +3))+.1) && (y < (b(round(1.2/h + 700/2 + 3))-.15))) | (y > (b(round(1.2/h + 700/2 + 3))+.4)) | (y < (a(round(1.2/h + 700/2 + 3))-.3)); 

if y > 30   % if you go too high, sends you underneath
    y = -20;
elseif y< -30 %if you go too low, sends you up top
    y = 20;
end

if rem(istep +9999, 10000) ==0    
     [u, Fs] = audioread('SuperMarioBros.mp3');
     player = audioplayer(u, Fs)
     play(player);   
end

  k=get(gcf,'CurrentCharacter');    %% Flap! check for key to change velocity
  if k~='@' % has it changed from the dummy character?
    set(gcf,'CurrentCharacter','@'); % reset the character
    %process the key 
    if k=='w'
        v = 11.7;
    elseif k=='s'
        v = v - 10;   % DIVE
    elseif k =='o' % Easter Egg
         b(500:600) = 0;
    elseif k=='m'
     stop(player)
     [l, Fl] = audioread('Amerika.mp3');
     player = audioplayer(l, Fl)
     play(player);
     America = 1
    elseif k=='l'
        a(500:600) = 7;
    end
  end
    text(1.2, 15, 'Fly away! Be Free!','FontSize', 20);
                    % Lax-Wendroff method
    a(xi) = 1.0*(a(xi) + coeff_ftcs*(a(xp)-a(xm))+ (2*(coeff_ftcs)^2)*(-2*a(xi)+a(xp)+a(xm)));  % Bottom avection
    b(xi) = 1.0*(b(xi) + coeff_ftcs*(b(xp)-b(xm))+ (2*(coeff_ftcs)^2)*(-2*b(xi)+b(xp)+b(xm)));  % Top avection 
    b(400) = 7;  % Erase past top barriers
    a(400) = 0;  % Erase past bottom barriers
    v = v + accel*tau;  %new velocity
    y = y + v*tau;  %new position
   


    istep = istep +1;
    
    if rem(istep, 500) == 0
        level = level + 1;
        text(1.3, 4, 'LEVEL UP!', 'Color', 'black', 'FontSize', 35);
        if level < 10
            space = space - 3;
        end
    end
    
    figure(1)
    plot(x,a,'-', 'LineWidth', 5); ylim([ylowlimit, yuplimit]); xlim([1,2])
    hold on  
    plot(x,b,'-', 'LineWidth', 5); 
    score='SCORE ';
    text(1.5, 7.5, [score, num2str(istep), '  LEVEL ', num2str(level)], 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
    text(1, 7.5, ['Coins ', num2str(CoinCounter)], 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
    text(1.2, 7.5, ['Lives ', num2str(lives)], 'Color', 'blue', 'FontSize', 20, 'FontName','HoboSTD' )
    plot(1.2, y ,shape,'MarkerFaceColor',color, 'MarkerEdgeColor', color, 'MarkerSize', 20)
    title('Floaty Shape', 'Color', 'black', 'FontSize', 25, 'FontName','Goudy Stout')
    axis off
    
    
    
     r3 = round(rand * 50);      % Idea to collect coins for more points
     if r3 == 1 && c1x < 1
         c1x = 2.1;
         c1y = max(a(round(2.1*700*h + 320):round(2.1*700*h +370))) + 2;
     end
     c1x = c1x - h;
     plot(c1x, c1y, 'o', 'MarkerSize', 10,'MarkerFaceColor',[1,.87,.27] )   
     if c1x < 1.25 & c1x > 1.15 & abs(c1y - y) < .3
         CoinCounter = CoinCounter +1;
         c1x = 0;
     end
    if CoinCounter == 5
        CoinCounter = CoinCounter -5
        lives = lives +1
    end
    hold off
    pause(.01);
    x0(istep)=a(1);
    t = tau + t;
    time(istep) = t;
    c=c+.1;
    
    
    
    r1 = rand * 4.5;
    r2 = rand * 4.5;
  
    bottom = bottom + 1;
    top = top +1;
    if r1 + r2 > 6
        continue 
    else
        if round(r1*5) == 1 & bottom > 10 & top > 10 & (6-r1)+ top > space
            b= b +(-(r2)*(1./cosh(5*x.^2/h).^2));
            bottom = 0;
        end
        if  round(r2*5)== 1 & top > 10 & bottom > 10 & (6-r2)+ bottom > space
            a= a + (r1)*1./cosh(5*x.^2/h).^2;
            top = 0;
        end
    end
    
    

    

    if rem(istep, 500) == 0
        shapeshift = shapeshift + 1;
        if rem(shapeshift,6) == 0
            shape = 's';
        elseif rem(shapeshift,6) == 1
            shape = 'o';
        elseif rem(shapeshift,6) == 2
            shape = 'd';
        elseif rem(shapeshift,6) == 3
            shape = 'h';
        elseif rem(shapeshift,6) == 4
            shape = 'x';
        elseif rem(shapeshift,6) == 5
            shape = '*';
        end
        
    end   
  if America == 1 %Shape is a star when Amerika plays
      shape = 'p'
  end
    
    

    if rem(istep, 7) == 0
        colorshift = colorshift + 1;
        if rem(colorshift,6) == 0
            color = 'r';
        elseif rem(colorshift,7) == 1 
            if America == 1
                continue
            else
            color = 'g';
            end
        elseif rem(colorshift,7) == 2 
            color = 'b';
        elseif rem(colorshift,7) == 3 
             if America == 1 
                continue
            else
            color = 'c';
             end
        elseif rem(colorshift,7) == 4 
             if America == 1
                continue
            else
            color = 'm';
             end
        elseif rem(colorshift,7) == 5 
             if America == 1
                continue
            else
            color = 'y';
             end
        elseif rem(colorshift, 7) ==6 && America == 1
            color = 'white'
            
        end
    end
    
    
    
     if  y > 8 | y < 0;     
         ylowlimit = y-3.5;   %%Sets view to follow you when you escape
         yuplimit = y+3.5;
    
     else
         ylowlimit = 0;
         yuplimit = 8;
     end

end

if lives > 0
text(1.0, 4, '\bf We''re dead!  We''re dead!', 'Color', 'black', 'FontSize', 20);
text(1.0, 3.5, '\bf We survived! But we''re dead!', 'Color', 'black', 'FontSize', 20);
text(1.0, 2, '\bf Press any key to continue.', 'Color', 'black', 'FontSize', 20);
pause
end


end
stop(player);
     [q, Fq] = audioread('SadTrombone.mp3');
     Trombone = audioplayer(q, Fq)
     play(Trombone); 
text(1.2, 4, '\bf GAME OVER', 'Color', 'black', 'FontSize', 35);
text(1.4, 2.7, '\bf LOSER', 'Color', 'black', 'FontSize', 35, 'FontName', 'Arial Black', 'FontWeight', 'bold', 'Rotation', 20);
