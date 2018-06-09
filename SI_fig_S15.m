clear all
close all
clc

figure(1)
load NS_29_testUR_newlattice.mat
for i=1:size(prop_coop,2)
    ix=prop_coop(:,i)>0.5;
    mpropcoop(i)=mean(prop_coop(ix,i));
    stdpropcoop(i)=std(prop_coop(ix,i));
end
errorbar(init_C,mpropcoop,stdpropcoop,'r-');
clear ix mpropcoop stdpropcoop
hold on
for i=1:size(prop_coop,2)
    ix=prop_coop(:,i)<=0.5;
    mpropcoop(i)=mean(prop_coop(ix,i));
    stdpropcoop(i)=std(prop_coop(ix,i));
    nummin05_UR(i)=sum(ix);
    clear ix
end
errorbar(init_C,mpropcoop,stdpropcoop,'r-.');
clear mpropcoop stdpropcoop
hold on
plot(init_C,nummin05_UR./size(prop_coop,1),'r:','LineWidth',4);
ylim([-0.01 1.01]) 
load NS_29_testCR_newlattice.mat
errorbar(init_C,mean(prop_coop),std(prop_coop),'b-');
hold on
legend('UR with cooperation > 0.5','UR with cooperation <= 0.5','Prop. Sim. with Coop<0.5','CR','Location','best')
title('Proportion of Cooperating Acts','FontSize',18)
xlabel('Initial Proportion of Cooperation','FontSize',18)
ylabel('Final Proportion of Cooperation','FontSize',18)
saveas(1,'AllEqual_PropCoop','fig');
print('-depsc', 'AllEqual_PropCoop');
