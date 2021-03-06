subroutine stprofile 
  !     --------------------                                              
  USE header
  implicit none
  real*8 :::: tmp
  ! Initializes s,T from Andrey's section gridded for model grid
  ! s_init.dat and T_init.dat  written in ascii - NK+2 x NJx2

  integer n,i,j,k

!  open(unit=31,file='s_init.dat')
  n=0
  open(unit=31,file='s_kuroshio65.dat')

  do k=0,NK
     read(31,*) (s(0,j,k,n),j=1,NJ)
     s(0,0,k,n)= s(0,1,k,n)
     s(0,NJ+1,k,n)= s(0,NJ,k,n)
  end do
  close(31)
  s(:,:,:,:)=34

!  open(unit=31,file='T_init.dat')
  open(unit=31,file='T_kuroshio65.dat')
  
  do k=0,NK
     read(31,*) (T(0,j,k,n),j=1,NJ)
     T(0,0,k,n)= T(0,1,k,n)
     T(0,NJ+1,k,n)= T(0,NJ,k,n)
  end do
  close(31)

  do k=0,NK
  do j=0,NJ+1
     !T(0,j,k,n) = 10d0 + 10d0*real(k)/real(NK) + 10d0/real(NJ)*real(j)
     T(0,j,k,n) = 20d0 + 10d0*tanh(2d0*real(j-NJ/2)/real(NJ))
  enddo
  enddo
     T(0,0,:,n)= T(0,1,:,n)
     T(0,NJ+1,:,n)= T(0,NJ,:,n)
     !T(NI/2,NJ/2,1:2,n) = 20d0
  i=0
  do j=0,NJ+1
     s(i,j,NK+1,n)= s(i,j,NK,n) 
     T(i,j,NK+1,n)= T(i,j,NK,n) 
  end do

  do k=0,NK+1
     do j=0,NJ+1
        do i=1,NI+1
           s(i,j,k,n)= s(0,j,k,n)
           T(i,j,k,n)= T(0,j,k,n)
        end do
     end do
  end do
  call evalrho(rho,n)

  return 
END subroutine stprofile
