function [] = partA()
  x = 2;
  y = 3.5;
  xSpeed = 0;
  ySpeed = 0;
  dTime = 1 / 100;
  clf;
  hold on;
  axis([0 6 0 5]);
  for time = [0:dTime:10]
    iX = sin(2*time);
    iY = -2*cos(2*time);
    [x y xSpeed ySpeed] = robotMotionModel(x, y, xSpeed, ySpeed, iX, iY, dTime);
    scatter(x, y, 'b');
  end
end
