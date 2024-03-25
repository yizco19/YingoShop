# Documento de la Interfaz de Tienda informatica - V1.0

## 1. Interfaces Relacionadas con el Usuario

### 1.1 Registro

#### 1.1.1 Información Básica

> Ruta : /user/register
>
> Método ：POST
>
> Descripción : Esta interfaz se utiliza para registrar nuevos usuarios.



#### 1.1.2 Parámetros de Solicitud

Formato de los parámetros de solicitud: x-www-form-urlencoded

Explicación de los parámetros de solicitud:

| Nombre del Parámetro | Descripción      | Tipo   | Obligatorio | Observaciones               |
| -------------------- | ---------------- | ------ | ----------- | --------------------------- |
| username             | Nombre de usuario | string | Sí          | 5~16 caracteres no vacíos   |
| email                | Correo electrónico| string | Sí          | Debe ser una email válida|
| password             | Contraseña        | string | Sí          | 5~16 caracteres no vacíos   |

Ejemplo de datos de solicitud:

```shell
username=pepe&email=pepe@gmail.com&password=123456
```


#### 1.1.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:

| Nombre   | Tipo    | Obligatorio | Valor predeterminado | Observaciones                  | Otros   |
| -------- | ------- | ----------- | -------------------- | ------------------------------ | ------- |
| code     | number  | Sí          |                      | Código de respuesta, 0-éxito, 1-fallo |         |
| message  | string  | No          |                      | Mensaje de aviso               |         |
| data     | object  | No          |                      | Datos devueltos                |         |

Ejemplo de datos de respuesta:

```json
{
    "code": 0,
    "message": "Operación exitosa",
    "data": null
}
```
## 1.2 Login
#### 1.2.1 Información Básica

> Ruta de solicitud: /user/login
>
> Método de solicitud: POST
>
> Descripción de la interfaz: Esta interfaz se utiliza para iniciar sesión.

#### 1.2.2 Parámetros de Solicitud

Formato de los parámetros de solicitud: x-www-form-urlencoded

Explicación de los parámetros de solicitud:

| Nombre del Parámetro | Descripción | Tipo   | Obligatorio | Observaciones          |
| -------------------- | ----------- | ------ | ----------- | ---------------------- |
| username_or_email    | Nombre de usuario o Correo electrónico | string | Sí          | 5~16 caracteres no vacíos |
| password             | Contraseña        | string | Sí          | 5~16 caracteres no vacíos |

Ejemplo de datos de solicitud:

```shell
username_or_email=pepe&password=123456
```


#### 1.2.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:

| Nombre   | Tipo    | Obligatorio | Valor predeterminado | Observaciones                  | Otros   |
| -------- | ------- | ----------- | -------------------- | ------------------------------ | ------- |
| code     | number  | Sí          |                      | Código de respuesta, 0-éxito, 1-fallo |         |
| message  | string  | No          |                      | Mensaje de aviso               |         |
| data     | string  | Sí          |                      | Datos devueltos, token JWT    |         |

Ejemplo de datos de respuesta:

```json
{
    "code": 0,
    "message": "Operación exitosa",
    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.qwebonPGMWPERMKPbpmifpqwepqwoenjp.pE_RATcoF7Nm9KEp9eC3CzcBbKWAFOL0IsuMNjnZ95M"
}
```


#### 1.2.4 Notas Explicativas

> Después de que el usuario inicia sesión con éxito, el sistema automáticamente emite un token JWT. En las solicitudes subsiguientes, el app o navegador debe incluirlo en la cabecera de la solicitud (header) al servidor. El nombre de la cabecera es Authorization, y el valor es el token JWT emitido durante el inicio de sesión.
>
> Si se detecta que el usuario no ha iniciado sesión, el código de estado de respuesta HTTP será 401.




### 1.3 Obtener Información Detallada del Usuario

#### 1.3.1 Información Básica

> Ruta de solicitud: /user/userInfo
>
> Método de solicitud: GET
>
> Descripción de la interfaz: Esta interfaz se utiliza para obtener información detallada del usuario actualmente conectado.

#### 1.3.2 Parámetros de Solicitud

Ninguno

#### 1.3.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:

| Nombre        | Tipo   | Obligatorio | Valor predeterminado | Observaciones                  | Otros   |
| ------------- | ------ | ----------- | -------------------- | ------------------------------ | ------- |
| code          | number | Sí          |                      | Código de respuesta, 0-éxito, 1-fallo |         |
| message       | string | No          |                      | Mensaje de aviso               |         |
| data          | object | Sí          |                      | Datos devueltos                |         |
| \|-id         | number | No          |                      | ID principal                   |         |
| \|-username   | string | No          |                      | Nombre de usuario              |         |
| \|-nickname   | string | No          |                      | Apodo                          |         |
| \|-email      | string | No          |                      | Correo electrónico            |         |
| \|-userPic    | string | No          |                      | URL de la imagen de perfil     |         |
| \|-gender     | string | No          |                      | Género (0-masculino, 1-femenino)|         |
| \|-birthdate  | string | No          |                      | Fecha de nacimiento            |         |
| \|-address    | string | No          |                      | Dirección del usuario          |         |
| \|-phone      | string | No          |                      | Número de teléfono del usuario |         |
| \|-createTime | string | No          |                      | Hora de creación               |         |

