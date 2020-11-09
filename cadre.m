%Fonction détection de caractère

function [yh,yb,xg,xd] = cadre(tableau)
    [hauteur,longueur]=size(tableau);
    global seuil;
    
    %---------------------------------------------------------------------
    %Detection de la ligne haute
    existe = 0;                                                             %0 s'il n'y a aucun pixel noir sur la ligne
    l=1;                                                                    %Commencement à la 1ere ligne
    while (not (existe)) && (l<hauteur)                                     %Recherche d'une ligne avec un pixel noir
        existe = sum(tableau(l, :)<= seuil) >0;                             %Detection d'un pixel noir sur la ligne l
        l=l+1;
    end
    yh=l-1;
    
    %---------------------------------------------------------------------
    %Detection de la ligne basse
    existe = 0;
    l = hauteur-1;
    while (not (existe)) && (l>0)                                           %Recherche d'une ligne avec un pixel noir
        existe = sum(tableau(l, :)<= seuil) >0;                             %Si il y a au moins un pixel noir
        l=l-1;
    end
    yb=l+1;


    %---------------------------------------------------------------------
    %Detection du début du premier caractère
    existe = 0;                                                             %0 s'il n'y a aucun pixel noir sur la colonne
    c=1;
    while (not (existe)) && (c<longueur)                                    %Recherche d'une colonne avec un pixel noir
        existe = sum(tableau(yh:yb, c)<= seuil) >0;
        c=c+1;
    end
    xg=c-1;
    
    %---------------------------------------------------------------------
    %Detection de la fin du premier caractère
    existe = 0;
    c = longueur;
    while (not (existe)) && (c>0)                                           %Recherche d'une colonne avec un pixel noir
        existe = sum(tableau(yh:yb, c)<= seuil) >0;                         %Existe t-il au moins un pixel noir
        c=c-1;
    end
    xd=c+1;
end
