%Importation des caracteres dans la base de donnees

function bdd = importation(Liste_Caractere)
 N = length (Liste_Caractere);
 
bdd = cell (1,N);

    %Importation des caracteres majuscules
    for i = 1:26
        nom = strcat('01 - base de donnees/',Liste_Caractere(i),'_monospace.PNG');  
        bdd{i} = imcomplement(rgb2gray(imread(nom)));                      %imcomplement pour l'inversion noir/blanc
    end
    
    %Importation des caracteres minuscules
    for i = 27:52
        nom = strcat('01 - base de donnees/',Liste_Caractere(i),'_petit.PNG');
        bdd{i} = imcomplement(rgb2gray(imread(nom)));
    end
    
    %Importation des chiffres
    for i = 53:62
        nom = strcat('01 - base de donnees/',Liste_Caractere(i),'.PNG');
        bdd{i} = imcomplement(rgb2gray(imread(nom)));
    end
    
    %Importation de la ponctuation
    for i = 63:74
        nom = strcat('01 - base de donnees/','p_',num2str(i),'.PNG');
        bdd{i} = imcomplement(rgb2gray(imread(nom)));
    end
    
    %Importation des accents
    for i = 75:87
        nom = strcat('01 - base de donnees/','a_',num2str(i),'.PNG');
        bdd{i} = imcomplement(rgb2gray(imread(nom)));
    end
end