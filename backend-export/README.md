# Backend Export - Documentación Completa

Este directorio contiene toda la documentación y datos necesarios para migrar el frontend de Cabañas App a un backend completo.

## 📁 Contenido del Directorio

```
backend-export/
├── README.md                   # Este archivo
├── cabanas-data.json          # Datos de las 3 cabañas en formato JSON
├── features-data.json         # Características y beneficios en formato JSON
├── gallery-data.json          # 12 imágenes de galería en formato JSON
├── config-data.json           # Configuración del sitio en formato JSON
├── api-spec.yaml              # Especificación OpenAPI 3.0 completa
├── DATABASE_SCHEMA.md         # Esquema de base de datos SQL y NoSQL
└── migration-scripts.sql      # Scripts SQL para insertar datos iniciales
```

## 🚀 Inicio Rápido

### 1. Revisar la Documentación Principal

Leer primero: `../BACKEND_MIGRATION.md` - Documento principal que describe toda la migración.

### 2. Datos en Formato JSON

Todos los datos del frontend están exportados en formato JSON:

- **cabanas-data.json**: 3 modelos de cabañas con todas sus propiedades
- **features-data.json**: 3 características de empresa + 6 beneficios
- **gallery-data.json**: 12 imágenes categorizadas (exterior, interior, amenities, landscape)
- **config-data.json**: Configuración del sitio, redes sociales, navegación

### 3. Especificación de la API

**api-spec.yaml** contiene la especificación OpenAPI 3.0 completa con:

- Todos los endpoints necesarios (públicos y admin)
- Schemas de request/response
- Validaciones
- Ejemplos
- Documentación de errores

