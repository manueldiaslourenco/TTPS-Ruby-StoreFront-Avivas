# Proyecto Cursada Taller de Tecnologias de Produccion de Software - Opción Ruby

## Descripción General

El proyecto se basa en una aplicacion desarrollada en rails, con una parte publica que se denomina Storefront, la cara visible de la cadena de ropa de Avivas, donde se le permite a los visitantes ver un listado de productos y la informacion de los mismos. Por otra parte mas privada, se puede ver toda la gestion del inventario y administracion de la cadena de ropa, la cual necesita autenticacion y un rol adecuado para acceder a ciertas funciones.

La aplicacion ofrece estas funcionalidades: 

- Administración de productos: listar productos, agregar producto, modificar producto, eliminar producto, cambiar stock, detalle del producto.
- Administración de ventas: listar ventas, asentar venta, cancelar venta, detalle de venta.
- Gestión de usuarios: listar usuario, crear usuario, desactivar usuario, editar un propio usuario(No se le permite modificar su rol), detalle de usuario.

En la cadena existen tres distintos roles, los cuales son y pueden hacer lo siguiente:

- Empleado: tiene acceso a la administración de productos y ventas, pero no puede gestionar usuarios, solo operaciones sobre el mismo como la edicion y el detalle de su informacion.
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
(Este reset realiza la configuraciond de la base de datos nuevamente y ademas aplica los seeds predefinidos.)

## Gemas Utilizadas 

### Gemas

| Gema | Versión | Propósito |
|------|---------|-----------|
| [nombre-gema] | [versión] | [Descripción de uso] |

## Estructura de la Base de Datos 

### Entidades

#### [Nombre Entidad]
- **Descripción**: [Explicación del modelo/entidad]

## Cómo Ejecutar la Aplicación 

### Servidor de Desarrollo

```bash
rails server
# o 
rails s
```

Ir a `http://localhost:3000`

## Seeds de Prueba 

Los seeds incluyen los siguientes registros para pruebas:

- [Registro 1]: [Descripción]
- [Registro 2]: [Descripción]
- [Registro 3]: [Descripción]

Para cargar los seeds:

```bash
rails db:seed
```

