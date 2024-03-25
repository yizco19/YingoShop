# Documento de la Interfaz de Tienda informatica - V1.0

## 1. Interfaces Relacionadas con el Usuario

### 1.1 Registro

#### 1.1.1 Información Básica

> Ruta :/user/register
>
> Método ：POST
>
> Descripción :Esta interfaz se utiliza para registrar nuevos usuarios.



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

> Después de que el usuario inicia sesión con éxito, el sistema automáticamente emite un token JWT. En las solicitudes subsiguientes, el navegador debe incluirlo en la cabecera de la solicitud (header) al servidor. El nombre de la cabecera es Authorization, y el valor es el token JWT emitido durante el inicio de sesión.
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
        "createTime": "2023-09-02 22:21:31",
        "updateTime": "2023-09-02 22:21:31"
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
### 1.7 Actualizar Dirección del Usuario

#### 1.7.1 Información Básica

> Ruta de solicitud: /user/updateAddress
>
> Método de solicitud: PATCH
>
> Descripción de la interfaz: Esta interfaz se utiliza para actualizar la dirección del usuario actualmente conectado.

#### 1.7.2 Parámetros de Solicitud

Formato de los parámetros de solicitud: application/json

Explicación de los parámetros de solicitud:

| Nombre   | Descripción          | Tipo   | Obligatorio | Observaciones                       |
| -------- | -------------------- | ------ | ----------- | ----------------------------------- |
| address  | Nueva dirección del usuario | string | Sí          |                                     |

Ejemplo de datos de solicitud:

```json
{
    "address": "Nueva Calle 789"
}
```


# 2. Interfaz de Categorías de productos

### 2.1 Lista de categorías de produtos

#### 2.1.1 Información Básica

> Ruta de solicitud: /category
>
> Método de solicitud: POST
>
> Descripción de la interfaz: Esta interfaz se utiliza para obtener todas las categorías de productos creadas por el administrador 

#### 2.1.2 Parámetros de Solicitud
Ninguna

#### 2.1.3 Datos de Respuesta

Tipo de datos de respuesta: application/json

Explicación de los parámetros de respuesta:



```json
{
    "code": 0,
    "message": "Operacion éxitosa",
    "data": null
}
```



### 2.2 文章分类列表

#### 2.2.1 基本信息

> 请求路径：/category
>
> 请求方式：GET
>
> 接口描述：该接口用于获取当前已登录用户创建的所有文章分类

#### 2.2.2 请求参数

无

#### 2.2.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称             | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ---------------- | ------ | -------- | ------ | --------------------- | -------- |
| code             | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message          | string | 非必须   |        | 提示信息              |          |
| data             | array  | 必须     |        | 返回的数据            |          |
| \|-id            | number | 非必须   |        | 主键ID                |          |
| \|-categoryName  | string | 非必须   |        | 分类名称              |          |
| \|-categoryAlias | string | 非必须   |        | 分类别名              |          |
| \|-createTime    | string | 非必须   |        | 创建时间              |          |
| \|-updateTime    | string | 非必须   |        | 修改时间              |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": [
        {
            "id": 3,
            "categoryName": "美食",
            "categoryAlias": "my",
            "createTime": "2023-09-02 12:06:59",
            "updateTime": "2023-09-02 12:06:59"
        },
        {
            "id": 4,
            "categoryName": "娱乐",
            "categoryAlias": "yl",
            "createTime": "2023-09-02 12:08:16",
            "updateTime": "2023-09-02 12:08:16"
        },
        {
            "id": 5,
            "categoryName": "军事",
            "categoryAlias": "js",
            "createTime": "2023-09-02 12:08:33",
            "updateTime": "2023-09-02 12:08:33"
        }
    ]
}
```



### 2.3 获取文章分类详情

#### 2.3.1 基本信息

> 请求路径：/category/detail
>
> 请求方式：GET
>
> 接口描述：该接口用于根据ID获取文章分类详情

#### 2.3.2 请求参数

请求参数格式：queryString

请求参数说明：

| 参数名称 | 说明   | 类型   | 是否必须 | 备注 |
| -------- | ------ | ------ | -------- | ---- |
| id       | 主键ID | number | 是       |      |

请求数据样例：

```shell
id=6
```

#### 2.3.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称             | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ---------------- | ------ | -------- | ------ | --------------------- | -------- |
| code             | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message          | string | 非必须   |        | 提示信息              |          |
| data             | object | 必须     |        | 返回的数据            |          |
| \|-id            | number | 非必须   |        | 主键ID                |          |
| \|-categoryName  | string | 非必须   |        | 分类名称              |          |
| \|-categoryAlias | string | 非必须   |        | 分类别名              |          |
| \|-createTime    | string | 非必须   |        | 创建时间              |          |
| \|-updateTime    | string | 非必须   |        | 修改时间              |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": {
        "id": 6,
        "categoryName": "风土人情",
        "categoryAlias": "ftrq",
        "createTime": "2023-09-03 11:07:13",
        "updateTime": "2023-09-03 11:13:39"
    }
}
```



