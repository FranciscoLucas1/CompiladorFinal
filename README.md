# Documentação da linguagem



## 1. Estrutura e Sintaxe Básica

### Comentários


- **Linha única:** `//`

```fplus
// Esta linha inteira é um comentário
```

- **Múltiplas linhas:** `/* ... */`

```fplus
/*
  Este é um bloco de comentário
  que pode abranger várias linhas.
*/
```

### Estrutura básica

```fplus
// código
FIM
```


## 2. Variáveis e Tipos de Dados

### Declaração

As variáveis são declaradas com a palavra-chave `var`:

```fplus
var nome_da_variavel
var idade
var saldo_bancario
```

### Atribuição

Use `=` para atribuir valores:

```fplus
var status
status = 100         // 'status' é Número
ESCREVA(status)      // Imprime 100.00

status = "Ativo"     // Agora é Texto
ESCREVA(status)      // Imprime Ativo
```

---

## 3. Entrada e Saída 

### Escrevendo na Tela: `ESCREVA`

Imprimir um único item:

```fplus
ESCREVA("Bem-vindo!")
ESCREVA(variavel)
```

Imprimir múltiplos itens:

```fplus
var nome = "Lucas"
var idade = 28
ESCREVA("Usuário:", nome, "tem", idade, "anos.")
// Saída: Usuario: Lucas tem 28.00 anos.
```

### Lendo do Teclado: `LER`

```fplus
var entrada
ESCREVA("Digite seu nome:")
LER(entrada)

ESCREVA("Agora, digite sua idade:")
LER(entrada) 
```

---

## 4. Estruturas de Controle

Os blocos de código são delimitados por chaves `{}`.

### IF e ELSE

```fplus
var idade = 20
IF (idade >= 18) {
    ESCREVA("Maior de idade")
}
```

Com `ELSE`:

```fplus
var nota = 5.5
IF (nota >= 7) {
    ESCREVA("Aprovado")
} ELSE {
    ESCREVA("Reprovado")
}
```

### WHILE

```fplus
var contador
contador = 5

ESCREVA("Contagem")
WHILE (contador > 0) {
    ESCREVA(contador, "...")
    contador = contador - 1
}

```

---

## 5. Vetores (Arrays)

### Declaração

```fplus
var resultados[5] // Vetor com 5 posições (0 a 4)
```

### Atribuição e Acesso

```fplus
var notas[3]
notas[0] = 10
notas[1] = 7.5
notas[2] = (notas[0] + notas[1]) / 2

ESCREVA("A média é:", notas[2])
```

---

## 6. Operadores

| Categoria     | Operador | Descrição                       |
|---------------|----------|---------------------------------|
| Aritméticos   | `+`      | Adição                          |
|               | `-`      | Subtração                       |
|               | `*`      | Multiplicação                   |
|               | `/`      | Divisão                         |
|               | `-`      | Menos Unário (inversão de sinal)|
| Comparação    | `>`      | Maior que                       |
|               | `<`      | Menor que                       |
|               | `>=`     | Maior ou igual a                |
|               | `<=`     | Menor ou igual a                |
|               | `==`     | Exatamente igual a              |
|               | `<>`     | Diferente de                    |

---

