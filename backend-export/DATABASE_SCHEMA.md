# Esquema de Base de Datos para Backend

## Diagrama Entidad-Relación

```
┌─────────────────┐
│    cabanas      │
├─────────────────┤
│ id (PK)         │
│ name            │
│ slug (UNIQUE)   │
│ description     │
│ area            │
│ bedrooms        │
│ bathrooms       │
│ floors          │
│ price_amount    │
│ price_currency  │
│ price_period    │
│ main_image      │
│ thumbnail       │
│ available       │
│ created_at      │
│ updated_at      │
└─────────────────┘
        │
        │ 1:N
        ▼
┌─────────────────────┐
│  cabana_features    │
├─────────────────────┤
│ id (PK)             │
│ cabana_id (FK)      │
│ feature             │
│ order_index         │
└─────────────────────┘

┌────────────────────────┐
│ cabana_specifications  │
├────────────────────────┤
│ id (PK)                │
│ cabana_id (FK)         │
│ label                  │
│ value                  │
│ order_index            │
└────────────────────────┘

┌──────────────────────┐
│  cabana_gallery      │
├──────────────────────┤
│ id (PK)              │
│ cabana_id (FK)       │
│ image_url            │
│ order_index          │
└──────────────────────┘

┌─────────────────────┐
│ company_features    │
├─────────────────────┤
│ id (PK)             │
│ title               │
│ subtitle            │
│ description         │
│ icon                │
│ order_index         │
│ active              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│    benefits         │
├─────────────────────┤
│ id (PK)             │
│ title               │
│ description         │
│ icon                │
│ details             │
│ order_index         │
│ active              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│  gallery_images     │
├─────────────────────┤
│ id (PK)             │
│ src                 │
│ alt                 │
│ category            │
│ width               │
│ height              │
│ thumbnail           │
│ order_index         │
│ active              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│   site_config       │
├─────────────────────┤
│ id (PK)             │
│ key (UNIQUE)        │
│ value (JSON)        │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│  social_links       │
├─────────────────────┤
│ id (PK)             │
│ platform            │
│ url                 │
│ label               │
│ icon                │
│ order_index         │
│ active              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│   navigation        │
├─────────────────────┤
│ id (PK)             │
│ label               │
│ href                │
│ order_index         │
│ external            │
│ active              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│ contact_messages    │
├─────────────────────┤
│ id (PK)             │
│ name                │
│ email               │
│ phone               │
│ message             │
│ preferred_model     │
│ ip_address          │
│ status              │
│ created_at          │
│ updated_at          │
└─────────────────────┘

┌─────────────────────┐
│   admin_users       │
├─────────────────────┤
│ id (PK)             │
│ username (UNIQUE)   │
│ email (UNIQUE)      │
│ password_hash       │
│ role                │
│ active              │
│ last_login          │
│ created_at          │
│ updated_at          │
└─────────────────────┘
```

## SQL - PostgreSQL

### Tabla: cabanas

```sql
CREATE TABLE cabanas (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    area DECIMAL(10, 2) DEFAULT 0,
    bedrooms INTEGER DEFAULT 0,
    bathrooms INTEGER DEFAULT 0,
    floors INTEGER DEFAULT 1,
    price_amount DECIMAL(10, 2) DEFAULT 0,
    price_currency VARCHAR(10) DEFAULT 'CLP',
    price_period VARCHAR(20) DEFAULT 'noche',
    main_image VARCHAR(500),
    thumbnail VARCHAR(500),
    available BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_cabanas_slug ON cabanas(slug);
CREATE INDEX idx_cabanas_available ON cabanas(available);
```

### Tabla: cabana_features

```sql
CREATE TABLE cabana_features (
    id SERIAL PRIMARY KEY,
    cabana_id VARCHAR(50) NOT NULL,
    feature VARCHAR(200) NOT NULL,
    order_index INTEGER DEFAULT 0,
    FOREIGN KEY (cabana_id) REFERENCES cabanas(id) ON DELETE CASCADE
);

CREATE INDEX idx_cabana_features_cabana ON cabana_features(cabana_id);
```

### Tabla: cabana_specifications

```sql
CREATE TABLE cabana_specifications (
    id SERIAL PRIMARY KEY,
    cabana_id VARCHAR(50) NOT NULL,
    label VARCHAR(100) NOT NULL,
    value VARCHAR(200) NOT NULL,
    order_index INTEGER DEFAULT 0,
    FOREIGN KEY (cabana_id) REFERENCES cabanas(id) ON DELETE CASCADE
);

CREATE INDEX idx_cabana_specs_cabana ON cabana_specifications(cabana_id);
```

### Tabla: cabana_gallery

```sql
CREATE TABLE cabana_gallery (
    id SERIAL PRIMARY KEY,
    cabana_id VARCHAR(50) NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    order_index INTEGER DEFAULT 0,
    FOREIGN KEY (cabana_id) REFERENCES cabanas(id) ON DELETE CASCADE
);

CREATE INDEX idx_cabana_gallery_cabana ON cabana_gallery(cabana_id);
```

### Tabla: company_features

