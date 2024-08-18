from django.shortcuts import render
from .serializers import CategoriaSerializer
from rest_framework import generics
from .models import *

# Create your views here.

class CategoriaAddView(generics.CreateAPIView):
    queryset = est_m_categoria.objects.all()
    serializer_class = CategoriaSerializer

class CategoriaView(generics.ListAPIView):
    queryset = est_m_categoria.objects.all()
    serializer_class = CategoriaSerializer

from django.db import connection
from django.http import JsonResponse
cursor = connection.cursor()
def pa_gCategorias(req):
    with connection.cursor() as cursor:
        cursor.execute('call pa_gCategorias()')
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'es_codigo': row[2],
            'ca_imagen': row[3],
        })

    return JsonResponse(categorias, safe=False)

def pa_cCategorias(request):
    # Obtén los parámetros desde la URL
    ca_codigo = request.GET.get('ca_codigo', -1)
    ca_nombre = request.GET.get('ca_nombre', '')

    with connection.cursor() as cursor:
        # Ejecuta el procedimiento almacenado con los parámetros
        cursor.execute('call pa_cCategorias(%s, %s)', [ca_codigo, ca_nombre])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'es_codigo': row[2],
            'ca_imagen': row[3],
        })

    return JsonResponse(categorias, safe=False)


from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
import json

@csrf_exempt
@require_POST
def login(request):
    # Obtén los parámetros desde la URL
    data = json.loads(request.body.decode('utf-8'))
    us_cedula = data.get('us_cedula')
    us_clave = data.get('us_clave')

    if not us_cedula or not us_clave:
            return JsonResponse({
                'codigo_error': 3,
                'mensaje': 'Parámetros faltantes'
            }, status=400)

    with connection.cursor() as cursor:
        # Ejecuta el procedimiento almacenado con los parámetros
        cursor.execute('call pa_login(%s, %s)', [us_cedula, us_clave])
        result = cursor.fetchall()

    if result:
        row = result[0]
        codigo_error = row[0]

        if codigo_error == -1:
            # Si el código de error es -1, devolver un JSON con el código de error y el mensaje
            return JsonResponse({
                'codigo_error': 1,
                'mensaje': 'Usuario no encontrado'
            })

        else:
            return JsonResponse({
                'us_codigo': row[0],
                'us_cedula': row[1],
                'us_nombre': row[2],
                'us_apellido': row[3],
                'us_correo': row[4],
                'us_telefono': row[5],
                'ro_codigo': row[6]
            })

    # En caso de que no haya resultados, también manejar el caso de error
    return JsonResponse({
        'codigo_error': 2,
        'mensaje': 'Clave incorrecta'
    })

def pa_cServicios(request):
    # Obtén los parámetros desde la URL
    se_codigo = request.GET.get('se_codigo', -1)
    ca_codigo = request.GET.get('ca_codigo', 0)

    with connection.cursor() as cursor:
        cursor.execute('call pa_cServicios(%s, %s)', [se_codigo, ca_codigo])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'se_codigo': row[0],
            'se_nombre': row[1],
            'se_descripcion': row[2],
            'se_duracion': row[3],
            'se_precio': row[4],
            'ca_codigo_id': row[5],
        })

    return JsonResponse(categorias, safe=False)

def pa_cEmpleadosXServicio(request):
    # Obtén los parámetros desde la URL
    se_codigo = request.GET.get('se_codigo', 0)

    with connection.cursor() as cursor:
        cursor.execute('call pa_cEmpleadoxServicio(%s)', [se_codigo])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'em_nombre': row[0],
            'em_codigo': row[1],
            'us_codigo': row[2],
            'em_especialidad': row[3],
            'em_hora_entrada': row[4],
            'em_hora_salida': row[5],
            'em_imagen': row[6],
        })

    return JsonResponse(categorias, safe=False)

def pa_horariosXFecha(request):
    # Obtén los parámetros desde la URL
    e_fecha = request.GET.get('e_fecha'),
    e_empleado = request.GET.get('e_empleado'),

    with connection.cursor() as cursor:
        cursor.execute('call pa_horariosXFecha(%s,%s)', [e_fecha, e_empleado])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'hora': row[0],
            'ci_hora': row[1],
            'em_codigo': row[2]
        })

    return JsonResponse(categorias, safe=False)

