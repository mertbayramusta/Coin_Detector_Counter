% Clear workspace
clear all
close all

%We imported our picture.
imageorj=imread('white_united.jpeg'); 
figure(1),imshow(imageorj);

%We converted our picture to black and white picture. (2-Dimension)
image=rgb2gray(imageorj); 
level=graythresh(image);
bw=im2bw(image,level);
figure(2),imshow(bw);

%We took the complement of our image.
bw=imcomplement(bw); 
figure(3),imshow(bw);

%We filled the accessible holes in the image.
bw=imfill(bw,'holes');

%The objects has less than 30 px removed.
bw = bwareaopen(bw,30);
figure(4),imshow(bw);

%We created a disk-shaped structural element with a radius of 12px.
se=strel('disk',12,0); 

%If any united coins occurred in the image, we have seperated it.
bw2=imerode(bw,se); 
figure(5),imshow(bw2);

% We learned the amount of coins with length(B) and assigned a label
[B,L] = bwboundaries(bw2);  
stats = regionprops(bw2, 'Area','Centroid');
figure(6),imshow(imageorj);    
total = 0;  %this variable is for total amount of coins 
count1=0;   %this variable is to count the number of 1 liras
count50=0;  %this variable is to count the number of 0.5 liras
count25=0;  %this variable is to count the number of 0.25 liras
count10=0;  %this variable is to count the number of 0.1 liras
count5=0;   %this variable is to count the number of 0.05 liras
for n=1:length(B) 
  % We learned the area of each coin and we calculated according to their areas. 
  %Then we counted each coin accordingly. 
  a=stats(n).Area;           
  centroid=stats(n).Centroid;            
  if a> 1100                 
    total = total + 1; 
    count1=count1+1;    
    text(centroid(1),centroid(2),'1TL');              
  elseif a >800 &&  a < 1050               
    total = total + 0.5; 
    count50=count50+1;      
    text(centroid(1),centroid(2),'50Kr');            
  elseif a >380 &&  a < 650                
    total = total + 0.25; 
    count25=count25+1;      
    text(centroid(1),centroid(2),'25Kr');            
  elseif a > 280 &&  a < 380                
    total = total + 0.10;  
    count10=count10+1;      
    text(centroid(1),centroid(2),'10Kr');            
  else             
    total = total + 0.05; 
    count5=count5+1;      
    text(centroid(1),centroid(2),'5Kr');      
  
  end    
end   
title([num2str(count1),' x 1 TL + ', num2str(count50),' x 50 Kr + ', num2str(count25),' x 25 Kr + ', num2str(count10),' x 10 Kr + ', num2str(count5),' x 5 Kr. ', 'The total money amount= ',num2str(total),' TL'])   

