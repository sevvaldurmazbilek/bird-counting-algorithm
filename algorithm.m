%% GrayScale Conversion 

[FileName,PathName]=uigetfile('*.*','please select the image file');

I=imread(FileName);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
I=.299*R+.587*G+.114*B; 

%% Thresholding

n=imhist(I);
N=sum(n);
max=0; %initialize maximum to zero
for i=1:256
    P(i)=n(i)/N; %intensity levels
end
for T=2:255     
    c1=sum(P(1:T)); % class 1 
    c2=sum(P(T+1:256)); %class 2
    m0=dot([0:T-1],P(1:T))/c1; % mean of class 1
    m1=dot([T:255],P(T+1:256))/c2; % mean of class 2
    sigma=c1*c2*((m1-m0)^2); % variance (between class)
    if sigma>max 
        max=sigma; % update the value of max
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end
A=I<threshold; % Binary Image
%subplot(1,2,1),imshow(I),title('Grayscale Image');
%subplot(1,2,2), imshow(A),title('Binary Image');


%% morphological operations
%opening

S=[0 1 0;1 1 1;0 1 0]; %structuring element
K=0;
A1=zeros(length(A(:,1)),length(A(1,:)));
for j=1:length(A(1,:))-2
   for i=1:length(A(:,1))-2
    K=A(i:i+2,j:j+2); 
    C=sum(sum(K.*S));
    if C==sum(sum(S))
    A1(i+1,j+1)=1;
    else A1(i+1,j+1)=0;  
    end
   end  
end
A=A1;
K=0;
A1=zeros(length(A(:,1)),length(A(1,:)));
A=ones(length(A(:,1)),length(A(1,:)))-A;
for j=1:length(A(1,:))-2
   for i=1:length(A(:,1))-2
    K=A(i:i+2,j:j+2); 
    C=sum(sum(K.*S));
    if C<sum(sum(S))
    A1(i+1,j+1)=1;
    else A1(i+1,j+1)=0;  
    end
   end 
end
A1=ones(length(A(:,1)),length(A(1,:)))-A;

%closing

A2=zeros(length(A1(:,1)),length(A1(1,:)));
A1=ones(length(A1(:,1)),length(A1(1,:)))-A1;
for j=1:length(A1(1,:))-2
   for i=1:length(A1(:,1))-2
    K=A1(i:i+2,j:j+2); 
    C=sum(sum(K.*S));
    if C<sum(sum(S))
    A2(i+1,j+1)=1;
    else A2(i+1,j+1)=0;  
    end
   end 
end
A1=ones(length(A1(:,1)),length(A1(1,:)))-A1;
A1=A2; K=0;
A2=zeros(length(A1(:,1)),length(A1(1,:)));
for j=1:length(A1(1,:))-2
   for i=1:length(A1(:,1))-2
    K=A1(i:i+2,j:j+2); 
    C=sum(sum(K.*S));
    if C==sum(sum(S))
    A2(i+1,j+1)=1;
    else A2(i+1,j+1)=0;  
    end
   end  
end
A2=ones(length(A1(:,1)),length(A1(1,:)))-A1;

%subplot(1,2,1),imshow(A1),title('Opening');
%subplot(1,2,2),imshow(A2),title('Closing');

%% connected components labeling

[x,y] = size(A1); %row and col
A1 = [zeros(1,y+2);[zeros(x,1) A1 zeros(x,1)]];
labels = zeros(size(A1));
label2 = 1;
link = [];
for i = 2:x       
    for j = 2:y-1            
        if A1(i,j) ~= 0 
            % 8-connectivity
            neighbours = [A1(i-1,j-1), A1(i-1,j), A1(i-1,j+1),A1(i,j-1)]; 
            [~,n,neighbours] = find(neighbours==1);
            if isempty(neighbours)
                link{label2} = label2;
                labels(i,j) = label2;
                label2 = label2+1;                
            else
                neighbourslabel = [labels(i-1,j-1), labels(i-1,j), labels(i-1,j+1),labels(i,j-1)];
                L = neighbourslabel(n);
                labels(i,j) = min(L);
                for k = 1:length(L)
                    label = L(k);
                    link{label} = unique([link{label} L]);
                end                
            end
        end
    end
end

% remove the previous expansion of the image

labels = labels(2:end,2:end-1);
change2 = 1;
while change2 == 1
    change = 0;
    for i = 1:length(link)
        for j = 1:length(link)
            if i ~= j
                if sum(ismember(link{i},link{j}))>0 && sum(ismember(link{i},link{j})) ~= length(link{i})
                    change = 1;
                    link{i} = union(link{i},link{j});
                    link{j} = link{i};
                end
            end
        end
    end  
    if change == 0
        change2 = 0;
    end    
end
link = unique(cellfun(@num2str,link,'UniformOutput',false));
link = cellfun(@str2num,link,'UniformOutput',false);
K = length(link);
t= labels;
labels = zeros(size(labels));
% label linked labels with a single label:
for k = 1:K
    for l = 1:length(link{k})
        labels(t== link{k}(l)) = k;
    end
end

%% counting

figure,imshow(A1),title('Object Numbers')
text(10,10,strcat('\color{red}',num2str(length(link)),'\color{red} object found'))
hold on;
for k=1:length(link)
label = link{k}; 
plot(label(:,2),label(:,1),'b','LineWidth',2);
end