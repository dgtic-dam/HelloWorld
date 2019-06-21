# Swift-Basic

## Opcional
Una variable opcional se dice de aquella cuya declaración contiene el signo de interrogación (?) siguiendo al tipo de dato:

`var restaurantName: String?`

Como podemos ver la única diferencia con una variable normal es el signo de interrogación al final de la línea, esto es lo que vuelve la variable en Optional u opcional por su traducción al castellano. Una variable opcional no es más que un contenedor, un espacio de memoria que puede o no tener un valor asociado, aunque cuando no tiene un valor asociado el compilador asigna nil a la variable en cuestión.

Para entender del todo, veamos una variable opcional como una caja o un envoltorio cualquiera, donde al momento de su creación (de no darle un valor inicial) se introduce el valor especial nil. Una vez declarada esta variable, el contenido de la misma pasa a ser enmascarado (oculto) y como único podemos verificar su contenido es desenvolviendo implícitamente la misma. Esto lo podemos lograr mediante el signo de exclamación (!), de la siguiente forma:

`restaurantName!`

Es importante aclarar que en caso de que esta variable contenga nil como valor asociado e intentamos desempaquetar su contenido, el compilador lanzará un “fatal error” mostrándonos el siguiente mensaje:

fatal error: unexpectedly found nil while unwrapping an Optional value
Para evitar este error, antes de hacer uso de la variable, tenemos que verificar si el contenido de la misma no es nil. Como muchos habrán imaginado, esto lo podemos lograr con el siguiente código:

`
if restaurantName != nil {

    print("El valor de la variable opcional es: \(restaurantName!)")

} else {

    print("Valor nulo")

} // else

`
…aunque el enfoque del código anterior es el correcto, se recomienda usar la sintaxis if let para tal fin, como podemos observar en el ejemplo a continuación:

`
if let restaurantNameUnwrapped = restaurantName {

    print("El valor de la variable opcional es: \(restaurantNameUnwrapped)")

} else {

    print("Valor nulo")

} // else
`
A esta forma se le conoce como Optional Binding y se utiliza para averiguar si una variable opcional contiene un valor distinto a nil, de ser así, el valor de la misma pasa a estar disponible como una constante o variable temporal, como parte de una sola acción.

You can unwrap optionals in 3 different ways:

With force unwrapping, using !
let email:String? = "johndoe@example.com"
`
if email != nil {
    print(email!)
}
`
With optional binding, using if let
let optionalUsername:String? = "bob42"
`
if let username = optionalUsername {
    print(username)
}
`
With implicitly unwrapped optionals, using !
`@IBOutlet weak var usernameField:UITextField?`

## Var y Let

To make a constant, use let like this:

`let x = 10`
To make a variable, use var like this:

`var y = 20`


