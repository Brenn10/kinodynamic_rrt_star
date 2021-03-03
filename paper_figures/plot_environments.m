h1 = openfig('no_obstacle/no_obstacle.fig','reuse');
ax1 = gca;
h2 = openfig('window/window_2.fig','reuse');
ax2 = gca;
h3 = openfig('obstacle_course/obstacle_course.fig','reuse');
ax3 = gca;
h4 = openfig('window_3/window_3.fig','reuse');
ax4 = gca;

h5 = figure;
s1= subplot(2,2,1);
axis equal
s2= subplot(2,2,2);
axis equal
s3= subplot(2,2,3);
axis equal
s4= subplot(2,2,4);
axis equal

fig1 = get(ax1,'children');
axis equal
fig2 = get(ax2,'children');
axis equal
fig3 = get(ax3,'children');
axis equal
fig4 = get(ax4,'children');
axis equal

copyobj(fig1,s1);
axis equal
copyobj(fig2,s3);
axis equal
copyobj(fig3,s2);
axis equal
copyobj(fig4,s4);
axis equal