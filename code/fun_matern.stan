functions {
            matrix matern_covariance( int N, matrix dist, real phi, real sigma_sq, int COVFN) {
              matrix[N,N] S;
              real dist_phi; 
              real sqrt3;
              real sqrt5;
              sqrt3=sqrt(3.0);
              sqrt5=sqrt(5.0);

              if (COVFN==1) { // exponential == Matern nu=1/2 , (p=0; nu=p+1/2)
                for(i in 1:(N-1)){
                  for(j in (i+1):N){
                    dist_phi = fabs(dist[i,j])/phi;
                    S[i,j] = sigma_sq * exp(- dist_phi ); 
                }}

              
              } else if (COVFN==2) { // Matern nu= 3/2 covariance
                for(i in 1:(N-1)){
                  for(j in (i+1):N){
                   dist_phi = fabs(dist[i,j])/phi;
                   S[i,j] = sigma_sq * (1 + sqrt3 * dist_phi) * exp(-sqrt3 * dist_phi);
                }}
              

              } else if (COVFN==3) { // Matern nu=5/2 covariance
                for(i in 1:(N-1)){
                  for(j in (i+1):N){
                    dist_phi = fabs(dist[i,j])/phi;
                    S[i,j] = sigma_sq * (1 + sqrt5 *dist_phi + 5* pow(dist_phi,2)/3) * exp(-sqrt5 *dist_phi);
                }}
            
              } else if (COVFN==4) { // Matern as nu->Inf become Gaussian (aka squared exponential cov)
                for(i in 1:(N-1)){
                  for(j in (i+1):N){
                    dist_phi = fabs(dist[i,j])/phi;
                    S[i,j] = sigma_sq * exp( -pow(dist_phi,2)/2 ) ;
                }}
              } 

                 
              for(i in 1:(N-1)){
              for(j in (i+1):N){
                S[j,i] = S[i,j];  // fill upper triangle
              }}

              // create diagonal: nugget(nonspatial) + spatial variance +  eps ensures positive definiteness
              for(i in 1:N) S[i,i] = sigma_sq ;            
              return(S);
            }

      }