import logging
logger = logging.getLogger(__name__)

@csrf_exempt
@require_POST
def pa_agendarCita(request):
    
    data = json.loads(request.body.decode('utf-8'))
    e_fecha = data.get('e_fecha')
    e_hora = data.get('e_hora')
    e_empleado = data.get('e_empleado')
    e_cliente = data.get('e_cliente')
    e_servicio = data.get('e_servicio')
    logger.info('Este es un mensaje informativo')
    logger.info(e_fecha)
    logger.info(e_hora)
    logger.info(e_empleado)
    logger.info(e_cliente)
    logger.info(e_servicio)

    if not e_fecha or not e_fecha or not e_hora or not e_empleado or not e_cliente or not e_servicio:
        return JsonResponse({
            'codigo_error': 88,
            'mensaje': 'Parámetros faltantes'
        }, status=400)

    with connection.cursor() as cursor:
        cursor.execute('call agendarCita(%s, %s, %s, %s, %s)', [e_fecha, e_hora, e_empleado, e_cliente, e_servicio])
        result = cursor.fetchall()

    if result:
        row = result[0]
        codigo_error = row[0]
        return JsonResponse({
            'codigo_error': row[0],
            'mensaje': row[1]
        })

    # En caso de que no haya resultados, también manejar el caso de error
    return JsonResponse({
        'codigo_error': 2,
        'mensaje': 'Agenda no guardada'
    })

from django.core.mail import send_mail
from django.http import HttpResponse
from django.conf import settings

def enviar_correo(request):
    e_cita = request.GET.get('e_cita')
    mensaje = ''
    correo = ''

    with connection.cursor() as cursor:
        cursor.execute('call pa_creaCorreo(%s)', [e_cita])
        result = cursor.fetchall()

    if result:
        row = result[0]
        mensaje = row[0]
        correo = row [1]

    subject = 'Estetica Antnella - AGENDA'
    message = mensaje
    from_email = settings.DEFAULT_FROM_EMAIL
    recipient_list = ['webadasdeanfibius@gmail.com']
    send_mail(subject, message, from_email, recipient_list)

    return JsonResponse({
        'codigo_error': 0,
        'mensaje': 'Correo Enviado ' + mensaje + " - " + correo
    })

def pa_getHistorial(request):
    # Obtén los parámetros desde la URL
    e_usuario = request.GET.get('e_usuario')
    e_tipo = request.GET.get('e_tipo')
    e_cliemp = request.GET.get('e_cliemp')

    with connection.cursor() as cursor:
        # Ejecuta el procedimiento almacenado con los parámetros
        cursor.execute('call pa_getHistorial(%s, %s, %s)', [e_usuario, e_tipo, e_cliemp])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'codigo_cita': row[0],
            'hora_cita': row[1],
            'codigo_servicio': row[2],
            'codigo_nombre': row[3],
            'duracion': row[4],
            'codigo_estado': row[5],
            'estado': row[6],
            'cliente': row[7],
            'empleado': row[8],
            'ci_fecha': row[9],
            'fecha_hora': row[10]
        })

    return JsonResponse(categorias, safe=False)

def pa_cancelarCita(request):
    e_cita = request.GET.get('e_cita')

    with connection.cursor() as cursor:
        cursor.execute('call pa_cancelaCita(%s)', [e_cita])
        result = cursor.fetchall()

    return JsonResponse({
        'codigo_error': 0,
        'mensaje': 'Cita Cancelada'
    })

from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from io import BytesIO
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib.colors import HexColor
from io import BytesIO

def generate_pdf(request):
    buffer = BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter

    p.drawString(100, height - 100, "Hello, this is a PDF generated with ReportLab!")
    p.save()

    buffer.seek(0)
    return HttpResponse(buffer, content_type='application/pdf')

