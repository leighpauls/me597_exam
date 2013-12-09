function [] = partA()
  % Robot state
  robotState = [2; 3.5; 0; 0];

  dTime = 1 / 100;

  % Motion model
  mass = 5;
  Ki = 2.4;
  A = [ 1 0 dTime 0;
        0 1 0 dTime;
        0 0 1 0;
        0 0 0 1 ];
  B = [ 0 0;
        0 0;
        Ki (-0.2*Ki);
        (-0.2*Ki) Ki ] * dTime / mass;
  R = [0.000002;
       0.000002;
       0.000004;
       0.000004];
  sqrtR = sqrt(R);        

  clf;
  hold on;
  axis([0 6 0 5]);

  for time = [0:dTime:10]
    iX = sin(2*time);
    iY = -2*cos(2*time);

    robotInput = [iX; iY];
    robotState = normrnd(A * robotState + B * robotInput, sqrtR);

    scatter(robotState(1), robotState(2), 'b');
  end
end
