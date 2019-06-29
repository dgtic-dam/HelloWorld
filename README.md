# Swift-Basic

## Opcional
Una variable opcional se dice de aquella cuya declaración contiene el signo de interrogación (?) siguiendo al tipo de dato:

`var nombre: String?`

La única diferencia con una variable normal es el signo de interrogación al final de la línea, esto es lo que vuelve la variable en Optional. Una variable opcional no es más que un contenedor, un espacio de memoria que puede o no tener un valor asociado, aunque cuando no tiene un valor asociado el compilador asigna nil a la variable en cuestión.

Una variable opcional como una caja o un envoltorio cualquiera, donde al momento de su creación (de no darle un valor inicial) se introduce el valor especial nil. Una vez declarada esta variable, el contenido de la misma pasa a ser enmascarado (oculto) y como único podemos verificar su contenido es desenvolviendo implícitamente la misma. Esto lo podemos lograr mediante el signo de exclamación (!), de la siguiente forma:

`nombre!`


### Force unwrapping, usando !

````
let nombre:String? = "Daniel Rosales"

if nombre != nil {
    print(nombre!)
}
````

### Optional binding, utilizando if let

```
let optionalUsername:String? = "Jesus"

if let username = optionalUsername {
    print(username)
}

```

## Var y Let

Let se utiliza para constantes:

`let x = 100`

Var se utiliza para variables:

`var y = 100`


# Pages:

[Make App Icon](https://makeappicon.com/)