Puedes visualizar esta especificación usando:
- [Swagger Editor](https://editor.swagger.io/)
- [Redoc](https://github.com/Redocly/redoc)
- [Stoplight](https://stoplight.io/)

### 4. Esquema de Base de Datos

**DATABASE_SCHEMA.md** incluye:

- Diagrama Entidad-Relación en ASCII
- Definiciones SQL para PostgreSQL
- Notas para MySQL
- Alternativa en MongoDB
- Índices recomendados
- Triggers para updated_at
- Consideraciones de rendimiento

### 5. Scripts de Migración

**migration-scripts.sql** contiene:

- Scripts INSERT para todos los datos iniciales
- Creación de usuario administrador por defecto
- Consultas de verificación

## 📊 Resumen de Datos

### Cabañas (3 modelos)
- Modelo Uno: Piscina, cocina equipada, vista panorámica
- Modelo Dos: Jacuzzi, terraza privada, WiFi
- Modelo Tres: Chimenea, zona exterior, vista panorámica

### Features de Empresa (3)
- Hospitalidad 24/7
- Wellness (Piscina & SPA)
- Conectividad (Workation Ready)

### Beneficios (6)
- Atención al cliente
- Piscina
- Cocina equipada
- Espacios exteriores
- Estacionamiento
- Ubicación privilegiada

### Galería (12 imágenes)
- 4 Exteriores
- 4 Interiores
- 2 Amenidades
- 2 Paisajes

## 🔌 API Endpoints

### Endpoints Públicos (Frontend)
```
GET  /api/cabanas                  Lista de cabañas
GET  /api/cabanas/:id              Cabaña por ID
GET  /api/cabanas/slug/:slug       Cabaña por slug
GET  /api/features                 Características
GET  /api/benefits                 Beneficios
GET  /api/gallery                  Galería completa
GET  /api/gallery?category=X       Galería filtrada
GET  /api/config/site              Configuración
GET  /api/config/navigation        Navegación
POST /api/contact                  Enviar mensaje [YA EXISTE]
```

### Endpoints Admin
```
POST   /api/auth/login            Login
POST   /api/cabanas               Crear cabaña
PUT    /api/cabanas/:id           Actualizar cabaña
DELETE /api/cabanas/:id           Eliminar cabaña
POST   /api/gallery               Subir imagen
DELETE /api/gallery/:id           Eliminar imagen
PUT    /api/config/site           Actualizar config
```

## 🛠️ Tecnologías del Frontend Actual

- **Framework**: Next.js 16.0.1
- **Lenguaje**: TypeScript 5
- **Validación**: Zod 4.1.12
- **Email**: Nodemailer 7.0.10
- **UI**: Tailwind CSS 4
- **Animaciones**: Framer Motion

## 🎯 Opciones de Implementación del Backend

### Opción 1: Mantener Next.js API Routes
✅ Ya está configurado  
✅ Sin configuración adicional  
✅ TypeScript nativo  
❌ Menos separación frontend/backend  

### Opción 2: Node.js + Express/Fastify
✅ Backend separado  
✅ Más control  
✅ Escalabilidad  
❌ Requiere configuración  

### Opción 3: Backend en otro lenguaje
- Django (Python)
- Laravel (PHP)
- Spring Boot (Java)
- .NET Core (C#)

## 📝 Variables de Entorno Necesarias

```env
# Base de Datos
DATABASE_URL=postgresql://user:pass@localhost:5432/cabanas_db

# Email (Nodemailer)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=tu-email@gmail.com
SMTP_PASS=tu-contraseña-de-aplicación
EMAIL_FROM=noreply@ejemplo.cl
EMAIL_TO=contacto@ejemplo.cl

# JWT Authentication
JWT_SECRET=tu-secreto-super-seguro
JWT_EXPIRATION=24h

# Upload de Imágenes
CLOUDINARY_CLOUD_NAME=tu-cloud-name
CLOUDINARY_API_KEY=tu-api-key
CLOUDINARY_API_SECRET=tu-api-secret

# O AWS S3
AWS_ACCESS_KEY_ID=tu-access-key
AWS_SECRET_ACCESS_KEY=tu-secret-key
AWS_BUCKET_NAME=cabanas-images
AWS_REGION=us-east-1

# Redis (opcional, para rate limiting)
REDIS_URL=redis://localhost:6379

# Configuración del sitio
NEXT_PUBLIC_SITE_URL=https://ejemplo-cabanas.cl
NODE_ENV=production
```

## 🔐 Seguridad

### Validación Existente (Zod)
El formulario de contacto ya tiene validación robusta:
- Nombre: 2-100 caracteres, solo letras
- Email: formato válido, 5-100 caracteres
- Teléfono: 10-20 caracteres, formato telefónico
- Mensaje: 10-1000 caracteres

### Rate Limiting
Configurado actualmente:
- 3 requests por hora por IP
- En memoria (usar Redis en producción)

### Autenticación
Implementar:
- JWT para endpoints admin
- Bcrypt para hash de contraseñas
- CORS configurado correctamente

## 🚀 Pasos de Migración Recomendados

1. **Crear Base de Datos**
   ```bash
   # Usando el esquema en DATABASE_SCHEMA.md
   psql -U postgres -f create-schema.sql
   ```

2. **Insertar Datos Iniciales**
   ```bash
   psql -U postgres -d cabanas_db -f migration-scripts.sql
   ```

3. **Configurar Variables de Entorno**
   ```bash
   cp .env.example .env
   # Editar .env con tus credenciales
   ```

4. **Implementar Endpoints de API**
   - Usar api-spec.yaml como referencia
   - Implementar autenticación JWT
   - Configurar upload de imágenes

5. **Actualizar Frontend**
   - Reemplazar imports estáticos con fetch/axios
   - Conectar a nuevos endpoints
   - Mantener tipos TypeScript

6. **Testing**
   - Probar todos los endpoints
   - Validar formularios
   - Verificar autenticación

## 📚 Recursos Adicionales

### Herramientas Útiles
- **Postman/Insomnia**: Testing de API
- **Swagger UI**: Documentación interactiva
- **pgAdmin/TablePlus**: Gestión de DB
- **Redis Commander**: Gestión de Redis

### Librerías Recomendadas (Node.js)
```json
{
  "express": "^4.18.0",
  "pg": "^8.11.0",
  "bcrypt": "^5.1.0",
  "jsonwebtoken": "^9.0.0",
  "multer": "^1.4.5-lts.1",
  "cloudinary": "^1.41.0",
  "redis": "^4.6.0",
  "helmet": "^7.1.0",
  "cors": "^2.8.5",
  "dotenv": "^16.3.0"
}
```

## ⚠️ Notas Importantes

1. **Datos de Ejemplo**: Los precios y dimensiones actuales están en 0 - necesitan valores reales
2. **Imágenes Placeholder**: Las URLs de Unsplash deben reemplazarse con imágenes reales
3. **Credenciales**: Nunca commitear credenciales reales al repositorio
4. **Rate Limiting**: Migrar de in-memory a Redis para producción
5. **HTTPS**: Usar siempre HTTPS en producción

## 🤝 Soporte

Para preguntas o problemas con la migración, contactar al equipo de desarrollo.

---

**Fecha de Exportación**: 2025-11-11  
**Versión del Frontend**: 0.1.0  
**Next.js**: 16.0.1
