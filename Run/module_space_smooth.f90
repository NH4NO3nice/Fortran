!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!�ռ��ڵ㼰�߽�ƽ��!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
MODULE module_space_smooth
    contains
    
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!�ռ��ڵ����ƽ��!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!      
    SUBROUTINE five_smooth_space_in(ub, nx, ny, S_space)
    ! ub����ǰʱ��������
    ! nx, ny��������
    ! S_space��ʱ��ƽ��ϵ��
        IMPLICIT NONE
        INTEGER :: i, j
        INTEGER :: nx, ny
        REAL :: S_space
        REAL :: ub(nx, ny)
        REAL :: u(nx, ny)  ! ������
    
        do i = 2, nx - 1
            do j = 2, ny - 1
                u(i, j) = (1 - S_space) * ub(i, j) + S_space * (ub(i + 1, j) + ub(i, j + 1) + ub(i - 1, j) + ub(i, j - 1)) / 4.0
            enddo
        enddo
    
        do i = 2, nx - 1
            do j = 2, ny - 1
                ub(i, j) = u(i, j)
            enddo
        enddo
        return
    END SUBROUTINE five_smooth_space_in
    
    
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!�ռ�߽�ŵ�ƽ��!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!�˴��߽�ָ����ڶ�Ȧ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE nine_smooth_space_out(ub, nx, ny, S_space)
    ! ub����ǰʱ��������
    ! nx, ny��������
    ! S_space��ʱ��ƽ��ϵ��
        IMPLICIT NONE
        INTEGER :: i, j
        INTEGER :: nx, ny
        REAL :: S_space
        REAL :: ub(nx, ny)
        REAL :: u(nx, ny)  ! ������
    
        do i = 2, nx - 1, nx - 3    !  ���±߽�
            do j = 2, ny - 1
                u(i, j) = (1 - S_space) ** 2 * ub(i, j) + S_space * (1 - S_space) * (ub(i + 1, j) + ub(i - 1, j)) / 2.0 &
                            + S_space * (1 - S_space) * ub(i, j + 1) / 2.0 + S_space ** 2 * (ub(i + 1, j + 1) + ub(i - 1, j + 1)) / 4.0 &
                            + S_space * (1 - S_space) * ub(i, j - 1) / 2.0 + S_space ** 2 * (ub(i + 1, j - 1) + ub(i - 1, j - 1)) / 4.0
            enddo
        enddo
    
        do j = 2, ny - 1, ny - 3    !  ���ұ߽�
            do i = 3, nx - 2
                u(i, j) = (1 - S_space) ** 2 * ub(i, j) + S_space * (1 - S_space) * (ub(i + 1, j) + ub(i - 1, j)) / 2.0 &
                            + S_space * (1 - S_space) * ub(i, j + 1) / 2.0 + S_space ** 2 * (ub(i + 1, j + 1) + ub(i - 1, j + 1)) / 4.0 &
                            + S_space * (1 - S_space) * ub(i, j - 1) / 2.0 + S_space ** 2 * (ub(i + 1, j - 1) + ub(i - 1, j - 1)) / 4.0
            enddo
        enddo
    
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ���ݱ߽�ֵ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        do i = 2, nx - 1, nx - 3    !  ���±߽�
            do j = 2, ny - 1
                ub(i, j) = u(i, j)
            enddo
        enddo
    
        do j = 2, ny - 1, ny - 3    !  ���ұ߽�
            do i = 3, nx - 2
                ub(i, j) = u(i, j)
            enddo
        enddo
        return
    END SUBROUTINE nine_smooth_space_out
END MODULE