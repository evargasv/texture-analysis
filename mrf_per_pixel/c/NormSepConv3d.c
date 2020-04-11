#include "mex.h"

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/*
 * NormSepConv3d.c
 *
 * Normalized convolution 3D with separable kernel
 *
 */

/* Created by kego (March 2012) */


static int NumberOfElements(const mxArray *A)
{
    const mwSize *sizeA;
    int i;
    int numel = 0;
    
    if (!mxIsEmpty(A))
    {
        numel = 1;
        sizeA = mxGetDimensions(A);
        for (i = 0 ; i < (int)mxGetNumberOfDimensions(A) ; i++) {
            numel *= sizeA[i];
        }
    }
    
    return numel;
}

static int CheckSizesMatch(const mxArray *A, const mxArray *B)
{
    int i;
    const mwSize *sizeA;
    const mwSize *sizeB;
    
    if (mxGetNumberOfDimensions(A) != mxGetNumberOfDimensions(B))
        return 0;
    
    sizeA = mxGetDimensions(A);
    sizeB = mxGetDimensions(B);
    for (i = 0 ; i < (int)mxGetNumberOfDimensions(A) ; i++) {
        if (sizeA[i] != sizeB[i])
            return 0;
    }
    
    return 1;
}

/* Assume positive x */
#define ROUND(x) (short)((x)+0.5)
  
