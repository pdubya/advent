
! NB:
! awk '{ if (length($0) > max) max = length($0) }
!    END { print max }' resources/d1a.txt
! 51

program adv1a
    use iso_fortran_env, only: stdout => output_unit, stdin => input_unit
    implicit none
    integer :: ios, code, v1, v2
    character(len=9999) :: text

    code = 0
    do
        read(stdin, '(a)', iostat = ios) text
        if (ios < 0) exit
        v1 = scan(text, "0123456789")
        v2 = scan(text, "0123456789", .true.)
        code = code + 10*digit(text(v1:v1)) + digit(text(v2:v2))

    end do
    write(stdout, '(i10)') code

contains

    integer function digit(c)
        character(1), intent(in) :: c
        digit = ichar(c(1:1)) - ichar('0')
    end

end program adv1a