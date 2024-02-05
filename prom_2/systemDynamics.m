function dy = systemDynamics(t, y, u, theta, delta_s, m, I_y, rho, L, g, h, Z_prime_w, Z_double_prime_uw, M_prime_q, M_double_prime_u)
    % y(1) = w
    % y(2) = q
    w = y(1);
    q = y(2);
    % Here Z '_w, Z' _q, M '_w, M' _q, Z '_ {uw}, M' _ {uw} is coefficient of the equation, may be constant or a function of other variables
    
    % Solve the first equation for w
    A = m - 0.5*rho*L^3*Z_prime_w - 0.5*rho*L^2*Z_double_prime_uw;
    B = 0.5*rho*L^4*Z_prime_q*q + 0.5*rho*L^3*Z_prime_q*u*q + 0.5*rho*L^2*(Z_double_prime_u*u^2*delta_s);
    dw_dt = (B + m*u*q) / A;
    
    %The second equation solves q
    C = I_y + 0.5*rho*L^5*M_prime_q + 0.5*rho*L^4*M_prime_q*u;
    D = 0.5*rho*L^4*M_prime_w*dw_dt + 0.5*rho*L^3*(M_double_prime_u*u^2*delta_s) + m*g*h*theta;
    dq_dt = -D / C;
    
    dy = [dw_dt; dq_dt];
end


