!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 边界条件 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    
    
MODULE module_boundary
    contains
    
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!固定边界!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    SUBROUTINE  fixed_boundary(ua, va, za, ub, vb, zb, nx, ny)
    ! ua, va, za：上一时刻物理量
    ! ub, vb, zb：本时刻物理量
    ! nx, ny：格点数
        IMPLICIT NONE
        INTEGER :: i, j
        INTEGER :: nx, ny
        REAL :: ua(nx, ny), va(nx, ny), za(nx, ny)   !!!!!!!!!!!!!!!! 定义上一时刻风场气压场数组，虽为数组，但本子程序只用到上下左右边界值
        REAL :: ub(nx, ny), vb(nx, ny), zb(nx, ny)  !!!!!!!!!!!!!!!! 定义本时刻风场气压场数组，虽为数组，但本子程序只赋值边界值
    
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 为本时刻物理量赋左右边界!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        do i = 1, nx, nx - 1
            do j = 1, ny
                ub(i, j) = ua(i, j)
                vb(i, j) = va(i, j)
                zb(i, j) = za(i, j)
            enddo
        enddo
    
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 为本时刻物理量赋上下边界!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        do j = 1, ny, ny - 1
            do i = 2, nx - 1  !  给左右边界赋值时，(1,1)(nx,1),(1,ny)(nx,ny)已经赋值
                ub(i, j) = ua(i, j)
                vb(i, j) = va(i, j)
                zb(i, j) = za(i, j)
            enddo
        enddo
        return
    END SUBROUTINE fixed_boundary
    
END MODULE