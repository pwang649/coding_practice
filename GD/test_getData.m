function test_getData
[x,y]=getData(1000,2,2338580531);
figure;
ind=find(y==1);
plot(x(1,ind),x(2,ind),'o','MarkerFaceColor','r','MarkerEdgeColor','r','MarkerSize',[5]);
hold on
ind=find(y==0);
plot(x(1,ind),x(2,ind),'o','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',[5]);
return;
end