static mxArray *NormSepConv3d(
        const mxArray *A,
        const mxArray *hx,
        const mxArray *hy,
        const mxArray *hz,
        const mxArray *mask)
{
    mxArray *B;
    mxArray *C;
    double *phx, *phy, *phz;
    double sum, weights;
    unsigned char *pMask;
    const mwSize *sizeA;
    int x, y, z;
    int dx, dy, dz;
    int nx2, ny2, nz2;
    int Nx, Ny, Nz, Nslice;
    
    
    pMask = mxGetData(mask);

    
    switch (mxGetClassID(A))
    {
        case mxINT16_CLASS:
        {
            short *pA;
            short *pB;
            short *pC;

            pA    = mxGetData(A);
            sizeA = mxGetDimensions(A);
            Nx = sizeA[1]; Ny = sizeA[0]; Nz = sizeA[2];
            Nslice = Nx * Ny;
            
            B  = mxCreateNumericArray(3, sizeA, mxINT16_CLASS, mxREAL);
            pB = mxGetData(B);
            
            /* Filter in the x-direction */
            phx = mxGetData(hx);
            nx2 = NumberOfElements(hx) / 2;
            mexPrintf("Filtering in x-direction...\n");
            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dx = -nx2 ; dx <= nx2 ; dx++)
                        {
                            if (x+dx >= 0 && x+dx < Nx &&
                                pMask[Nslice*z + Ny*(x+dx) + y])
                            {
                                sum += pA[Nslice*z + Ny*(x+dx) + y] *
                                       phx[dx+nx2];
                                weights += phx[dx+nx2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = ROUND(sum);
                    }
                }
            }
            
            /* Filter in the y-direction */
            ny2 = NumberOfElements(hy)/2;
            phy = mxGetData(hy);
            C  = mxCreateNumericArray(3, sizeA, mxINT16_CLASS, mxREAL);
            pC = mxGetData(C);
            mexPrintf("Filtering in y-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dy = -ny2 ; dy <= ny2 ; dy++)
                        {
                            if (y+dy >= 0 && y+dy < Ny &&
                                pMask[Nslice*z + Ny*x + y + dy])
                            {
                                sum += pB[Nslice*z + Ny*x + y + dy] *
                                       phy[dy+ny2];
                                weights += phy[dy+ny2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pC[Nslice*z + Ny*x + y] = ROUND(sum);
                    }
                }
            }
            
            /* Filter in the z-direction */
            nz2 = NumberOfElements(hz)/2;
            phz = mxGetData(hz);
            mexPrintf("Filtering in z-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dz = -nz2 ; dz <= nz2 ; dz++)
                        {
                            if (z+dz >= 0 && z+dz < Nz &&
                                pMask[Nslice*(z + dz) + Ny*x + y])
                            {
                                sum += pC[Nslice*(z + dz) + Ny*x + y] *
                                       phz[dz+nz2];
                                weights += phz[dz+nz2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = ROUND(sum);
                    }
                }
            }
        }
        break;
    
        case mxSINGLE_CLASS:
        {
            float *pA;
            float *pB;
            float *pC;

            pA    = mxGetData(A);
            sizeA = mxGetDimensions(A);
            Nx = sizeA[1]; Ny = sizeA[0]; Nz = sizeA[2];
            Nslice = Nx * Ny;            
            
            B  = mxCreateNumericArray(3, sizeA, mxSINGLE_CLASS, mxREAL);
            pB = mxGetData(B);
            
            /* Filter in the x-direction */
            phx = mxGetData(hx);
            nx2 = NumberOfElements(hx) / 2;
            mexPrintf("Filtering in x-direction...\n");
            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dx = -nx2 ; dx <= nx2 ; dx++)
                        {
                            if (x+dx >= 0 && x+dx < Nx &&
                                pMask[Nslice*z + Ny*(x+dx) + y])
                            {
                                sum += pA[Nslice*z + Ny*(x+dx) + y] *
                                       phx[dx+nx2];
                                weights += phx[dx+nx2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
            
            /* Filter in the y-direction */
            ny2 = NumberOfElements(hy)/2;
            phy = mxGetData(hy);
            C  = mxCreateNumericArray(3, sizeA, mxSINGLE_CLASS, mxREAL);
            pC = mxGetData(C);
            mexPrintf("Filtering in y-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dy = -ny2 ; dy <= ny2 ; dy++)
                        {
                            if (y+dy >= 0 && y+dy < Ny &&
                                pMask[Nslice*z + Ny*x + y + dy])
                            {
                                sum += pB[Nslice*z + Ny*x + y + dy] *
                                       phy[dy+ny2];
                                weights += phy[dy+ny2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pC[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
            
            /* Filter in the z-direction */
            nz2 = NumberOfElements(hz)/2;
            phz = mxGetData(hz);
            mexPrintf("Filtering in z-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dz = -nz2 ; dz <= nz2 ; dz++)
                        {
                            if (z+dz >= 0 && z+dz < Nz &&
                                pMask[Nslice*(z + dz) + Ny*x + y])
                            {
                                sum += pC[Nslice*(z + dz) + Ny*x + y] *
                                       phz[dz+nz2];
                                weights += phz[dz+nz2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
        }
        break;
    
        case mxDOUBLE_CLASS:
        {
            double *pA;
            double *pB;
            double *pC;

            pA    = mxGetData(A);
            sizeA = mxGetDimensions(A);
            Nx = sizeA[1]; Ny = sizeA[0]; Nz = sizeA[2];
            Nslice = Nx * Ny;            
            
            B  = mxCreateNumericArray(3, sizeA, mxDOUBLE_CLASS, mxREAL);
            pB = mxGetData(B);
            
            /* Filter in the x-direction */
            phx = mxGetData(hx);
            nx2 = NumberOfElements(hx) / 2;
            mexPrintf("Filtering in x-direction...\n");
            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dx = -nx2 ; dx <= nx2 ; dx++)
                        {
                            if (x+dx >= 0 && x+dx < Nx &&
                                pMask[Nslice*z + Ny*(x+dx) + y])
                            {
                                sum += pA[Nslice*z + Ny*(x+dx) + y] *
                                       phx[dx+nx2];
                                weights += phx[dx+nx2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
            
            /* Filter in the y-direction */
            ny2 = NumberOfElements(hy)/2;
            phy = mxGetData(hy);
            C  = mxCreateNumericArray(3, sizeA, mxDOUBLE_CLASS, mxREAL);
            pC = mxGetData(C);
            mexPrintf("Filtering in y-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dy = -ny2 ; dy <= ny2 ; dy++)
                        {
                            if (y+dy >= 0 && y+dy < Ny &&
                                pMask[Nslice*z + Ny*x + y + dy])
                            {
                                sum += pB[Nslice*z + Ny*x + y + dy] *
                                       phy[dy+ny2];
                                weights += phy[dy+ny2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pC[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
            
            /* Filter in the z-direction */
            nz2 = NumberOfElements(hz)/2;
            phz = mxGetData(hz);
            mexPrintf("Filtering in z-direction...\n");

            for (z = 0 ; z < Nz ; z++) {
                for (y = 0 ; y < Ny ; y++) {
                    for (x = 0 ; x < Nx ; x++) {
                        sum = 0; weights = 0;
                        for (dz = -nz2 ; dz <= nz2 ; dz++)
                        {
                            if (z+dz >= 0 && z+dz < Nz &&
                                pMask[Nslice*(z + dz) + Ny*x + y])
                            {
                                sum += pC[Nslice*(z + dz) + Ny*x + y] *
                                       phz[dz+nz2];
                                weights += phz[dz+nz2];
                            }
                        }
                        if (weights != 0)
                            sum /= weights;
                        
                        pB[Nslice*z + Ny*x + y] = sum;
                    }
                }
            }
        }
        break;
        
        default:
            mexErrMsgIdAndTxt("NormSepConv3d:3d", "Bad type. Shouldn't get here.");
        break;
    }
    
    mxDestroyArray(C);
    
    return B;
}
  
/*
 *   Main entry point (gateway) function
 *
 *   B = NormSepConv3d(A,hx,hy,hz,mask)
 */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  if (nrhs != 5) {
      mexErrMsgIdAndTxt("NormSepConv3d:nrhs","Bad number of parameters");
  }
  
  if (mxGetNumberOfDimensions(prhs[0]) != 3) {
      mexErrMsgIdAndTxt("NormSepConv3d:3d",
              "Input image must be 3D");
  }
          
  if (!mxIsClass(prhs[0],"int16") && !mxIsClass(prhs[0],"double") && !mxIsClass(prhs[0],"single")) {
      mexErrMsgIdAndTxt("NormSepConv3d:datatype",
              "Input image must be of type int16, single or double");
  }
  
  if (!mxIsClass(prhs[1],"double") || !mxIsClass(prhs[2],"double") || !mxIsClass(prhs[3],"double")) {
      mexErrMsgIdAndTxt("NormSepConv3d:datatype","Kernels must be of type double");
  }
  if (NumberOfElements(prhs[1]) % 2 == 0 ||
      NumberOfElements(prhs[2]) % 2 == 0 ||
      NumberOfElements(prhs[3]) % 2 == 0)
  {
      mexErrMsgIdAndTxt("NormSepConv3d:kernelsize","Kernels must have an odd number of elements");
  }
  
  if (!mxIsClass(prhs[4],"logical") && !mxIsClass(prhs[4],"uint8")) {
      mexErrMsgIdAndTxt("NormSepConv3d:datatype","Mask must be of type logical/uint8");
  }

  if (!CheckSizesMatch(prhs[0],prhs[4])) {
      mexErrMsgIdAndTxt("NormSepConv3d:datatype","Mask and image must be of same dimensions");
  }
  
  plhs[0] = NormSepConv3d(prhs[0],prhs[1],prhs[2],prhs[3],prhs[4]);
}
