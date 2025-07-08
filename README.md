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
status = 100         
escreva(status)      

status = "Ativo"     
escreva(status)      
```

---

## 3. Entrada e Saída 

### Escrevendo na Tela: `escreva`

Imprimir um único item:

```fplus
escreva("Bem-vindo!")
escreva(variavel)
```

Imprimir múltiplos itens:

```fplus
var nome 
nome = "Lucas"
var idade 
idade = 28
escreva("Usuário:", nome, "tem", idade, "anos.")
```

### Lendo do Teclado: `ler`

```fplus
var entrada
escreva("Digite seu nome:")
ler(entrada)

escreva("Agora, digite sua idade:")
ler(entrada) 
```

---

## 4. Estruturas de Controle

Os blocos de código são delimitados por chaves `{}`.

### IF E ELSE

```fplus
var idade
idade = 20
if (idade >= 18) {
    escreva("Maior de idade")
}
```

Com `ELSE`:

```fplus
var nota
nota = 5.5
if (nota >= 7) {
    escreva("Aprovado")
} else {
    escreva("Reprovado")
}
```

### WHILE

```fplus
var contador
contador = 5

escreva("Contagem")
while (contador > 0) {
    escreva(contador, "...")
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

escreva("A média é:", notas[2])
```

---

## 6. Operadores

| Categoria     | Operador | Descrição                       |
|---------------|----------|---------------------------------|
| Aritméticos   | `+`      | Adição                          |
|               | `-`      | Subtração                       |
|               | `*`      | Multiplicação                   |
|               | `/`      | Divisão                         |
| Comparação    | `>`      | Maior que                       |
|               | `<`      | Menor que                       |
|               | `>=`     | Maior ou igual a                |
|               | `<=`     | Menor ou igual a                |
|               | `==`     | Exatamente igual a              |
|               | `<>`     | Diferente de                    |

---

