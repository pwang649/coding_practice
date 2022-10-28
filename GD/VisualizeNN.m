function VisualizeNN(network)
%
% Description: create a graphic depiction of a simple neural network with
%    number of layers between 2 and 5 and each layer with no more than 5
%    neurons,
%
nLayer=length(network);
if (nLayer<2) || (nLayer>5)
    disp('VisualizeNN: This routine only works for network with number of layers between 2 and 5.');
    return;
end
maxN=-inf;
Layer=zeros(1,nLayer+1);
for iLayer=1:nLayer
    wDim=size(network(iLayer).Weight);
    if (wDim(1)<1) || (wDim(2)>5)
        disp('VisualizeNN: This routine only works for network with less than 5 neurons in each layer.');
        return;
    end
    maxN=max([maxN,wDim(2)-1,wDim(1)]);
    if iLayer==1
        Layer(iLayer)=wDim(2)-1;
    end
    Layer(iLayer+1)=wDim(1);
end
figure;
hold on
ColorTable=colormap('lines');
theta=2*pi*[0:180]/180;
x0=cos(theta);
y0=sin(theta);
for k=1:Layer(1)
    %plot(x0,3*(-Layer(1)/2+k)+y0,'LineWidth',[4],'Color',ColorTable(k,:));
    for j=1:Layer(2)
        dy=3*(-Layer(2)/2+j)-3*(-Layer(1)/2+k);
        quiver(x0(1), 3*(-Layer(1)/2+k)+y0(1),4,dy,0,'filled','LineWidth',[2],'Color',ColorTable(k,:));
    end
    text(0,3*(-Layer(1)/2+k),['I_',num2str(k)],'HorizontalAlignment','center','VerticalAlignment','middle');
end
for iLayer=2:nLayer
    for k=1:Layer(iLayer)
        plot(6*(iLayer-1)+x0,3*(-Layer(iLayer)/2+k)+y0,'LineWidth',[4],'Color',ColorTable(k,:));
        text(6*(iLayer-1),3*(-Layer(iLayer)/2+k),['N^',num2str(iLayer-1),'_',num2str(k)],...
            'HorizontalAlignment','center','VerticalAlignment','middle');
        for j=1:Layer(iLayer+1)
            dy=3*(-Layer(iLayer+1)/2+j)-3*(-Layer(iLayer)/2+k);
            quiver(6*(iLayer-1)+x0(1), 3*(-Layer(iLayer)/2+k)+y0(1),4,dy,0,'filled','LineWidth',[2],'Color',ColorTable(k,:));
        end
    end
end
for k=1:Layer(nLayer+1)
    plot(6*nLayer+x0,3*(-Layer(nLayer+1)/2+k)+y0,'LineWidth',[4],'Color',ColorTable(k,:));
    text(6*nLayer,3*(-Layer(nLayer+1)/2+k),['N^',num2str(nLayer),'_',num2str(k)],...
        'HorizontalAlignment','center','VerticalAlignment','middle');
    quiver(6*nLayer+x0(1), 3*(-Layer(nLayer+1)/2+k)+y0(1),2,0,0,'filled','LineWidth',[2],'Color',ColorTable(k,:));
    text(6*nLayer+4,3*(-Layer(nLayer+1)/2+k),['O_',num2str(k)],...
        'HorizontalAlignment','center','VerticalAlignment','middle');
end
axis equal
axis off
set(gcf,'Color','w')
return
end
        