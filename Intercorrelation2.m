%Fonction d'intercorrelation
function Resultat=Intercorrelation2(Image1, Image2)
    
    [H1, L1] = size(Image1);                                                %Calcul des rapports de taille
    [H2, L2] = size(Image2);
    rapport1 = H1/L1;
    rapport2 = H2/L2;
    
    if(rapport1>2 || rapport1<0.5)
        ref = 0.7;
    else
        ref = 0.19;
    end
    
    if (abs(rapport1-rapport2)/rapport1 < ref)                            %Si les rapport ont une diff inferieur a ref
        %Calcul des moyennes
        Image1 = imresize(Image1, [3*H1, 3*L1]);
        Image2 = imresize(Image2, [3*H1, 3*L1]);
        
        moy1 = sum(sum(Image1))/(9*H1*L1);
        moy2 = sum(sum(Image2))/(9*H1*L1);
        Resultat = sum(sum((Image1-moy1).*(Image2-moy2)))/sqrt(sum(sum((Image1-moy1).^2))*sum(sum((Image2-moy2).^2)));
        %imshowpair(Image1, Image2, 'montage');
    else
        Resultat = 0;
    end
    %disp(Resultat)
end