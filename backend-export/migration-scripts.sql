-- ============================================
-- Script de Migración de Datos - Cabañas App
-- ============================================
-- Este script inserta los datos iniciales del frontend en la base de datos
-- Basado en los archivos JSON exportados

-- ============================================
-- 1. INSERTAR CABAÑAS
-- ============================================

-- Modelo Uno
INSERT INTO cabanas (id, name, slug, description, area, bedrooms, bathrooms, floors, 
                     price_amount, price_currency, price_period, 
                     main_image, thumbnail, available) 
VALUES (
    'modelo-uno',
    'Modelo Uno',
    'modelo-uno',
    'Cabaña de ejemplo con espacio amplio y confortable. Diseño pensado para familias que buscan descanso cerca de la naturaleza.',
    0,
    0,
    0,
    0,
    0,
    'CLP',
    'noche',
    'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=1600&q=80',
    'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=600&q=80',
    true
);

-- Features para Modelo Uno
INSERT INTO cabana_features (cabana_id, feature, order_index) VALUES
    ('modelo-uno', 'Piscina', 0),
    ('modelo-uno', 'Cocina equipada', 1),
    ('modelo-uno', 'Vista panorámica', 2),
    ('modelo-uno', 'Zona de fogata', 3),
    ('modelo-uno', 'Estacionamiento', 4);

-- Especificaciones para Modelo Uno
INSERT INTO cabana_specifications (cabana_id, label, value, order_index) VALUES
    ('modelo-uno', 'Características', 'Piscina', 0),
    ('modelo-uno', 'Espacios', 'Cocina equipada', 1),
    ('modelo-uno', 'Vistas', 'Vista al mar', 2),
    ('modelo-uno', 'Servicios', 'Estacionamiento', 3),
    ('modelo-uno', 'Ubicación', 'Coliumo, Tomé', 4);

