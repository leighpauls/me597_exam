function [x, y, xSpeed, ySpeed] = robotMotionModel(prevX, prevY, prevXSpeed, prevYSpeed, iX, iY, dTime)
  mass = 5;
  Ki = 2.4;
  Fx = Ki * iX - 0.2 * Ki * iY;
  Fy = Ki * iY - 0.2 * Ki * iX;
  xAccel = Fx / mass;
  yAccel = Fy / mass;
  xSpeed = prevXSpeed + xAccel * dTime + normrnd(0, sqrt(0.000004));
  ySpeed = prevYSpeed + yAccel * dTime + normrnd(0, sqrt(0.000004));
  x = prevX + (xSpeed + prevXSpeed) / 2 * dTime + normrnd(0, sqrt(0.000002));
  y = prevY + (ySpeed + prevYSpeed) / 2 * dTime + normrnd(0, sqrt(0.000002));
end
