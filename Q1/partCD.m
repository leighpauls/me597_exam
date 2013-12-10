function [] = partCD()
  % Robot state
  robotOrigin = [3; 3.5];
  robotState = [0; 0; 0; 0];

  % Wand state
  wandOrigin = [3; 1];
  wandState = [0; 0; 0; 0];

  dTime = 1 / 100;
  T = [0:dTime:12];

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

  % LQR Costs
  LQR_Q = eye(4) * 100.0;
  % only care about position
  LQR_R = eye(2) * 0.0001;

  % LQR Costate setup
  P = zeros(2, 2, length(T));
  P_S(:,:,length(T)) = LQR_Q;
  Pn = P_S(:,:,length(T));
  for i = length(T)-1:-1:1
      P = LQR_Q + A'*Pn*A - A'*Pn*B * inv(B'*Pn*B + LQR_R) * B'*Pn*A;
      P_S(:,:,i) = P;
      Pn=P;
  end
  
  clf;
  hold on;
  axis([0 6 0 6]);

  for i = 1:(length(T)-1)
    time = T(i);

    % find the LQR gains
    K = inv(B' * P_S(:,:,i+1) * B + LQR_R) * B' * P_S(:,:,i+1) * A;

    % the state I want the robot to track
    setPoint = wandMu * 3;
    error = setPoint - robotMu;
    
    % Apply the LQR controller
    robotInput = K*error;
    % update the states with noise
    robotState = A * robotState + B * robotInput + sqrtR * randn(4, 1);

    wandOffset = getWandOffset(time);
    wandState = [ wandOffset(1);
                  wandOffset(2);
                  (wandOffset(1) - wandState(1)) / dTime;
                  (wandOffset(2) - wandState(2)) / dTime ];

    % take a measurement of the states
    robotMeasurements = C * robotState + sqrtQ * randn(2, 1);
    wandMeasurements = C * wandState + sqrtQ * randn(2, 1);

    % prediction update
    robotPredictionMu = A * robotMu + B * robotInput;
    robotPredictionCovarience = A*robotCovarience*A' + R;

    wandPredictionMu = A * wandMu;
    wandPredictionCovarience = A*wandCovarience*A' + R;

    % measurement update
    robotK = robotPredictionCovarience * C' * inv(C * robotPredictionCovarience * C' + Q);
    robotMu = robotPredictionMu + robotK * (robotMeasurements - C * robotPredictionMu);
    robotCovarience = (eye(4) - robotK * C) * robotPredictionCovarience;
    
    wandK = wandPredictionCovarience * C' * inv(C * wandPredictionCovarience * C' + Q);
    wandMu = wandPredictionMu + wandK * (wandMeasurements - C * wandPredictionMu);
    wandCovarience = (eye(4) - wandK * C) * wandPredictionCovarience;    
    
    robotPosition = robotState(1:2)+robotOrigin;
    wandPosition = wandState(1:2)+wandOrigin;
    scatter(robotPosition(1), robotPosition(2), 'b');
    scatter(wandPosition(1), wandPosition(2), 'g');
  end
end
