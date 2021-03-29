        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main
        MOV     R0,#5           //Será calculado o fatorial de R0 e armazenado em R0.
        PUSH    {R1}            //R1 será utilizado nos cálculos, para não se perder seu valor inicial, ele será savo na pilha.
        MOV     R1,R0
        BL      Fat
        POP     {R1}
        B       fim
Fat
        SUB     R1,#1           //A cada iteração o valor de R1 é decrementado de 1.
        CBZ     R0,retorno1
        CBZ     R1,retorno2
        MULS     R0,R1         //O produto de R0*R1 é "sinalizado" para a label "check_mul".
        B       check_mul
check_mul
       ITE      CS             //Verifica o flag C do APSR.
       BCS      retorno3       //Se C=1, R0=-1, ou seja, ocorre o "estouro" dos 32-bits.
       BCC      Fat            //Se C=0, volta ao "loop" principal, é o caso usual.
retorno1
        MOV     R0,#1           //Esse retorno apenas serve para englobar a definição de 0!=1
        BX      LR
retorno2                        //Esse é o retorno usual
        BX      LR
retorno3                        //O retorno3 ocorre quando há o estouro de capacidade do registrador
        MOV     R0,#-1
        BX      LR
fim
        nop

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
