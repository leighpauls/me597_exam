function [] = partB()
  % Robot state
  robotState = [2; 3.5; 0; 0];

  % Wand state - put the wand in a logical position
  wandState = [3; 1; 0; 0];

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
  R = [0.000002 0 0 0;
       0 0.000002 0 0;
       0 0 0.000004 0;
       0 0 0 0.000004 ];
  sqrtR = sqrt(R);
        
  % Measurement model
  C = [ 1 0 0 0;
        0 1 0 0 ];
  Q = [0.0001 0;
       0 0.0001 ];
  sqrtQ = sqrt(Q);
  
  % Use an accurate prior
  robotMu = robotState;
  robotCovarience = R;

  wandMu = wandState;
  wandCovarience = R;

  clf;
  hold on;
  axis([0 6 0 5]);

  for time = [0:dTime:10]
    iX = sin(2*time);
    iY = -2*cos(2*time);

    % update the states with noise
    robotInput = [iX; iY];
    robotState = A * robotState + B * robotInput + sqrtR * randn(4, 1);

    wandInput = zeros(2, 1);
    wandState = A * wandState + B * wandInput + sqrtR * randn(4, 1);

    % take a measurement of the states
    robotMeasurements = C * robotState + sqrtQ * randn(2, 1);
    wandMeasurements = C * wandState + sqrtQ * randn(2, 1);

    % prediction update
    robotPredictionMu = A * robotMu + B * robotInput;
    robotPredictionCovarience = A*robotCovarience*A' + R;

    wandPredictionMu = A * wandMu + B * wandInput;
    wandPredictionCovarience = A*wandCovarience*A' + R;

    % measurement update
    robotK = robotPredictionCovarience * C' * inv(C * robotPredictionCovarience * C' + Q);
    robotMu = robotPredictionMu + robotK * (robotMeasurements - C * robotPredictionMu);
    robotCovarience = (eye(4) - robotK * C) * robotPredictionCovarience;
    
    wandK = wandPredictionCovarience * C' * inv(C * wandPredictionCovarience * C' + Q);
    wandMu = wandPredictionMu + wandK * (wandMeasurements - C * wandPredictionMu);
    wandCovarience = (eye(4) - wandK * C) * wandPredictionCovarience;
    
    

    scatter(robotState(1), robotState(2), 'b');
    scatter(robotMeasurements(1), robotMeasurements(2), 'r')
    scatter(robotMu(1), robotMu(2), 'g');

    scatter(wandState(1), wandState(2), 'b');
    scatter(wandMeasurements(1), wandMeasurements(2), 'r')
    scatter(wandMu(1), wandMu(2), 'g');
    
  end
end
