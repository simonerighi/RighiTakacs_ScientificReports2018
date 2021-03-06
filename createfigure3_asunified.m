function createfigure(XMatrix1, YMatrix1, DMatrix1, XMatrix2, YMatrix2, DMatrix2, XMatrix3, YMatrix3, DMatrix3, XMatrix4, YMatrix4, DMatrix4, YMatrix5, DMatrix5, YMatrix6, DMatrix6, YMatrix7, DMatrix7, YMatrix8, DMatrix8)
% Generates figure 3 of Righi Takacs (2018, Scientific Reports) as one
% single figure with multiple panels)

%CREATEFIGURE(XMatrix1, YMatrix1, DMatrix1, XMatrix2, YMatrix2, DMatrix2, XMatrix3, YMatrix3, DMatrix3, XMatrix4, YMatrix4, DMatrix4, YMatrix5, DMatrix5, YMatrix6, DMatrix6, YMatrix7, DMatrix7, YMatrix8, DMatrix8)
%  XMATRIX1:  errorbar x matrix data
%  YMATRIX1:  errorbar y matrix data
%  DMATRIX1:  errorbar delta matrix data
%  XMATRIX2:  errorbar x matrix data
%  YMATRIX2:  errorbar y matrix data
%  DMATRIX2:  errorbar delta matrix data
%  XMATRIX3:  errorbar x matrix data
%  YMATRIX3:  errorbar y matrix data
%  DMATRIX3:  errorbar delta matrix data
%  XMATRIX4:  errorbar x matrix data
%  YMATRIX4:  errorbar y matrix data
%  DMATRIX4:  errorbar delta matrix data
%  YMATRIX5:  errorbar y matrix data
%  DMATRIX5:  errorbar delta matrix data
%  YMATRIX6:  errorbar y matrix data
%  DMATRIX6:  errorbar delta matrix data
%  YMATRIX7:  errorbar y matrix data
%  DMATRIX7:  errorbar delta matrix data
%  YMATRIX8:  errorbar y matrix data
%  DMATRIX8:  errorbar delta matrix data
 
%  Auto-generated by MATLAB on 29-Oct-2017 18:47:08
 
% Create figure
figure('PaperUnits','inches');
 
% Create axes
axes1 = axes('Position',...
[0.03046875 0.607023411371237 0.218828125 0.268415185119991]);
hold(axes1,'on');


% Create multiple error bars using matrix input to errorbar
errorbar1 = errorbar(XMatrix1,YMatrix1,DMatrix1);
set(errorbar1(1),'DisplayName','TFT=0, CR=UR=UD=UC=SJ=1/5','Color',[0 0 0]);
set(errorbar1(2),'DisplayName','TFT=CR=UR=UD=UC=SJ=1/6','Color',[1 0 0]);
 
% Create ylabel
ylabel('Prop. of Cooperation');
 
% Create title
title({'Effect of Population Size','Copy the Best'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes1,[55 605]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes1,[0 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',14);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
'Position',[0.0408408717105263 0.798404202473797 0.186677631578947 0.070264765784114]);
 
% Create axes
axes2 = axes('Position',...
[0.28046875 0.607023411371237 0.21875 0.268415185119991]);
hold(axes2,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar2 = errorbar(XMatrix2,YMatrix2,DMatrix2);
set(errorbar2(1),'Color',[0 0 0]);
set(errorbar2(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create title
title({'Effect of Network Density','Copy the Best'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes2,[0.02 0.205]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes2,[0 1]);
box(axes2,'on');
% Set the remaining axes properties
set(axes2,'FontSize',14);
% Create axes
axes3 = axes('Position',...
[0.53046875 0.607023411371237 0.21875 0.268415185119991]);
hold(axes3,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar3 = errorbar(XMatrix3,YMatrix3,DMatrix3);
set(errorbar3(1),'Color',[0 0 0]);
set(errorbar3(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create title
title({'Effect of Forgiveness','Copy the Best'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes3,[-0.01 1.01]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes3,[0 1]);
box(axes3,'on');
% Set the remaining axes properties
set(axes3,'FontSize',14);
% Create axes
axes4 = axes('Position',...
[0.78046875 0.607023411371237 0.21875 0.268415185119991]);
hold(axes4,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar4 = errorbar(XMatrix4,YMatrix4,DMatrix4);
set(errorbar4(1),'Color',[0 0 0]);
set(errorbar4(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create title
title({'Effect of Evolution','Copy the Best'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes4,[-0.01 0.22]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes4,[0 1]);
box(axes4,'on');
% Set the remaining axes properties
set(axes4,'FontSize',14);
% Create axes
axes5 = axes('Position',...
[0.03046875 0.232441471571906 0.21875 0.270550959338144]);
hold(axes5,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar5 = errorbar(XMatrix1,YMatrix5,DMatrix5);
set(errorbar5(1),'Color',[0 0 0]);
set(errorbar5(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel('Prop. of Cooperation');
 
% Create xlabel
xlabel('Population Size');
 
% Create title
title({' ','Copy the Better'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes5,[55 605]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes5,[0 1]);
box(axes5,'on');
% Set the remaining axes properties
set(axes5,'FontSize',14);
% Create axes
axes6 = axes('Position',...
[0.28046875 0.232441471571906 0.21875 0.270468814175908]);
hold(axes6,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar6 = errorbar(XMatrix2,YMatrix6,DMatrix6);
set(errorbar6(1),'Color',[0 0 0]);
set(errorbar6(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create xlabel
xlabel('Network Density');
 
% Create title
title({' ','Copy the Better'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes6,[0.02 0.205]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes6,[0 1]);
box(axes6,'on');
% Set the remaining axes properties
set(axes6,'FontSize',14);
% Create axes
axes7 = axes('Position',...
[0.53046875 0.232441471571906 0.21875 0.270468814175908]);
hold(axes7,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar7 = errorbar(XMatrix3,YMatrix7,DMatrix7);
set(errorbar7(1),'Color',[0 0 0]);
set(errorbar7(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create xlabel
xlabel('Prob. Forgiveness');
 
% Create title
title({' ','Copy the Better'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes7,[-0.01 1.01]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes7,[0 1]);
box(axes7,'on');
% Set the remaining axes properties
set(axes7,'FontSize',14);
% Create axes
axes8 = axes('Position',...
[0.78046875 0.230769230769231 0.21875 0.272141054978584]);
hold(axes8,'on');
 
% Create multiple error bars using matrix input to errorbar
errorbar8 = errorbar(XMatrix4,YMatrix8,DMatrix8);
set(errorbar8(1),'Color',[0 0 0]);
set(errorbar8(2),'Color',[1 0 0]);
 
% Create ylabel
ylabel(' ');
 
% Create xlabel
xlabel('Prob. Evolution');
 
% Create title
title({' ','Copy the Better'});
 
% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes8,[-0.01 0.22]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes8,[0 1]);
box(axes8,'on');
% Set the remaining axes properties
set(axes8,'FontSize',14);
