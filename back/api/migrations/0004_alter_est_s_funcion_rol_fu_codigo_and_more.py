# Generated by Django 5.1 on 2024-08-11 01:13

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_est_m_categoria_est_m_empleado_especialidad_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='est_s_funcion_rol',
            name='fu_codigo',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.est_s_funcion'),
        ),
        migrations.AlterField(
            model_name='est_s_funcion_rol',
            name='ro_codigo',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.est_s_roles'),
        ),
    ]