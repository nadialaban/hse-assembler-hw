format PE console
entry start

include 'win32a.inc'

section '.data' data readable writable     ; ������ ������
        ru db 'Russian', 0

        strVecSize     db '������� ������ �������: ', 0
        strIncorSize   db '�������� ������ ������� = %d', 10, 0
        strVecElemI    db '������� [%d] ������� �������: ', 0          ; ������ ��� ������ � �������
        strScanInt     db '%d', 0
        strResult      db 10,'������ ������������� �����:', 10, 0
        strVecElemOut  db '[%d] = %d', 10, 0

        i            dd ?
        j            dd 0
        tmp          dd ?              ; ��������� � ��������� ����������
        tmpStack     dd ?

        vec          rd 100            ; �������� ������
        vec_size     dd 0

        vecRes       rd 100            ; ������-���������
        vecRes_size  dd 0

;--------------------------------------------------------------------------
section '.code' code readable executable   ; ������ ������������ ����

start:
        cinvoke setlocale, 0, ru       ; ������������� ������� ������

        call VectorInput               ; ��������� ������
        call FilterVector              ; ��������� ������
        call VectorOut                 ; ������� ��������

finish:
        call [getch]

        push 0                        ; ���������� ���������
        call [ExitProcess]

;--------------------------------------------------------------------------
VectorInput:
        push strVecSize
        call [printf]                 ; ������ ������ ����� �������
        add esp, 4

        push vec_size
        push strScanInt               ; ��������� ����� �������
        call [scanf]
        add esp, 8

        mov eax, [vec_size]           ; ��������� ������������ ����� �������
        cmp eax, 0                    ; ���� ������������� �����, ��������� ��������
        jg  getVector

        push vec_size
        push strIncorSize
        call [printf]                 ; ���� <=0, ������� ��������� � ��������� ���������
        push 0
        call [ExitProcess]

getVector:
        xor ecx, ecx             ; ecx = 0        �������� �������-��������
        mov ebx, vec             ; ebx = &vec     ������ ������ �� ������ � �������

getVecLoop:
        mov [tmp], ebx
        cmp ecx, [vec_size]
        jge endInputVector       ; ��������� ����, ���� ������ ����� �� �������

        mov [i], ecx
        push ecx
        push strVecElemI         ; ������ ������ ���� �������
        call [printf]
        add esp, 8

        push ebx
        push strScanInt          ; ��������� ���� �������
        call [scanf]
        add esp, 8

        mov ecx, [i]             ; ����������� �������� ���������
        inc ecx
        mov ebx, [tmp]           ; ������ �������� � c���
        add ebx, 4               ; ���������� ��������� �����
        jmp getVecLoop           ; ���� � ������ �����

endInputVector:
        ret                      ; ������� �� �����
;--------------------------------------------------------------------------
FilterVector:
        xor ecx, ecx            ; ecx = 0         �������� �������-�������� ��� ��������� �������
        mov ebx, vec            ; ebx = &vec      ������ ������ �� �������� ������ � �������

        mov edx, vecRes         ; edx = &vecRes   ������ ������ �� �������������� ������ � �������

        mov [i], ecx
FilterVecLoop:
        mov ecx, [i]
        cmp ecx, [vec_size]
        je endFilterVector      ; ���� ����� �� ����� ��������� ������� - ��������� ����

        cmp dword [ebx], 0      ; ���������� ������� � �����
        jg  addToRes            ; ���� ������� �������������, ��������� � ����� ������

        inc [i]                 ; ����������� ��������
        add ebx, 4
        jmp FilterVecLoop       ; ������������ � ������ �����

addToRes:
        mov eax, [ebx]          ; ������ �������� � �������������� ������
        mov [edx], eax

        add edx, 4              ; ���������� ��������� �� ������� �������
        add ebx, 4

        inc [i]                 ; ����������� ���������
        inc [j]

        jmp FilterVecLoop       ; ������������ � ������ �����

endFilterVector:
        mov eax, [j]            ; ���������� ������
        mov [vecRes_size], eax
        ret                     ; ������� �� ���������
;--------------------------------------------------------------------------
VectorOut:
        push strResult
        call [printf]           ; ������� ���������
        add esp, 4

        mov [tmpStack], esp
        xor ecx, ecx            ; ecx = 0          �������� �������-�������� ��� ��������������� �������
        mov ebx, vecRes         ; ebx = &vecRes    ���������� ��������� �� �������������� ������ � �������
putVecLoop:
        mov [tmp], ebx
        cmp ecx, [vecRes_size]  ; ������� �� �����, ����� ����� �� ����� �������
        je endOutputVector

        mov [i], ecx

        push dword [ebx]
        push ecx
        push strVecElemOut      ; ������� �������
        call [printf]

        mov ecx, [i]            ; ����������� �������� ���������
        inc ecx
        mov ebx, [tmp]          ; ������� ��������� �� ������� �������
        add ebx, 4
        jmp putVecLoop          ; ��������� � ������ �����

endOutputVector:
        mov esp, [tmpStack]
        ret                     ; ������� �� ���������
;-------------------------------third act - including HeapApi--------------------------
                                                 
section '.idata' import data readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll',\
            user32,'USER32.DLL'

include 'api\user32.inc'
include 'api\kernel32.inc'
    import kernel,\                               ; ����������� ������ ���������
           ExitProcess, 'ExitProcess',\
           HeapCreate,'HeapCreate',\
           HeapAlloc,'HeapAlloc'
  include 'api\kernel32.inc'
    import msvcrt,\
           setlocale, 'setlocale',\
           printf, 'printf',\
           scanf, 'scanf',\
           getch, '_getch'