from reportlab.lib.units import inch
from django.http import HttpResponse
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph
from reportlab.lib.units import inch
from reportlab.lib.colors import HexColor
from reportlab.lib.styles import getSampleStyleSheet
from io import BytesIO
from datetime import datetime
def prueba_pdf(request):
    e_categoria = request.GET.get('e_categoria')
    e_servicio = request.GET.get('e_servicio')
    e_fecha_inicio = request.GET.get('e_fecha_inicio')
    e_fecha_fin = request.GET.get('e_fecha_fin')

    with connection.cursor() as cursor:
        cursor.execute('call pa_generaPdfEsp(%s, %s, %s, %s)', [e_categoria, e_servicio, e_fecha_inicio, e_fecha_fin])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'se_codigo': row[2],
            'se_nombre': row[3],
            'ci_fecha': row[4],
            'ci_hora': row[5],
            'cliente': row[6],
            'empleado': row[7],
            'ci_estado': row[8],
            'estado_des': row[9]
        })
    
    if categorias:
        first_record = categorias[0]
        categoria_pdf = first_record["ca_nombre"]
        servicio_pdf = first_record["se_nombre"]

    table_data = [["Categoria", "Servicio", "Fecha", "Hora", "Ciente", "Empleado", "Estado"]]  # Encabezados
    for item in categorias:
        table_data.append([item["ca_nombre"], item["se_nombre"], item["ci_fecha"], item["ci_hora"], item["cliente"], item["empleado"], item["estado_des"]])

    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=landscape(letter))
    elements = []

    styles = getSampleStyleSheet()
    title_style = styles['Title']
    normal_style = styles['Normal']

    today = datetime.now().strftime('%d de %B de %Y')
    date_paragraph = Paragraph(f"Fecha: {today}", normal_style)
    elements.append(date_paragraph)

    title = Paragraph('HISTORIAL DE AGENDA', title_style)
    elements.append(title)
    elements.append(Paragraph("<br/><br/>", normal_style))

    categoria_Par = Paragraph('Categoria:  ' + categoria_pdf, title_style)
    elements.append(categoria_Par)
    servicio_Par = Paragraph('Servicio:  ' + servicio_pdf, title_style)
    elements.append(servicio_Par)
    elements.append(Paragraph("<br/>", normal_style))

    table = Table(table_data, colWidths=[1*inch, 2*inch, 1*inch, 1*inch, 2*inch, 2*inch, 1*inch])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), HexColor('#CCCCCC')),
        ('TEXTCOLOR', (0, 0), (-1, 0), HexColor('#000000')),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), HexColor('#F5F5F5')),
        ('GRID', (0, 0), (-1, -1), 1, HexColor('#000000')),
    ]))
    elements.append(table)

    doc.build(elements)
    buffer.seek(0)

    with open('generated_report.pdf', 'wb') as f:
        f.write(buffer.getvalue())
        
    return HttpResponse(buffer, content_type='application/pdf')

