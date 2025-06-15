.data
# Número de notas (cada par nota+duração = 1 nota lógica)
NUM: .word 56

# Tema principal + repetição com variações
NOTAS:
.word 76,300, 76,300, 84,300, 84,300, 
      83,300, 83,300, 81,300, 81,300,
      79,400, 79,200, 81,400, 79,400,
      76,400, 76,400, 0,600, 76,300,

      81,300, 81,300, 79,300, 79,300,
      77,300, 77,300, 76,300, 76,300,
      74,400, 74,200, 76,400, 74,400,
      72,400, 72,400, 0,600, 76,300,

      76,300, 76,300, 76,300, 76,300,
      79,300, 79,300, 81,600, 0,400

.text
.globl main
main:
    la s0, NUM         # endereço da quantidade de notas
    lw s1, 0(s0)       # lê o número de notas
    la s0, NOTAS       # endereço das notas
    li t0, 0           # contador de notas
    li a2, 30          # instrumento: guitar
    li a3, 127         # volume máximo

LOOP:
    beq t0, s1, FIM    # fim da música?
    lw a0, 0(s0)       # carrega nota MIDI
    lw a1, 4(s0)       # carrega duração
    li a7, 31          # syscall 31: toca nota
    ecall

    mv a0, a1          # pausa = duração da nota
    li a7, 32          # syscall 32: espera
    ecall

    addi s0, s0, 8     # próxima nota
    addi t0, t0, 1     # incrementa contador
    j LOOP

FIM:
    li a7, 10          # syscall 10: finaliza
    ecall