Ejemplo de datos de respuesta:

```json
{
    "code": 0,
    "message": "Operación exitosa",
    "data": {
        "id": 5,
        "username": "pepe",
        "nickname": "",
        "email": "",
        "userPic": "",
        "gender": "0",
        "birthdate": "1990-01-01",
        "address": "Calle Principal 123",
        "phone": "123-456-7890",
        "createTime": "2023-09-02 22:21:31"
    }
}
```



### 1.4 Actualizar Información Básica del Usuario

#### 1.4.1 Información Básica

> Ruta de solicitud: /user/update
>
> Método de solicitud: PUT
>
> Descripción de la interfaz: Esta interfaz se utiliza para actualizar la información básica del usuario actualmente conectado (excluyendo la imagen de perfil y la contraseña).

#### 1.4.2 Parámetros de Solicitud

Tipo de datos de respuesta: application/json

Explicación de los parámetros de solicitud:

| Nombre        | Descripción                | Tipo   | Obligatorio | Observaciones                       |
| ------------- | -------------------------- | ------ | ----------- | ----------------------------------- |
| id            | ID principal               | number | Sí
| username      | Nombre de usuario          | string | No          | 5~16 caracteres no vacíos          |
| nickname      | Apodo                      | string | No          |                                   |
| email         | Correo electrónico         | string | No          | Debe ser una email válida      |
| gender        | Género                     | string | No          | 0-masculino, 1-femenino             |
| birthdate     | Fecha de nacimiento        | string | No          | Formato: "YYYY-MM-DD"               |
| address       | Dirección del usuario      | string | No          |                                   |
| phone         | Número de teléfono         | string | No          |                                   |
| createTime    | Hora de creación          | string | No          |                                   |

Ejemplo de datos de solicitud:

```json
{
    "username": "nuevonombre",
    "nickname": "nuevoapodo",
    "email": "nuevo@correo.com",
    "gender": "1",
    "birthdate": "1995-12-15",
    "address": "Nueva Calle 456",
    "phone": "987-654-3210"
}
```
#### 1.4.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:

| Nombre   | Tipo   | Obligatorio | Valor predeterminado | Observaciones                  | Otros   |
| -------- | ------ | ----------- | -------------------- | ------------------------------ | ------- |
| code     | number | Sí          |                      | Código de respuesta, 0-éxito, 1-fallo |         |
| message  | string | No          |                      | Mensaje de aviso               |         |
| data     | object | No          |                      | Datos devueltos                |         |

Ejemplo de datos de respuesta:

```json
{
    "code": 0,
    "message": "Operación exitosa",
    "data": null
}
```



### 1.5 Actualizar la Imagen de Perfil del Usuario

#### 1.5.1 Información Básica

> Ruta de solicitud: /user/updateAvatar
>
> Método de solicitud: PATCH
>
> Descripción de la interfaz: Esta interfaz se utiliza para actualizar la imagen de perfil del usuario actualmente conectado.

#### 1.5.2 Parámetros de Solicitud

Formato de los parámetros de solicitud: queryString

Explicación de los parámetros de solicitud:

| Nombre     | Descripción | Tipo   | Obligatorio | Observaciones          |
| ---------- | ----------- | ------ | ----------- | ---------------------- |
| avatarUrl  | URL de la imagen de perfil | string | Sí          | Dirección URL de la imagen de perfil |

Ejemplo de datos de solicitud:

```shell
avatarUrl=https://imagen/imagen.png
```

#### 1.5.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:

| Nombre   | Tipo   | Obligatorio | Valor predeterminado | Observaciones                  | Otros   |
| -------- | ------ | ----------- | -------------------- | ------------------------------ | ------- |
| code     | number | Sí          |                      | Código de respuesta, 0-éxito, 1-fallo |         |
| message  | string | No          |                      | Mensaje de aviso               |         |
| data     | object | No          |                      | Datos devueltos                |         |

Ejemplo de datos de respuesta:

```json
{
    "code": 0,
    "message": "Operación exitosa",
    "data": null
}

```



### 1.6 Actualizar Contraseña del Usuario

#### 1.6.1 Información Básica

> Ruta de solicitud: /user/updatePwd
>
> Método de solicitud: PATCH
>
> Descripción de la interfaz: Esta interfaz se utiliza para actualizar la contraseña del usuario actualmente conectado.

#### 1.6.2 Parámetros de Solicitud

Formato de los parámetros de solicitud: application/json

Explicación de los parámetros de solicitud:

| Nombre  | Descripción          | Tipo   | Obligatorio | Observaciones                       |
| ------- | -------------------- | ------ | ----------- | ----------------------------------- |
| old_pwd | Contraseña anterior  | string | Sí          |                                     |
| new_pwd | Nueva contraseña     | string | Sí          |                                     |
| re_pwd  | Confirmar nueva contraseña | string | Sí     |                                     |

Ejemplo de datos de solicitud:

```json
{
    "old_pwd":"123456",
    "new_pwd":"234567",
    "re_pwd":"234567"
}
```

# 2. Interfaz de Categorías de productos

### 2.1 Lista de categorías de produtos