def prueba_pdf1(request):
    e_fecha_inicio = request.GET.get('e_fecha_inicio')
    e_fecha_fin = request.GET.get('e_fecha_fin')

    with connection.cursor() as cursor:
        # Ejecuta el procedimiento almacenado con los parámetros
        cursor.execute('call pa_generaPdfTodo(%s, %s)', [e_fecha_inicio, e_fecha_fin])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'se_codigo': row[2],
            'se_nombre': row[3],
            'ci_fecha': row[4],
            'ci_hora': row[5],
            'cliente': row[6],
            'empleado': row[7],
            'ci_estado': row[8],
            'estado_des': row[9]
        })
    
    if categorias:
        first_record = categorias[0]
        categoria_pdf = first_record["ca_nombre"]
        servicio_pdf = first_record["se_nombre"]
        empleado_pdf = first_record["empleado"]
    else:
        header_name = "Desconocido"
        header_age = "Desconocido"
        header_city = "Desconocido"

    # Convertir los datos a un formato adecuado para ReportLab
    table_data = [["Categoria", "Servicio", "Fecha", "Hora", "Ciente", "Empleado", "Estado"]]  # Encabezados
    for item in categorias:
        table_data.append([item["ca_nombre"], item["se_nombre"], item["ci_fecha"], item["ci_hora"], item["cliente"], item["empleado"], item["estado_des"]])

    # Crear el buffer
    buffer = BytesIO()

    # Crear el PDF
    doc = SimpleDocTemplate(buffer, pagesize=landscape(letter))
    elements = []

    # Obtener estilos
    styles = getSampleStyleSheet()
    title_style = styles['Title']
    normal_style = styles['Normal']

    # Agregar fecha
    today = datetime.now().strftime('%d de %B de %Y')
    date_paragraph = Paragraph(f"Fecha: {today}", normal_style)
    elements.append(date_paragraph)

    # Agregar título
    title = Paragraph('HISTORIAL DE AGENDA', title_style)
    elements.append(title)
    # Agregar un espacio antes de la tabla
    elements.append(Paragraph("<br/><br/>", normal_style))

    # Crear la tabla
    table = Table(table_data, colWidths=[1*inch, 2*inch, 1*inch, 1*inch, 2*inch, 2*inch, 1*inch])
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), HexColor('#CCCCCC')),
        ('TEXTCOLOR', (0, 0), (-1, 0), HexColor('#000000')),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), HexColor('#F5F5F5')),
        ('GRID', (0, 0), (-1, -1), 1, HexColor('#000000')),
    ]))
    elements.append(table)

    # Construir el PDF
    doc.build(elements)
    buffer.seek(0)

    with open('generated_report.pdf', 'wb') as f:
        f.write(buffer.getvalue())

    return HttpResponse(buffer, content_type='application/pdf')

def cargar_todo(request):
    e_fecha_inicio = request.GET.get('e_fecha_inicio')
    e_fecha_fin = request.GET.get('e_fecha_fin')

    with connection.cursor() as cursor:
        # Ejecuta el procedimiento almacenado con los parámetros
        cursor.execute('call pa_generaPdfTodo(%s, %s)', [e_fecha_inicio, e_fecha_fin])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'se_codigo': row[2],
            'se_nombre': row[3],
            'ci_fecha': row[4],
            'ci_hora': row[5],
            'cliente': row[6],
            'empleado': row[7],
            'ci_estado': row[8],
            'estado_des': row[9]
        })

    return JsonResponse(categorias, safe=False)

def cargar_esp(request):
    e_categoria = request.GET.get('e_categoria')
    e_servicio = request.GET.get('e_servicio')
    e_fecha_inicio = request.GET.get('e_fecha_inicio')
    e_fecha_fin = request.GET.get('e_fecha_fin')

    with connection.cursor() as cursor:
        cursor.execute('call pa_generaPdfEsp(%s, %s, %s, %s)', [e_categoria, e_servicio, e_fecha_inicio, e_fecha_fin])
        result = cursor.fetchall()

    categorias = []
    for row in result:
        categorias.append({
            'ca_codigo': row[0],
            'ca_nombre': row[1],
            'se_codigo': row[2],
            'se_nombre': row[3],
            'ci_fecha': row[4],
            'ci_hora': row[5],
            'cliente': row[6],
            'empleado': row[7],
            'ci_estado': row[8],
            'estado_des': row[9]
        })

    return JsonResponse(categorias, safe=False)

@csrf_exempt
@require_POST
def registrar(request):
    data = json.loads(request.body.decode('utf-8'))
    us_cedula = data.get('us_cedula')
    e_nombre = data.get('e_nombre')
    e_apellido = data.get('e_apellido')
    e_correo = data.get('e_correo')
    e_telefono = data.get('e_telefono')
    e_clave = data.get('e_clave')

    if not us_cedula or not e_clave:
            return JsonResponse({
                'codigo_error': 3,
                'mensaje': 'Parámetros faltantes'
            }, status=400)

    with connection.cursor() as cursor:
        cursor.execute('call pa_registrarCliente(%s, %s, %s, %s, %s, %s)', [us_cedula, e_nombre, e_apellido, e_correo, e_telefono, e_clave])
        result = cursor.fetchall()

    if result:
        row = result[0]
        codigo_error = row[0]
        mensaje = row[1]

    return JsonResponse({
        'codigo_error': codigo_error,
        'mensaje': mensaje
    })