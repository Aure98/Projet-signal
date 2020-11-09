%Fonction qui identifie le caractere contenue dans Image1

function Caractere = Detection_caractere(Image1, BDD, Liste_Caractere)
    %Ajustement de l'image autour du caractere
    [H1, L1] = size(Image1);
    [a,b,c,d] = cadre(Image1);
    Image1 = Image1(a:b, c:d);
    
    %Initialisation
    V_Max =0;
    n=length(Liste_Caractere);
    
    %Intercorrelation de l'image avec tous les caracteres de la base de donnees
    Image1 = imcomplement(Image1);                                          %Inversion des couleurs
    Caractere = '?';                                                        %Valeur de sécurité si aucun n'est satisfaisant par la suite
    for (i=1:n)
        temp = Intercorrelation2(Image1, BDD{i});                           %Intercorrelation
        %disp(Liste_Caractere(i));
        %disp(temp);
        if temp > V_Max
            V_Max = temp;
            Caractere = Liste_Caractere(i);
            %pause();
        end
        if((Caractere == '.' || Caractere == ',')&&(b < H1*0.6))            %Detection des apostrophes
            Caractere = "'";
        end
        
        %pause();
        %disp("New");
    end
end