### 2.4 更新文章分类

#### 2.4.1 基本信息

> 请求路径：/category
>
> 请求方式：PUT
>
> 接口描述：该接口用于更新文章分类

#### 2.4.2 请求参数

请求参数格式：application/json

请求参数说明：

| 参数名称      | 说明     | 类型   | 是否必须 | 备注 |
| ------------- | -------- | ------ | -------- | ---- |
| id            | 主键ID   | number | 是       |      |
| categoryName  | 分类名称 | string | 是       |      |
| categoryAlias | 分类别名 | string | 是       |      |

请求数据样例：

```json
{
    "id":6,
    "categoryName":"风土人情",
    "categoryAlias":"ftrq"
}
```

#### 2.4.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ------- | ------ | -------- | ------ | --------------------- | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message | string | 非必须   |        | 提示信息              |          |
| data    | object | 非必须   |        | 返回的数据            |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": null
}
```



### 2.5 删除文章分类

#### 2.5.1 基本信息

> 请求路径：/category
>
> 请求方式：DELETE
>
> 接口描述：该接口用于根据ID删除文章分类

#### 2.5.2 请求参数

请求参数格式：queryString

请求参数说明：

| 参数名称 | 说明   | 类型   | 是否必须 | 备注 |
| -------- | ------ | ------ | -------- | ---- |
| id       | 主键ID | number | 是       |      |

请求数据样例：

```shell
id=6
```

#### 2.5.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ------- | ------ | -------- | ------ | --------------------- | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message | string | 非必须   |        | 提示信息              |          |
| data    | object | 非必须   |        | 返回的数据            |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": null
}
```



## 3. 文章管理相关接口

### 3.1 新增文章

#### 3.1.1 基本信息

> 请求路径：/article
>
> 请求方式：POST
>
> 接口描述：该接口用于新增文章(发布文章)

#### 3.1.2 请求参数

请求参数格式：application/json

请求参数说明：

| 参数名称   | 说明         | 类型   | 是否必须 | 备注           |      |
| ---------- | ------------ | ------ | -------- | -------------- | ---- |
| title      | 文章标题     | string | 是       | 1~10个非空字符 |      |
| content    | 文章正文     | string | 是       |                |      |
| coverImg   | 封面图像地址 | string | 是       | 必须是url地址  |      |
| state      | 发布状态     | string | 是       | 已发布 \| 草稿 |      |
| categoryId | 文章分类ID   | number | 是       |                |      |

请求数据样例：

```json
{
  "title": "陕西旅游攻略",
  "content": "兵马俑,华清池,法门寺,华山...爱去哪去哪...",
  "coverImg": "https://big-event-gwd.oss-cn-beijing.aliyuncs.com/9bf1cf5b-1420-4c1b-91ad-e0f4631cbed4.png",
  "state": "草稿",
  "categoryId": 2
}
```