```sql
CREATE TABLE company_features (
    id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    subtitle VARCHAR(100),
    description TEXT NOT NULL,
    icon VARCHAR(50),
    order_index INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tabla: benefits

```sql
CREATE TABLE benefits (
    id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(50),
    details TEXT,
    order_index INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tabla: gallery_images

```sql
CREATE TABLE gallery_images (
    id VARCHAR(50) PRIMARY KEY,
    src VARCHAR(500) NOT NULL,
    alt VARCHAR(200) NOT NULL,
    category VARCHAR(20) NOT NULL CHECK (category IN ('exterior', 'interior', 'amenities', 'landscape')),
    width INTEGER NOT NULL,
    height INTEGER NOT NULL,
    thumbnail VARCHAR(500),
    order_index INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_gallery_category ON gallery_images(category);
CREATE INDEX idx_gallery_active ON gallery_images(active);
```

### Tabla: site_config

```sql
CREATE TABLE site_config (
    id SERIAL PRIMARY KEY,
    key VARCHAR(100) UNIQUE NOT NULL,
    value JSONB NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar configuración inicial
INSERT INTO site_config (key, value) VALUES 
('site_info', '{"name": "Cabañas Coliumo - Tomé", "description": "", "url": ""}'),
('email_config', '{"from": "", "to": "", "subject": ""}'),
('rate_limit', '{"maxRequests": 3, "windowMs": 3600000}');
```

### Tabla: social_links

```sql
CREATE TABLE social_links (
    id VARCHAR(50) PRIMARY KEY,
    platform VARCHAR(20) NOT NULL CHECK (platform IN ('facebook', 'instagram', 'twitter', 'youtube', 'whatsapp', 'email')),
    url VARCHAR(500) NOT NULL,
    label VARCHAR(100) NOT NULL,
    icon VARCHAR(50),
    order_index INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tabla: navigation

```sql
CREATE TABLE navigation (
    id VARCHAR(50) PRIMARY KEY,
    label VARCHAR(50) NOT NULL,
    href VARCHAR(200) NOT NULL,
    order_index INTEGER DEFAULT 0,
    external BOOLEAN DEFAULT false,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tabla: contact_messages

```sql
CREATE TABLE contact_messages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    message TEXT NOT NULL,
    preferred_model VARCHAR(50),
    ip_address VARCHAR(45),
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'read', 'replied', 'archived')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_contact_status ON contact_messages(status);
CREATE INDEX idx_contact_created ON contact_messages(created_at);
```

### Tabla: admin_users

```sql
CREATE TABLE admin_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'admin' CHECK (role IN ('admin', 'super_admin')),
    active BOOLEAN DEFAULT true,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_admin_username ON admin_users(username);
CREATE INDEX idx_admin_email ON admin_users(email);
```

## SQL - MySQL

Similar al esquema PostgreSQL pero con las siguientes diferencias:

```sql
-- Usar AUTO_INCREMENT en lugar de SERIAL
-- Usar JSON en lugar de JSONB
-- Ajustar tipos de datos según MySQL
-- Usar VARCHAR(255) como límite máximo por defecto
```

## MongoDB (Alternativa NoSQL)

```javascript
// Colección: cabanas
{
  _id: ObjectId(),
  id: "modelo-uno",
  name: "Modelo Uno",
  slug: "modelo-uno",
  description: "...",
  dimensions: {
    area: 0,
    bedrooms: 0,
    bathrooms: 0,
    floors: 0
  },
  features: ["Piscina", "Cocina equipada", ...],
  price: {
    amount: 0,
    currency: "CLP",
    period: "noche"
  },
  images: {
    main: "...",
    gallery: ["...", "...", "..."],
    thumbnail: "..."
  },
  specifications: [
    { label: "...", value: "..." }
  ],
  available: true,
  createdAt: ISODate(),
  updatedAt: ISODate()
}

// Colección: companyFeatures
// Colección: benefits
// Colección: galleryImages
// Colección: siteConfig
// Colección: socialLinks
// Colección: navigation
// Colección: contactMessages
// Colección: adminUsers
```

## Índices Recomendados

### PostgreSQL

```sql
-- Índices de búsqueda
CREATE INDEX idx_cabanas_name ON cabanas(name);
CREATE INDEX idx_gallery_images_category ON gallery_images(category);

-- Índices de texto completo (para búsqueda)
CREATE INDEX idx_cabanas_description_fulltext ON cabanas USING GIN (to_tsvector('spanish', description));
CREATE INDEX idx_contact_messages_fulltext ON contact_messages USING GIN (to_tsvector('spanish', message));
```

## Triggers para updated_at

```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_cabanas_updated_at BEFORE UPDATE ON cabanas
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_company_features_updated_at BEFORE UPDATE ON company_features
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Repetir para todas las tablas con updated_at
```

## Consideraciones de Rendimiento

1. **Caché**: Implementar Redis para cachear datos que no cambian frecuentemente (cabañas, features, gallery)
2. **CDN**: Usar CDN para servir imágenes (Cloudinary, AWS CloudFront)
3. **Paginación**: Implementar paginación en endpoints que retornan múltiples registros
4. **Compresión**: Usar gzip/brotli para comprimir respuestas JSON
5. **Índices**: Mantener índices en columnas frecuentemente consultadas

## Scripts de Migración de Datos

Ver archivo `migration-scripts.sql` para scripts de inserción de datos iniciales desde los JSON exportados.
