format PE console
entry N170359193
include "win32a.inc"

section ".code" code readable executable
N170359193:
        cinvoke setlocale,0,ru
    rdtsc

    mov [Seed],eax
    stdcall Random, 181
    add eax, 20
    mov [Size], eax
    shl eax, 1
    invoke VirtualAlloc, NULL, eax, MEM_COMMIT, PAGE_READWRITE
    mov [Array], eax
    mov edi, eax
    cinvoke printf, Msg1, [Size]
    mov ecx, [Size]
@@:
    push ecx
    stdcall Random, 40001
    sub eax, 20000
    stosw
    cinvoke printf, ItemFormat, eax
    pop ecx
    loop @B

    mov ecx, [Size]
    mov esi, [Array]
    xor edx, edx
@@:
    lodsw
    not eax
    and eax, 1
    add edx, eax
    loop @B
    cinvoke printf, Result, edx

    cinvoke getch
    invoke VirtualFree, [Array], NULL, MEM_RELEASE
    cinvoke exit, NULL

proc Random stdcall uses edx, Range :dword
    imul eax, [Seed], 08088405h
    inc eax
    mov [Seed], eax
    mul dword [Range]
    mov eax, edx
    ret
endp

section ".data" data readable
Msg1 db "��� ������ [%u]:", 13, 10, 0
Result db 13, 10, 10, "���������� ������ ���������:  %u", 13, 10, 10, \
    "��� ���������� ������ ������� ����� �������... ", 0
ItemFormat db "%8d", 0
ru db 'Russian',0

section ".bss" data readable writeable
Seed rd 1
Size rd 1
Array rd 1

section ".idata" import data readable
library kernel32,"kernel32.dll", msvcrt,"msvcrt.dll"
include "api/kernel32.inc"
import msvcrt, printf, "printf", getch, "_getch", exit, "_exit",setlocale,'setlocale'