#### 3.1.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ------- | ------ | -------- | ------ | --------------------- | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message | string | 非必须   |        | 提示信息              |          |
| data    | object | 非必须   |        | 返回的数据            |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": null
}
```



### 3.2 文章列表(条件分页)

#### 3.2.1 基本信息

> 请求路径：/article
>
> 请求方式：GET
>
> 接口描述：该接口用于根据条件查询文章,带分页

#### 3.2.2 请求参数

请求参数格式：queryString

请求参数说明：

| 参数名称   | 说明       | 类型   | 是否必须 | 备注           |      |
| ---------- | ---------- | ------ | -------- | -------------- | ---- |
| pageNum    | 当前页码   | number | 是       |                |      |
| pageSize   | 每页条数   | number | 是       |                |      |
| categoryId | 文章分类ID | number | 否       |                |      |
| state      | 发布状态   | string | 否       | 已发布 \| 草稿 |      |

请求数据样例：

```shell
pageNum=1&pageSize=3&categoryId=2&state=草稿
```

#### 3.2.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称          | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息     |
| ------------- | ------ | -------- | ------ | --------------------- | ------------ |
| code          | number | 必须     |        | 响应码, 0-成功,1-失败 |              |
| message       | string | 非必须   |        | 提示信息              |              |
| data          | object | 必须     |        | 返回的数据            |              |
| \|-total      | number | 必须     |        | 总记录数              |              |
| \|-items      | array  | 必须     |        | 数据列表              |              |
| \|-id         | number | 非必须   |        | 主键ID                |              |
| \|-title      | string | 非必须   |        | 文章标题              |              |
| \|-content    | string | 非必须   |        | 文章正文              |              |
| \|-coverImg   | string | 非必须   |        | 文章封面图像地址      |              |
| \|-state      | string | 非必须   |        | 发布状态              | 已发布\|草稿 |
| \|-categoryId | number | 非必须   |        | 文章分类ID            |              |
| \|-createTime | string | 非必须   |        | 创建时间              |              |
| \|-updateTime | string | 非必须   |        | 更新时间              |              |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": {
        "total": 1,
        "items": [
            {
                "id": 5,
                "title": "陕西旅游攻略",
                "content": "兵马俑,华清池,法门寺,华山...爱去哪去哪...",
                "coverImg": "https://big-event-gwd.oss-cn-beijing.aliyuncs.com/9bf1cf5b-1420-4c1b-91ad-e0f4631cbed4.png",
                "state": "草稿",
                "categoryId": 2,
                "createTime": "2023-09-03 11:55:30",
                "updateTime": "2023-09-03 11:55:30"
            }
        ]
    }
}
```







### 3.3 获取文章详情

#### 3.3.1 基本信息

> 请求路径：/article/detail
>
> 请求方式：GET
>
> 接口描述：该接口用于根据ID获取文章详细信息

#### 3.3.2 请求参数

请求参数格式：queryString

请求参数说明：

| 参数名称 | 说明   | 类型   | 是否必须 | 备注 |      |
| -------- | ------ | ------ | -------- | ---- | ---- |
| id       | 主键ID | number | 是       |      |      |

请求数据样例：

```shell
id=4
```

