# Documentación de Migración Frontend a Backend

## 📋 Resumen Ejecutivo

Este documento describe todos los datos y funcionalidades del frontend que deben ser migrados a un backend completo. Actualmente, la aplicación Next.js tiene datos hardcodeados que necesitan ser servidos desde una API REST.

## 🗄️ Datos a Extraer del Frontend

### 1. Modelos de Cabañas (`lib/data/cabanas.ts`)

**Cantidad de registros**: 3 modelos (Modelo Uno, Modelo Dos, Modelo Tres)

**Estructura de datos**:
```typescript
interface CabanaModel {
  id: string;                    // ID único
  name: string;                  // Nombre del modelo
  slug: string;                  // URL-friendly identifier
  description: string;           // Descripción larga
  dimensions: {
    area: number;                // m² (actualmente en 0)
    bedrooms: number;            // Cantidad de dormitorios
    bathrooms: number;           // Cantidad de baños
    floors: number;              // Cantidad de pisos
  };
  features: string[];            // Array de características
  price: {
    amount: number;              // Precio (actualmente en 0)
    currency: string;            // "CLP"
    period?: string;             // "noche"
  };
  images: {
    main: string;                // URL imagen principal
    gallery: string[];           // URLs galería (3 imágenes)
    thumbnail: string;           // URL thumbnail
  };
  specifications: {
    label: string;               // Etiqueta
    value: string;               // Valor
  }[];
  available: boolean;            // Disponibilidad
}
```

**Endpoints necesarios**:
- `GET /api/cabanas` - Listar todas las cabañas
- `GET /api/cabanas/:id` - Obtener cabaña por ID
- `GET /api/cabanas/slug/:slug` - Obtener cabaña por slug
- `POST /api/cabanas` - Crear nueva cabaña (admin)
- `PUT /api/cabanas/:id` - Actualizar cabaña (admin)
- `DELETE /api/cabanas/:id` - Eliminar cabaña (admin)

---

### 2. Características de la Empresa (`lib/data/features.ts`)

**Cantidad de registros**: 
- 3 características principales (companyFeatures)
- 6 beneficios (benefits)

**Estructura - Company Features**:
```typescript
interface CompanyFeature {
  id: string;
  title: string;                 // "HOSPITALIDAD", "WELLNESS", etc.
  subtitle: string;              // Subtítulo
  description: string;           // Descripción detallada
  icon: string;                  // Nombre del icono
}
```

**Estructura - Benefits**:
```typescript
interface Benefit {
  id: string;
  title: string;
  description: string;
  icon: string;
  details?: string;
}
```

**Endpoints necesarios**:
- `GET /api/features` - Obtener características de la empresa
- `GET /api/benefits` - Obtener beneficios
- `POST /api/features` - Crear feature (admin)
- `PUT /api/features/:id` - Actualizar feature (admin)
- `DELETE /api/features/:id` - Eliminar feature (admin)

---

### 3. Galería de Imágenes (`lib/data/gallery.ts`)

**Cantidad de registros**: 12 imágenes

**Estructura de datos**:
```typescript
interface GalleryImage {
  id: string;
  src: string;                   // URL de la imagen
  alt: string;                   // Texto alternativo
  category: 'exterior' | 'interior' | 'amenities' | 'landscape';
  width: number;                 // 1920
  height: number;                // 1280
  thumbnail?: string;            // URL thumbnail opcional
}
```

**Categorías**:
- exterior: 4 imágenes
- interior: 4 imágenes
- amenities: 2 imágenes
- landscape: 2 imágenes

**Endpoints necesarios**:
- `GET /api/gallery` - Listar todas las imágenes
- `GET /api/gallery?category=exterior` - Filtrar por categoría
- `POST /api/gallery` - Subir nueva imagen (admin)
- `DELETE /api/gallery/:id` - Eliminar imagen (admin)

---

### 4. Configuración del Sitio (`lib/config/site.ts`)

**Estructura de datos**:
```typescript
interface SiteConfig {
  name: string;
  description: string;
  url: string;
  ogImage: string;
  keywords: string[];
  author: {
    name: string;
    email: string;
  };
  social: SocialLink[];
}

interface SocialLink {
  id: string;
  platform: 'facebook' | 'instagram' | 'twitter' | 'youtube' | 'whatsapp' | 'email';
  url: string;
  label: string;
  icon: string;
}
```

**Navegación**:
```typescript
interface NavItem {
  id: string;
  label: string;
  href: string;
  external?: boolean;
}
```

**Endpoints necesarios**:
- `GET /api/config/site` - Obtener configuración general
- `GET /api/config/navigation` - Obtener items de navegación
- `PUT /api/config/site` - Actualizar configuración (admin)

---

## 🔌 API Existente a Mantener

### Endpoint de Contacto (`app/api/contact/route.ts`)

**Método**: `POST /api/contact`

**Validación**: Usando Zod schema

**Request Body**:
```typescript
interface ContactFormData {
  name: string;                  // 2-100 chars, solo letras
  email: string;                 // Email válido, 5-100 chars
  phone: string;                 // 10-20 chars, formato telefónico
  message: string;               // 10-1000 chars
  preferredModel?: string;       // Opcional
  privacyAccepted: boolean;      // Debe ser true
}
```

