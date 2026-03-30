eul:2.7182818284590452353602874713527
pi:3.14159265358979323846
erf:{[x] a:1;if[x<0;a:-1];x:_abs x;a1:0.254829592;a2:-0.284496736;a3:1.421413741;a4:-1.453152027;a5:1.061405429;p:0.3275911;t:%(1+p*x);y:1.0-((((((((a5*t)+a4)*t)+a3)*t)+a2)*t)+a1)*t*(eul^(-x*x));y*a}


ncdf:{(1+erf(x*%(_sqrt 2)))*.5}
npdf:{(1*%_sqrt 2*pi)*eul^(-.5*x^2)}

/Equity

bs:{[s;k;r;v;t] d1:((_log(s*%k))+((r+(v^2)*.5)*t))*%(v*_sqrt t);d2:d1-(v*_sqrt t);(s*(ncdf d1))-(ncdf d2)*k*(eul^(-r*t))}

delta:{[s;k;r;v;t] ncdf ((_log(s*%k))+((r+(v^2)*.5)*t))*%(v*_sqrt t)}
vega:{[s;k;r;v;t] .01*s*(npdf ((_log(s*%k))+((r+(v^2)*.5)*t))*%(v*_sqrt t))*eul^-r*t}

opt:{[s;k;r;v;t](bs[s;k;r;v;t];delta[s;k;r;v;t];vega[s;k;r;v;t])}

/FX

fxbs:{[s;k;rf;rd;v;t] d1:((_log(s*%k))+(((rd-rf)+(v^2)*.5)*t))*%(v*_sqrt t);d2:d1-(v*_sqrt t);(s*(eul^-rf*t)*(ncdf d1))-(ncdf d2)*k*(eul^(-rd*t))}

fxdelta:{[s;k;rf;rd;v;t] ncdf ((_log(s*%k))+(((rd-rf)+(v^2)*.5)*t))*%(v*_sqrt t)}
fxvega:{[s;k;rf;rd;v;t] .01*s*(npdf ((_log(s*%k))+(((rd-rf)+(v^2)*.5)*t))*%(v*_sqrt t))*eul^-rf*t}

fxopt:{[s;k;rf;rd;v;t](fxbs[s;k;rf;rd;v;t];fxdelta[s;k;rf;rd;v;t];fxvega[s;k;rf;rd;v;t])}
