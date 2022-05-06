!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ���ϳ�ʼ�� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
    
MODULE module_initialization
    contains
    
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!! ��ת���ʼ������λ�Ƹ߶ȳ������ʼ��ת�� !!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE geostrophic_wind(ua, va, za, m, f, nx, ny, d)
    ! n-1ʱ�̵ĳ�ʼ�߶ȳ����糡ua,va,za
    ! ��ͼ�Ŵ�ϵ��m
    ! ��ת����f
    ! ������nx,ny
    ! �����d
    ! �������ٶ�g
        IMPLICIT NONE
    
        INTEGER, PARAMETER :: g = 9.8
        INTEGER :: i, j
        INTEGER :: nx, ny
        REAL :: ua(nx, ny), va(nx, ny), za(nx, ny)
        REAL :: m(nx, ny), f(nx, ny)
        REAL :: d
    
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ����ua!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        do j = 1, ny
            if (j == 1) then  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! �±߽�
                do i = 1, nx
                        ua(i, 1) = (-1 * m(i, 1) * g / f(i, 1)) * ((za(i, 2) - za(i, 1)) / d)
                enddo
            else if (j > 1 .and. j < ny) then  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! �м�
                do i = 1, nx
                    ua(i, j) = (-1 * m(i, j) * g / f(i, j)) * ((za(i, j + 1) - za(i, j - 1)) / (2.0 * d))
                enddo
            else  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! �ϱ߽�
                do i = 1, nx
                    ua(i, ny) = (-1 * m(i, ny) * g / f(i, ny)) * ((za(i, ny) - za(i, ny - 1)) / d)
                enddo
            endif
        enddo
        
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ����va!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        do i = 1, nx
            if (i == 1) then  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ��߽�
                do j = 1, ny
                        va(1, j) = (m(1, j) * g / f(1, j)) * ((za(2, j) - za(1, j)) / d)
                enddo
            else if (i > 1 .and. i < nx) then  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! �м�
                do j = 1, ny
                    va(i, j) = (m(i, j) * g / f(i, j)) * ((za(i + 1, j) - za(i - 1, j)) / (2.0 * d))
                enddo
            else  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! �ұ߽�
                do j = 1, ny
                    va(nx, j) = (m(nx, j) * g / f(nx, j)) * ((za(nx, j) - za(nx - 1, j)) / d)
                enddo
            endif
        enddo
        return
    END SUBROUTINE geostrophic_wind
END MODULE