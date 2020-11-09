 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %              Projet reconnaissance optique des caracteres             %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %
 % Binome : 
 % - CHAN Jayvin
 % - GOOR Aurelien
 %
 % GE4 - Groupe2
 %

close;
clear;

%-------------------------------------------------------------------------
%Image de reference
majuscule = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
minuscule = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
chiffre = ['0','1','2','3','4','5','6','7','8','9'];
ponctuation = ['.' , ',' , ';' , '-' , '(' , ')' , '!' , ':' , '<' , '>' , '?' , '*' ];
accents = ['é','â','ê','î','ô','û','à','è','ù','ë','ï','ü','ç'];

Liste_Caractere = [majuscule ,minuscule ,chiffre ,ponctuation ,accents];
%Importation dans la Base de donnees
BDD= importation(Liste_Caractere);

%-------------------------------------------------------------------------
%Overture de l'image du texte
disp('Ouverture de l image');
img = imread('02 - Image test/Image 16.3.jpg');

%Traitement de l'image
disp('Traitement de l image');
img = traitement(img);                                                      %Fonction de traitement
[hauteur,longueur]=size(img);
pause(1);

%Seuil de detection du noir
global seuil
seuil= 128;

%Fichier texte de sauvegarde
File = fopen('Texte.txt', 'w');


%-------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         DEBUT de la detection          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Debut de la detection');
%Initialisation de depart
yb=0;
l = yb+1;

while(l<hauteur)                                                            %Boucle sur les lignes
    
    %--------------------------------------
    %Detection de la ligne haute
    l = yb+1;
    existe = 0;                                                             %0 s'il n'y a aucun pixel noir sur la ligne
    
    while (not (existe)) && (l<hauteur)                                     %Recherche d'une ligne contenant un pixel noir
        existe = sum(img(l, :)<= seuil) >0;                                 %Detection d'un pixel noir sur la ligne l
        l=l+1;
    end
    yh=l-1;
    
    %--------------------------------------
    %Detection de la ligne basse
    existe = 1;                                                             %Existe t-il au moins un noir
    while (existe) && (l<hauteur)                                           %Recherche d'une ligne entirement blanche
        existe = sum(img(l, :)<= seuil) >0;                                 %Si il y a au moins un pixel noir
        l=l+1;
    end
    yb=l-1;

    %--------------------------------------
    fin = 0;                                                                %Fin du caractere
    c=fin+1;                                                                %Depart de la premiere colone

    while(c<longueur)                                                       %Boucle sur les colonnes
        
        %--------------------------------------------------
        %Detection du début du premier caractère
        existe = 0;                                                         %0 s'il n'y a aucun pixel noir sur la colonne
        c=fin+1;
        while (not (existe)) && (c<longueur)                                %Recherche d'une colonne avec au moins un pixel noir
            existe = sum(img(yh:yb, c)<= seuil) >0;                         %Existe t-il au moins un pixel noir
            c=c+1;
        end
        debut=c-1;
        
        %--------------------------------------------------
        %Detection de la fin du premier caractère
        existe = 1;    
        while (existe) && (c<longueur)                                      %Recherche d'une colonne entirement blanche
            existe = sum(img(yh:yb, c)<= seuil) >0;                         %Existe t-il au moins un pixel noir
            c=c+1;
        end
        fin_precedent = fin;
        fin=c-1;
        
        %--------------------------------------------------
        %Analyse du caractere
        if(c<longueur)
            if (debut-fin_precedent > 0.80*(fin-debut) && fin_precedent ~= 0)%Y a-t-il un espace avant ce caractère
                disp("Espace");
                fprintf(File, ' ');                                         %Ecrit un espace
            end
            
            %Analyse du caractere
            Image1 = img(yh:yb,debut:fin);                              %Delimite le caratère
            caractere = Detection_caractere(Image1, BDD, Liste_Caractere);  %Detection du caractere
            disp (caractere);
            fprintf(File, caractere);                                   %Sauvegarde du caratere
        end
    end
    disp('saut de ligne');
    fprintf(File, '\n');                                                    %Ecrit un saut a la ligne
end

fclose(File);
