# Proyecto Final IA Generativa - Renato Gates

## Descripción del Proyecto
En organizaciones que realizan recolección de datos a gran escala, como Innovations for Poverty Action (IPA) lugar donde por ahora laboro, el proceso de auditoría de calidad de la información implica revisar manualmente cientos de comentarios dejados por auditores de campo. Muchos de estos comentarios son redundantes ("todo ok", "buen trabajo"), mientras que otros contienen alertas críticas sobre posibles errores o manipulación de encuestas.

Este proyecto propone automatizar el procesamiento y clasificaciónde comentarios de auditoría mediante herramientas de IA Generativa y procesamiento de lenguaje natural (NLP), reduciendo el tiempo de revisión y mejorando la detección de observaciones relevantes.

## Propuesta de Mejora del Flujo de Trabajo

Actualmente:
El auditor deja comentario en un formulario de SurveyCTO -> el equipo descarga reporte -> el equipo lee comentario por comentario manualmente -> Identifica alertas

**Flujo propuesto:**
El auditor deja comentario en el formulario de SurveyCTO → Se realiza las descargas de manera automática -> Script de clasificación NLP → Dashboard con alertas priorizadas -> Chatbot para consultas específicas por encuestador o problemas en general en base a los comentarios de los auditores.

## Herramientas de IA Generativa

Para la clasificación de comentarios de auditoría y detección de patrones se utilizarán herramientas de IA Generativa basadas en modelos de lenguaje natural, los cuales evaluarán cada comentario para determinar si requiere atención del equipo o puede descartarse como rutinario. Adicionalmente, se construirá un chatbot que permitirá al equipo hacer preguntas en lenguaje natural sobre el estado de las auditorías, como qué encuestador tuvo más errores o si hubo alertas en alguna región entre otro. Finalmente, se emplearán estas mismas herramientas para generar resúmenes ejecutivos automáticos del reporte de auditoría por proyecto.

## Elementos de Programación

**Manejo de bases de datos**
- Lectura de exports de SurveyCTO en formato CSV/Excel con `pandas`
- Filtrado y cruce de bases por proyecto, encuestador y fecha
- Librerías: `pandas`, `openpyxl`

**Procesamiento de lenguaje natural**
- Clasificación de comentarios usando prompts estructurados
- Estrategias de prompt para distinguir comentarios críticos de rutinarios

**Gráficos y visualización**
- Dashboard de auditoría con frecuencia de alertas por encuestador, proyecto y fecha
- Librerías: `matplotlib`, `seaborn`, `plotly`

**Web scraping**
- Consulta automatizada al portal de SUNAT para verificación de empresas en muestras de proyectos con RUCs registrados
- Librerías: `selenium`, `webdriver-manager`
- Al final, la idea es contar con un repositorio de uso del equipo de IPA en Lima, porque muchos webscrapeos ya se hicieron en otro proyecto y otro equipo lo vuelve a hacer perdiendo tiempo

