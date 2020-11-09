%Traimtement d'image

function nouvelle_image = traitement ( img )
    %Effacement des taches parasites
    disp('Conversion en niveau de gris');
    img = im2bw(img);
    bw2 = imcomplement(img);
    bw3 = bwareaopen(bw2, 8);
    img = uint8(imcomplement(bw3)*255);
    
    %Detection de la rotation de l'image
    disp('Detection de la rotation de l image');
    img = imcomplement(img);                                                %Imcomplement permet d'inverser le blanc et le noir, en effet lors de la rotation , des parties noires sont complétées afin de garder le format rectangulaire droit
    angle = 0;
    max = 0;
    for theta = -5.0:0.1:5.0                                                %Angle de rotation entre -5 et -5 degres
        img2 = imrotate(img,theta);
        vecteur = sum(img2'>128);
        nulles = sum ( vecteur < 5);                                        %nombre de lignes sans pixel noir qui est maximal lorsque l'image est "droite"
        if nulles > max
            max = nulles;
            angle = theta;
        end
    end
    nouvelle_image = imrotate (img , angle);
    nouvelle_image = imcomplement(nouvelle_image);                          %On complémente de nouveau pour se ramener à du noir sur du blanc
    disp('Angle');
    disp(angle);
end

