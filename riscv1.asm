.data
REPETICOES: .word 15       # num vezes que o loop repete
NUM: .word 16              # num notas musicais 

NOTAS: 
    .word 76,250, 74,250, 72,250, 71,250, 
           72,250, 74,250, 76,250, 79,250,
           76,250, 74,250, 72,250, 71,250,
           72,500, 0,500  # formato: nota, tempo. Pausa no fim.

.text
.globl main
main:
    la s0, NUM
    lw s1, 0(s0)           # num de notas
    la s0, NOTAS
    li a2, 68              # instrumento: flauta
    li a3, 127             # volume
    li t2, 0               # repetição atual
    la t3, REPETICOES
    lw t4, 0(t3)           # total de repetições

REPETE:
    li t0, 0               # contador de notas
    la s0, NOTAS           # volta ao início das notas

LOOP:
    beq t0, s1, NEXT       # fim da sequência de notas
    lw a0, 0(s0)           # nota MIDI
    lw a1, 4(s0)           # duração
    li a7, 31              # syscall tocar som
    ecall

    mv a0, a1              # pausa com mesma duração
    li a7, 32              # syscall pausa
    ecall

    addi s0, s0, 8         # próxima nota
    addi t0, t0, 1         # próxima iteração
    j LOOP

NEXT:
    addi t2, t2, 1         # próxima repetição
    blt t2, t4, REPETE     # repete se ainda não terminou

FIM:
    li a7, 10              # encerrar o programa
    ecall
