# Proyecto Cursada Taller de Tecnologias de Produccion de Software - Opción Ruby

## Descripción General

El proyecto se basa en una aplicación desarrollada en rails, con una parte publica que se denomina Storefront, la cara visible de la cadena de ropa de Avivas, donde se le permite a los visitantes ver un listado de productos y la información de los mismos. Por otra parte mas privada, se puede ver toda la gestión del inventario y administración de la cadena de ropa, la cual necesita autenticación y un rol adecuado para acceder a ciertas funciones.

La aplicación ofrece estas funcionalidades: 

- Administración de productos: listar productos, agregar producto, modificar producto, eliminar producto, cambiar stock, detalle del producto.
- Administración de ventas: listar ventas, asentar venta, cancelar venta, detalle de venta.
- Gestión de usuarios: listar usuario, crear usuario, desactivar usuario, editar un propio usuario(No se le permite modificar su rol), detalle de usuario.

En la cadena existen tres distintos roles, los cuales son y pueden hacer lo siguiente:

- Empleado: tiene acceso a la administración de productos y ventas, pero no puede gestionar usuarios, solo operaciones sobre el mismo como la edición y el detalle de su información.
- Gerente: tiene acceso a la administración de productos, ventas y puede gestionar usuarios, pero no puede realizar operaciones sobre usuarios con el rol de administrador.
- Administrador: tiene acceso a todas las funcionalidades de la aplicación.

## Requerimientos del Sistema 

- Ruby versión 3.3.6
- Rails versión 8.0.0
- Base de datos: SQLite3

## Configuración e Instalación 

### Clonar el Repositorio

```bash
git clone [URL del repositorio]
cd [nombre-del-proyecto]
```

### Instalación de Dependencias

```bash
bundle install
```

### Configuración de Base de Datos
La base de datos esta configurada, vacia y lista para funcionar.

-Si se requiere configurar nuevamente.
```bash
rails db:drop
rails db:create
rails db:migrate
```

-Si despues de realizar pruebas se busca una limpieza y reinicio.
```bash
rails db:reset
```
(El comando "db:reset" realiza la configuracion de la base de datos nuevamente y aplica los seeds predefinidos.)

## Gemas Utilizadas 

### Gemas

| Gema | Versión | Propósito |
|------|---------|-----------|
| devise | ~> 4.9 | El uso de esta gema fue facilitar el manejo de sesiones y autenticación de usuarios. |
| strong_password | ~> 0.0.10 | El uso de esta gema fue generar validaciones extras a las cotraseñas de los usuarios al momento de autenticarse. |
| ransack | ~> 4.2 | El uso de esta gema fue facilitar el manejo de los filtros para los listados de productos. |
| cancancan | ~> 3.6 | El uso de esta gema fue facilitar el manejo de roles y permisos de usuarios. |
| kaminari | ~> 1.2 | El uso de esta gema facilitar el manejo del paginado para los listados. |

## Estructura de la Base de Datos 

### Entidades

#### User
- **Descripción**: Se creó una entidad ***User*** para modelar el registro de personas que trabajan en el sistema, manejo de autenticación, roles y acceso correcto a determinadas funcionalidades.

#### Category
- **Descripción**: Se creó una entidad ***Category*** para modelar las categorías de un producto. Tiene como finalidad facilitar y mejorar la forma en la que se filtran los productos. Cuando se necesite filtrar productos por una categoría específica, se buscan todos los productos que tengan la categoría deseada y se realiza el filtrado.

#### Product
- **Descripción**: La entidad ***Product*** tiene como finalidad modelar los productos de la cadena de ropa, la cual, a través de Active Storage de Rails, se relaciona con imágenes dando una imagen mas grafica de su representación. Dicha entidad contiene toda la información necesaria para la representación de un producto de ropa.

#### SaleItem
- **Descripción**: Se creó una entidad ***SaleItem*** para modelar ítems de una venta, generando la relación entre ventas y productos. De esta forma, los productos pueden tener muchas ventas y las ventas muchos productos. También se guarda el precio unitario del producto al momento en que se efectúa la venta y la cantidad solicitada del mismo. Esto se pensó para el caso de que el precio del producto se modifique, permitiendo conservar el valor registrado en la venta.

#### Sale
- **Descripción**: La entidad ***Sale*** representa las ventas. Contiene una fecha de realización, la cual no puede ser futura, un monto total, el empleado que realizó la venta, un cliente, y uno o más productos que provienen de la relación con la entidad ***SaleItem*** previamente mencionada.

#### Client
- **Descripción**: Se creó una entidad ***Client*** para representar a los clientes, almacenando su información necesaria. La decisión de crear esta entidad es para poder tener la representación de los clientes y su información guardada aparte de la venta. Al crearse una venta, se ingresan los datos del cliente. Si el DNI ingresado se encuentra en el sistema, se actualiza toda la información ingresada, reemplazando la almacenada previamente. Si no se encuentra, se crea y registra en el sistema.
  
## Cómo Ejecutar la Aplicación 

### Servidor de Desarrollo

```bash
rails server
# o 
rails s
```

Ir a `http://localhost:3000`

## Seeds de Prueba 

Los seeds incluyen registros de categorias, productos, ventas y usuarios.

Registros de usuarios para pruebas:

- Usuario Administrador: Mail -> `administrador1@example.com` / contraseña -> `Proyecto2024.ruby`
- Usuario Gerente: Mail -> `gerente1@example.com` / contraseña -> `Proyecto2024.ruby`
- Usuario Empleado: Mail -> `empleado1@example.com` / contraseña -> `Proyecto2024.ruby`

Para cargar los seeds:

```bash
rails db:seed
```
