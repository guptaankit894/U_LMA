function [y]=LMA_optim(x_new)
rng(0);
lamda=0.01; % set an initial value of the damping factor for the LM
updateJ=1;

W=rand(1,3);
y0=W*x_new;
Ndata=length(y0);
H_prev=0;
y=y0;
for it=1:1000
    
    if updateJ==1
    % Evaluate the Jacobian matrix at the current parameters (a_est, b_est)
        
        
      
          J=((cov(x_new')*W')*(W*cov(x_new')*W')^-1)' - 2* mean(y*x_new'); 

          
        % Evaluate entropy
            d=0.5*log(W*cov(x_new')*W')+mean(log(sech(y).^2));

        % compute the approximated Hessian matrix, J’ is the transpose of J
        H=(J'*J);
        if it==1 % the first iteration : compute the total error
            e=-d;
        end
    end
    % Apply the damping factor to the Hessian matrix
    Dia=zeros(3,3);
    if it==1
        
        Dia=eye(3,3)*max(max(H));
        H_prev=max(max(H));
    elseif max(max(H))>H_prev
        
        Dia=eye(3,3)*(max(max(H)));
        H_prev=max(max(H));
    else
        
        Dia=eye(3,3)*H_prev;
    end
      
    H_lm=H+(lamda*(Dia'*Dia));
    
    % Compute the updated parameters
    dp=-inv(H_lm)*(J*e(:))';
    W_lm=W+dp';

    % Evaluate the total distance error at the updated parameters
    
    y_est_lm=W_lm*x_new;
 
    d_lm=0.5*log(W_lm*cov(x_new')*W_lm')+mean(log(sech(y_est_lm).^2));
    
    e_lm=-d_lm;
    % then makes the updated parameters to be the current parameters
    % and decreases the value of the damping factor
    if e < e_lm
        lamda=lamda/5;
        W=W_lm;        
        e=e_lm;
        disp(e);
        updateJ=1;
    else % otherwise increases the value of the damping factor
        updateJ=0;
        lamda=lamda*2.5;
    end
end
y=W*x_new;
return