#### 3.3.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称          | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息     |
| ------------- | ------ | -------- | ------ | --------------------- | ------------ |
| code          | number | 必须     |        | 响应码, 0-成功,1-失败 |              |
| message       | string | 非必须   |        | 提示信息              |              |
| data          | object | 必须     |        | 返回的数据            |              |
| \|-id         | number | 非必须   |        | 主键ID                |              |
| \|-title      | string | 非必须   |        | 文章标题              |              |
| \|-content    | string | 非必须   |        | 文章正文              |              |
| \|-coverImg   | string | 非必须   |        | 文章封面图像地址      |              |
| \|-state      | string | 非必须   |        | 发布状态              | 已发布\|草稿 |
| \|-categoryId | number | 非必须   |        | 文章分类ID            |              |
| \|-createTime | string | 非必须   |        | 创建时间              |              |
| \|-updateTime | string | 非必须   |        | 更新时间              |              |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": {
        "id": 4,
        "title": "北京旅游攻略",
        "content": "天安门,颐和园,鸟巢,长城...爱去哪去哪...",
        "coverImg": "https://big-event-gwd.oss-cn-beijing.aliyuncs.com/9bf1cf5b-1420-4c1b-91ad-e0f4631cbed4.png",
        "state": "已发布",
        "categoryId": 2,
        "createTime": "2023-09-03 11:35:04",
        "updateTime": "2023-09-03 11:40:31"
    }
}
```



### 3.4 更新文章

#### 3.4.1 基本信息

> 请求路径：/article
>
> 请求方式：PUT
>
> 接口描述：该接口用于更新文章信息

#### 3.4.2 请求参数

请求参数格式：application/json

请求参数说明：

| 参数名称   | 说明         | 类型   | 是否必须 | 备注           |      |
| ---------- | ------------ | ------ | -------- | -------------- | ---- |
| id         | 主键ID       | number | 是       |                |      |
| title      | 文章标题     | string | 是       |                |      |
| content    | 文章正文     | string | 是       |                |      |
| coverImg   | 封面图像地址 | string | 是       |                |      |
| state      | 发布状态     | string | 是       | 已发布 \| 草稿 |      |
| categoryId | 文章分类ID   | number | 是       |                |      |

请求数据样例：

```json
{
    "id":4,
    "title": "北京旅游攻略",
    "content": "天安门,颐和园,鸟巢,长城...爱去哪去哪...",
    "coverImg": "https://big-event-gwd.oss-cn-beijing.aliyuncs.com/9bf1cf5b-1420-4c1b-91ad-e0f4631cbed4.png",
    "state": "已发布",
    "categoryId": 2
}
```

#### 3.4.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ------- | ------ | -------- | ------ | --------------------- | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message | string | 非必须   |        | 提示信息              |          |
| data    | object | 非必须   |        | 返回的数据            |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": null
}
```





### 3.5 删除文章

#### 3.5.1 基本信息

> 请求路径：/article
>
> 请求方式：DELETE
>
> 接口描述：该接口用于根据ID删除文章

#### 3.5.2 请求参数

请求参数格式：queryString

请求参数说明：

| 参数名称 | 说明   | 类型   | 是否必须 | 备注 |      |
| -------- | ------ | ------ | -------- | ---- | ---- |
| id       | 主键ID | number | 是       |      |      |

请求数据样例：

```shell
id=4
```

#### 3.5.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                  | 其他信息 |
| ------- | ------ | -------- | ------ | --------------------- | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败 |          |
| message | string | 非必须   |        | 提示信息              |          |
| data    | object | 非必须   |        | 返回的数据            |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": null
}
```





## 4. 其他接口

### 4.1 文件上传

#### 4.1.1 基本信息

> 请求路径：/upload
>
> 请求方式：POST
>
> 接口描述：该接口用于上传文件(单文件)

#### 4.1.2 请求参数

请求参数格式：multipart/form-data

请求参数说明：

| 参数名称 | 说明                     | 类型 | 是否必须 | 备注 |      |
| -------- | ------------------------ | ---- | -------- | ---- | ---- |
| file     | 表单中文件请求参数的名字 | file | 是       |      |      |

请求数据样例：

无

#### 4.1.3 响应数据

响应数据类型：application/json

响应参数说明：

| 名称    | 类型   | 是否必须 | 默认值 | 备注                     | 其他信息 |
| ------- | ------ | -------- | ------ | ------------------------ | -------- |
| code    | number | 必须     |        | 响应码, 0-成功,1-失败    |          |
| message | string | 非必须   |        | 提示信息                 |          |
| data    | string | 必须     |        | 图像在阿里云上的存储地址 |          |

响应数据样例：

```json
{
    "code": 0,
    "message": "操作成功",
    "data": "https://big-event-gwd.oss-cn-beijing.aliyuncs.com/b5811871-acc8-4583-8399-cf0dc73591ab.png"
}
```

