##EXERC 10: Multiplicação em Assembly ARM

Este projeto implementa uma função de multiplicação de 16 bits (`Mul16b`) em assembly para microcontroladores ARM Cortex-M, utilizando o IAR Embedded Workbench.

## Descrição

* A função `main` inicializa dois valores (R0, R1) e chama `Mul16b`.
* `Mul16b` multiplica R0 por R1, otimizando para pequenos multiplicadores usando deslocamentos de bits (LSL).
* O resultado da multiplicação é armazenado em R2.
* A tabela de vetores de interrupção (`__vector_table`) e handlers padrão são incluídos.

## Estrutura do Código

* **`__iar_program_start`**: Início do programa.
* **`main`**: Inicialização e chamada da multiplicação.
* **`Mul16b`**: Lógica de multiplicação.
* **`__vector_table`**: Vetores de interrupção.
* **Handlers**: Tratamento básico de interrupções.

## Compilação

* Usar IAR Embedded Workbench.
* Compilar para ARM Cortex-M.

## Notas

* Otimizado para pequenos multiplicadores.
* Handlers de interrupção padrão são loops infinitos.

##EXERC 11: Fatorial em Assembly ARM Cortex-M

Este projeto implementa uma função de cálculo de fatorial em assembly para microcontroladores ARM Cortex-M, utilizando o IAR Embedded Workbench.

## Descrição

* A função `main` inicializa um valor (R0) e calcula seu fatorial usando a função `Fat`.
* `Fat` implementa um loop para calcular o fatorial, multiplicando iterativamente os valores.
* O resultado do fatorial é armazenado em R0.
* Há tratamento para casos especiais como 0! = 1 e estouro de 32 bits.
* Inclui a tabela de vetores de interrupção (`__vector_table`) e handlers padrão.

## Estrutura do Código

* **`__iar_program_start`**: Ponto de entrada do programa.
* **`main`**: Inicializa o valor e chama a função de fatorial.
* **`Fat`**: Lógica de cálculo do fatorial.
* **`check_mul`**: verifica o estouro de 32 bits.
* **`retorno1`, `retorno2`, `retorno3`**: Lida com retornos diversos, incluindo o 0!, o retorno usual e o estouro, respectivamente.
* **`__vector_table`**: Vetores de interrupção.
* **Handlers**: Tratamento básico de interrupções.

## Compilação

* Usar IAR Embedded Workbench.
* Compilar para ARM Cortex-M.

## Notas

* Inclui tratamento para 0! = 1.
* Detecta e sinaliza estouro de 32 bits com retorno de -1.
* Handlers de interrupção padrão são loops infinitos.