-- Galería para Modelo Uno
INSERT INTO cabana_gallery (cabana_id, image_url, order_index) VALUES
    ('modelo-uno', 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=1600&q=80', 0),
    ('modelo-uno', 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=1600&q=80', 1),
    ('modelo-uno', 'https://images.unsplash.com/photo-1505691723518-36a5ac3be353?w=1600&q=80', 2);

-- Modelo Dos
INSERT INTO cabanas (id, name, slug, description, area, bedrooms, bathrooms, floors, 
                     price_amount, price_currency, price_period, 
                     main_image, thumbnail, available) 
VALUES (
    'modelo-dos',
    'Modelo Dos',
    'modelo-dos',
    'Cabaña de ejemplo ideal para parejas o grupos pequeños. Ambiente acogedor con todas las comodidades básicas.',
    0,
    0,
    0,
    0,
    0,
    'CLP',
    'noche',
    'https://images.unsplash.com/photo-1470240731273-7821a6eeb6bd?w=1600&q=80',
    'https://images.unsplash.com/photo-1470240731273-7821a6eeb6bd?w=600&q=80',
    true
);

-- Features para Modelo Dos
INSERT INTO cabana_features (cabana_id, feature, order_index) VALUES
    ('modelo-dos', 'Jacuzzi', 0),
    ('modelo-dos', 'Cocina equipada', 1),
    ('modelo-dos', 'Vista al bosque', 2),
    ('modelo-dos', 'Terraza privada', 3),
    ('modelo-dos', 'WiFi', 4);

-- Especificaciones para Modelo Dos
INSERT INTO cabana_specifications (cabana_id, label, value, order_index) VALUES
    ('modelo-dos', 'Características', 'Jacuzzi', 0),
    ('modelo-dos', 'Espacios', 'Terraza privada', 1),
    ('modelo-dos', 'Vistas', 'Vista al bosque', 2),
    ('modelo-dos', 'Servicios', 'WiFi incluido', 3),
    ('modelo-dos', 'Ubicación', 'Coliumo, Tomé', 4);

-- Galería para Modelo Dos
INSERT INTO cabana_gallery (cabana_id, image_url, order_index) VALUES
    ('modelo-dos', 'https://images.unsplash.com/photo-1470240731273-7821a6eeb6bd?w=1600&q=80', 0),
    ('modelo-dos', 'https://images.unsplash.com/photo-1464146072230-91cabc968266?w=1600&q=80', 1),
    ('modelo-dos', 'https://images.unsplash.com/photo-1501127122-f385ca6ddd3c?w=1600&q=80', 2);

-- Modelo Tres
INSERT INTO cabanas (id, name, slug, description, area, bedrooms, bathrooms, floors, 
                     price_amount, price_currency, price_period, 
                     main_image, thumbnail, available) 
VALUES (
    'modelo-tres',
    'Modelo Tres',
    'modelo-tres',
    'Cabaña de ejemplo rodeada de naturaleza. Perfecta para quienes buscan tranquilidad y conexión con el entorno.',
    0,
    0,
    0,
    0,
    0,
    'CLP',
    'noche',
    'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=1600&q=80',
    'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=600&q=80',
    true
);

-- Features para Modelo Tres
INSERT INTO cabana_features (cabana_id, feature, order_index) VALUES
    ('modelo-tres', 'Chimenea', 0),
    ('modelo-tres', 'Cocina equipada', 1),
    ('modelo-tres', 'Vista panorámica', 2),
    ('modelo-tres', 'Zona exterior', 3),
    ('modelo-tres', 'Estacionamiento', 4);

-- Especificaciones para Modelo Tres
INSERT INTO cabana_specifications (cabana_id, label, value, order_index) VALUES
    ('modelo-tres', 'Características', 'Chimenea', 0),
    ('modelo-tres', 'Espacios', 'Zona exterior', 1),
    ('modelo-tres', 'Vistas', 'Vista panorámica', 2),
    ('modelo-tres', 'Servicios', 'Estacionamiento', 3),
    ('modelo-tres', 'Ubicación', 'Coliumo, Tomé', 4);

-- Galería para Modelo Tres
INSERT INTO cabana_gallery (cabana_id, image_url, order_index) VALUES
    ('modelo-tres', 'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=1600&q=80', 0),
    ('modelo-tres', 'https://images.unsplash.com/photo-1505692989983-2e8d8fc7b3c1?w=1600&q=80', 1),
    ('modelo-tres', 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=1600&q=80', 2);

-- ============================================
-- 2. INSERTAR CARACTERÍSTICAS DE LA EMPRESA
-- ============================================

INSERT INTO company_features (id, title, subtitle, description, icon, order_index) VALUES
    ('hospitalidad', 'HOSPITALIDAD', 'ANFITRIÓN 24/7', 
     'Equipo en Coliumo que coordina check-in asistido, traslados, experiencias y soporte durante toda tu estadía.',
     'heart', 0),
    ('wellness', 'WELLNESS', 'PISCINA & SPA',
     'Piscinas temperadas, jacuzzis privados y sauna escandinavo con mantenciones diarias para un descanso perfecto.',
     'zap', 1),
    ('conectividad', 'CONECTIVIDAD', 'WORKATION READY',
     'WiFi 500 Mbps, escritorios ergonómicos y streaming premium para combinar teletrabajo con descanso frente al mar.',
     'dollar-sign', 2);

-- ============================================
-- 3. INSERTAR BENEFICIOS
-- ============================================

INSERT INTO benefits (id, title, description, icon, details, order_index) VALUES
    ('atencion', 'ATENCIÓN AL CLIENTE',
     'Soporte disponible para coordinar tu estadía y resolver consultas durante tu visita.',
     'home', 'Servicio de atención básico.', 0),
    ('piscina', 'PISCINA',
     'Acceso a piscina para disfrutar durante los días de verano y clima favorable.',
     'shield-check', 'Disponible según temporada.', 1),
    ('cocina', 'COCINA EQUIPADA',
     'Espacios de cocina con implementos básicos para preparar tus propias comidas.',
     'tag', 'Equipamiento estándar incluido.', 2),
    ('exterior', 'ESPACIOS EXTERIORES',
     'Áreas al aire libre para disfrutar del entorno natural y compartir con familia o amigos.',
     'pencil-ruler', 'Terrazas y jardines disponibles.', 3),
    ('estacionamiento', 'ESTACIONAMIENTO',
     'Espacio designado para estacionar tu vehículo de forma segura durante tu estadía.',
     'shield-check', 'Incluido en la reserva.', 4),
    ('ubicacion', 'UBICACIÓN PRIVILEGIADA',
     'Situadas en Coliumo, sector costero de Tomé, con fácil acceso desde la ruta principal.',
     'calendar-check', 'A minutos de playas locales.', 5);

-- ============================================
-- 4. INSERTAR GALERÍA DE IMÁGENES
-- ============================================

-- Exteriores
INSERT INTO gallery_images (id, src, alt, category, width, height, order_index) VALUES
    ('ext-1', 'https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=1920&q=80',
     'Vista exterior nocturna de cabaña modular en el bosque', 'exterior', 1920, 1280, 0),
    ('ext-2', 'https://images.unsplash.com/photo-1602941525421-8f8b81d3edbb?w=1920&q=80',
     'Fachada principal con terraza perimetral y fogón central', 'exterior', 1920, 1280, 1),
    ('ext-3', 'https://images.unsplash.com/photo-1587061949409-02df41d5e562?w=1920&q=80',
     'Cabaña tipo A-Frame iluminada al atardecer', 'exterior', 1920, 1280, 2),
    ('ext-4', 'https://images.unsplash.com/photo-1542718610-a1d656d1884c?w=1920&q=80',
     'Modelo modular con deck elevado y celosías de madera', 'exterior', 1920, 1280, 3);

-- Interiores
INSERT INTO gallery_images (id, src, alt, category, width, height, order_index) VALUES
    ('int-1', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?w=1920&q=80',
     'Sala de estar con doble altura y ventanales panorámicos', 'interior', 1920, 1280, 4),
    ('int-2', 'https://images.unsplash.com/photo-1556909212-d5b604d0c90d?w=1920&q=80',
     'Cocina minimalista con isla central y acabados en madera', 'interior', 1920, 1280, 5),
    ('int-3', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=1920&q=80',
     'Dormitorio principal con textiles cálidos y vista al bosque', 'interior', 1920, 1280, 6),
    ('int-4', 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=1920&q=80',
     'Baño completo con revestimientos pétreos y luz natural', 'interior', 1920, 1280, 7);

-- Amenidades
INSERT INTO gallery_images (id, src, alt, category, width, height, order_index) VALUES
    ('ame-1', 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=1920&q=80',
     'Terraza exterior con mobiliario y pérgola de madera', 'amenities', 1920, 1280, 8),
    ('ame-2', 'https://images.unsplash.com/photo-1470252649378-9c29740c9fa8?w=1920&q=80',
     'Zona de fogata con horizonte montañoso', 'amenities', 1920, 1280, 9);

-- Paisajes
INSERT INTO gallery_images (id, src, alt, category, width, height, order_index) VALUES
    ('lan-1', 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=1920&q=80',
     'Entorno natural con laguna frente a las cabañas', 'landscape', 1920, 1280, 10),
    ('lan-2', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&q=80',
     'Vista panorámica de complejo modular en la montaña', 'landscape', 1920, 1280, 11);

-- ============================================
-- 5. INSERTAR CONFIGURACIÓN DEL SITIO
-- ============================================

INSERT INTO site_config (key, value) VALUES
    ('site_info', '{
        "name": "Cabañas Coliumo - Tomé",
        "description": "Sitio de ejemplo para visualización de diseño. Cabañas ubicadas en Coliumo, sector costero de la comuna de Tomé. Tres modelos disponibles para conocer el formato del sitio.",
        "url": "https://ejemplo-cabanas.cl",
        "ogImage": "/images/og-image.jpg",
        "keywords": ["cabañas tomé", "cabañas coliumo", "arriendo cabañas", "turismo tomé", "coliumo", "cabañas costa", "ejemplo sitio web", "demo cabañas"],
        "author": {
            "name": "Cabañas Coliumo",
            "email": "contacto@ejemplo.cl"
        }
    }'),
    ('email_config', '{
        "from": "noreply@ejemplo.cl",
        "to": "contacto@ejemplo.cl",
        "subject": "Nueva consulta - Cabañas Coliumo"
    }'),
    ('rate_limit', '{
        "maxRequests": 3,
        "windowMs": 3600000
    }');

-- ============================================
-- 6. INSERTAR REDES SOCIALES
-- ============================================

INSERT INTO social_links (id, platform, url, label, icon, order_index) VALUES
    ('facebook', 'facebook', 'https://facebook.com/ejemplo', 'Síguenos en Facebook', 'facebook', 0),
    ('instagram', 'instagram', 'https://instagram.com/ejemplo', 'Síguenos en Instagram', 'instagram', 1),
    ('whatsapp', 'whatsapp', 'https://wa.me/56900000000', 'Escríbenos por WhatsApp', 'message-circle', 2),
    ('email', 'email', 'mailto:contacto@ejemplo.cl', 'Envíanos un email', 'mail', 3);

-- ============================================
-- 7. INSERTAR NAVEGACIÓN
-- ============================================

INSERT INTO navigation (id, label, href, order_index, external) VALUES
    ('inicio', 'Inicio', '#hero', 0, false),
    ('nosotros', 'Nosotros', '#about', 1, false),
    ('modelos', 'Modelos', '#models', 2, false),
    ('galeria', 'Galería', '#gallery', 3, false),
    ('ubicacion', 'Ubicación', '#location', 4, false),
    ('contacto', 'Contacto', '#contact', 5, false);

-- ============================================
-- 8. CREAR USUARIO ADMINISTRADOR INICIAL
-- ============================================
-- NOTA: Cambiar la contraseña después del primer login
-- Password: admin123 (hasheado con bcrypt)

INSERT INTO admin_users (username, email, password_hash, role) VALUES
    ('admin', 'admin@ejemplo.cl', '$2b$10$rBV2NDeWWx.QKRRl3gHkqO1Xh2Yz9.1.1Y8vZqPxK9Rn2QxKCZW7G', 'super_admin');

-- ============================================
-- VERIFICACIÓN DE DATOS INSERTADOS
-- ============================================

SELECT 'Cabañas insertadas:' as verificacion, COUNT(*) as total FROM cabanas;
SELECT 'Features de empresa:' as verificacion, COUNT(*) as total FROM company_features;
SELECT 'Beneficios:' as verificacion, COUNT(*) as total FROM benefits;
SELECT 'Imágenes de galería:' as verificacion, COUNT(*) as total FROM gallery_images;
SELECT 'Enlaces sociales:' as verificacion, COUNT(*) as total FROM social_links;
SELECT 'Items de navegación:' as verificacion, COUNT(*) as total FROM navigation;

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