**Características implementadas**:
- ✅ Rate limiting (3 requests por hora por IP)
- ✅ Validación con Zod
- ✅ Envío de email con Nodemailer
- ✅ HTML template para emails
- ✅ Manejo de errores

**Variables de entorno requeridas**:
```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=tu-email@gmail.com
SMTP_PASS=tu-contraseña-de-aplicación
EMAIL_FROM=noreply@ejemplo.cl
EMAIL_TO=contacto@ejemplo.cl
```

---

## 📊 Resumen de Endpoints Necesarios

### Endpoints Públicos (Frontend)
```
GET    /api/cabanas              - Listar cabañas
GET    /api/cabanas/:id          - Obtener cabaña por ID
GET    /api/cabanas/slug/:slug   - Obtener cabaña por slug
GET    /api/features             - Obtener características
GET    /api/benefits             - Obtener beneficios
GET    /api/gallery              - Listar imágenes galería
GET    /api/gallery?category=X   - Filtrar galería por categoría
GET    /api/config/site          - Configuración general
GET    /api/config/navigation    - Items de navegación
POST   /api/contact              - Enviar formulario contacto [YA EXISTE]
```

### Endpoints de Administración
```
POST   /api/auth/login           - Login de administrador
POST   /api/auth/logout          - Logout

POST   /api/cabanas              - Crear cabaña
PUT    /api/cabanas/:id          - Actualizar cabaña
DELETE /api/cabanas/:id          - Eliminar cabaña

POST   /api/features             - Crear característica
PUT    /api/features/:id         - Actualizar característica
DELETE /api/features/:id         - Eliminar característica

POST   /api/gallery              - Subir imagen
DELETE /api/gallery/:id          - Eliminar imagen

PUT    /api/config/site          - Actualizar configuración
```

---

## 🔐 Seguridad y Validación

### Schemas de Validación Existentes

**Contact Form** (`lib/utils/validation.ts`):
```typescript
contactFormSchema = z.object({
  name: z.string().min(2).max(100).regex(/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/),
  email: z.string().email().min(5).max(100).toLowerCase().trim(),
  phone: z.string().min(10).max(20).regex(/^[\d\s\-\+\(\)]+$/),
  message: z.string().min(10).max(1000).trim(),
  preferredModel: z.string().optional(),
  privacyAccepted: z.boolean().refine((val) => val === true),
});
```

### Rate Limiting Configurado
```typescript
rateLimitConfig = {
  maxRequests: 3,
  windowMs: 60 * 60 * 1000, // 1 hora
}
```

**Nota**: En producción se recomienda usar Redis para rate limiting distribuido.

---

## 🗂️ Archivos de Datos a Exportar

### Ubicaciones en el proyecto:
```
/lib/data/
  ├── cabanas.ts       → Datos de cabañas (3 modelos)
  ├── features.ts      → Características y beneficios
  └── gallery.ts       → Imágenes de galería (12 items)

/lib/config/
  └── site.ts          → Configuración general y navegación

/lib/utils/
  └── validation.ts    → Schemas de validación Zod

/types/
  └── index.ts         → Definiciones TypeScript
```

---

## 📦 Datos en Formato JSON

### Archivo: `cabanas-data.json`
Ver datos completos en `/backend-export/cabanas-data.json`

### Archivo: `features-data.json`
Ver datos completos en `/backend-export/features-data.json`

### Archivo: `gallery-data.json`
Ver datos completos en `/backend-export/gallery-data.json`

### Archivo: `config-data.json`
Ver datos completos en `/backend-export/config-data.json`

---

## 🛠️ Stack Tecnológico del Frontend

- **Framework**: Next.js 16.0.1 (App Router)
- **Lenguaje**: TypeScript 5
- **UI**: Tailwind CSS 4
- **Animaciones**: Framer Motion 12.23.24
- **Formularios**: React Hook Form 7.66.0
- **Validación**: Zod 4.1.12
- **Email**: Nodemailer 7.0.10
- **Iconos**: Lucide React 0.553.0

---

## 🚀 Próximos Pasos Recomendados

1. **Crear Base de Datos**
   - PostgreSQL o MySQL para datos estructurados
   - Tablas: cabanas, features, benefits, gallery_images, site_config

2. **Implementar Backend API**
   - Node.js + Express / Fastify
   - O utilizar Next.js API Routes (ya configurado)
   - O un backend separado (Django, Laravel, etc.)

3. **Sistema de Autenticación**
   - JWT para endpoints de administración
   - NextAuth.js o similar

4. **Upload de Imágenes**
   - Cloudinary, AWS S3, o almacenamiento local
   - Optimización y resize automático

5. **CMS/Admin Panel**
   - Panel de administración para gestionar contenido
   - CRUD completo para todos los recursos

6. **Migración de Datos**
   - Scripts de migración usando los JSON exportados
   - Seeders para datos iniciales

---

## 📝 Notas Importantes

- Los precios actuales están en `0` - necesitan ser configurados
- Las dimensiones de las cabañas están en `0` - necesitan datos reales
- Las imágenes usan Unsplash (placeholder) - reemplazar con imágenes reales
- El email de contacto necesita credenciales SMTP configuradas
- Rate limiting actual es in-memory - usar Redis en producción

---

## 📧 Contacto y Soporte

Para consultas sobre la migración, contactar al equipo de desarrollo.
