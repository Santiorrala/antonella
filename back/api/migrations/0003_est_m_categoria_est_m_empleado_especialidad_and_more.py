# Generated by Django 5.1 on 2024-08-11 01:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_remove_est_m_cita_id_remove_est_m_cita_servicio_id_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='est_m_categoria',
            fields=[
                ('ca_codigo', models.PositiveBigIntegerField(primary_key=True, serialize=False)),
                ('ca_nombre', models.CharField(max_length=100, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='est_m_empleado_especialidad',
            fields=[
                ('ee_codigo', models.PositiveBigIntegerField(primary_key=True, serialize=False)),
                ('es_codigo', models.PositiveBigIntegerField()),
                ('em_codigo', models.PositiveBigIntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='est_m_especialidad',
            fields=[
                ('es_codigo', models.PositiveBigIntegerField(primary_key=True, serialize=False)),
                ('es_nombre', models.CharField(default='', max_length=100)),
            ],
        ),
        migrations.AddField(
            model_name='est_m_servicio',
            name='ca_codigo',
            field=models.PositiveBigIntegerField(default=0),
        ),
    ]
