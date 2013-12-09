function [] = partB()
  % Robot state
  x = 2;
  y = 3.5;
  xSpeed = 0;
  ySpeed = 0;

  % Wand state - put the wand in a logical position
  wandX = 3;
  wandY = 1;
  wandXSpeed = 0;
  wandYSpeed = 0;

  dTime = 1 / 100;

  clf;
  hold on;
  axis([0 6 0 5]);

  for time = [0:dTime:10]
    iX = sin(2*time);
    iY = -2*cos(2*time);
    [x y xSpeed ySpeed] = robotMotionModel(x, y, xSpeed, ySpeed, iX, iY, dTime);
    scatter(x, y, 'b');
    [wandX wandY wandXSpeed wandYSpeed] = robotMotionModel(wandX, wandY, wandXSpeed, wandYSpeed, 0, 0, dTime);
    scatter(wandX, wandY, 'r');
  end
end
