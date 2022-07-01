function handle=plot_robot(q,params,real)
    hold on
    grid

    [p0, p1, p2,  p3, p4] = forward_kinematics(q,params);

    if real
        % plot telaio
        plot3(p0(1),p0(2),p0(3),'ko','linewidth',4); % plot telatio
        % plot dei restanti link
        handle=plot3([p0(1) p1(1) p2(1) p3(1) p4(1)],[p0(2) p1(2) p2(2) p3(2) p4(2)],[p0(3) p1(3) p2(3) p3(3) p4(3)],'-ko','linewidth',2);
    else
        % plot telaio
        plot3(p0(1),p0(2),p0(3),'bo','linewidth',4);
        % plot dei restanti link
        handle=plot3([p0(1) p1(1) p2(1) p3(1) p4(1)],[p0(2) p1(2) p2(2) p3(2) p4(2)],[p0(3) p1(3) p2(3) p3(3) p4(3)],'-bo','linewidth',2);
    end
