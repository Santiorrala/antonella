import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AlertController } from '@ionic/angular';
import { LoginsService } from 'src/app/services/auth/login.service';
import { ToastService } from 'src/app/services/toast/toast.service';

@Component({
  selector: 'app-registrar',
  templateUrl: './registrar.page.html',
  styleUrls: ['./registrar.page.scss'],
})
export class RegistrarPage implements OnInit {
  cedula: string;
  nombre: string;
  apellido: string;
  correo: string;
  telefono: string;
  clave: string;
  clave1: string;

  constructor(
    private toastService: ToastService,
    private loginservice: LoginsService,
    private alertController: AlertController,
    private route: Router
  ) { 
    this.cedula = '';
    this.nombre = '';
    this.apellido = '';
    this.correo = '';
    this.telefono = '';
    this.clave = '';
    this.clave1 = '';
  }

  ngOnInit() {
  }

  async registrar(){
    console.log(
      this.cedula,
      this.nombre,
      this.apellido,
      this.correo,
      this.telefono,
      this.clave,
      this.clave1
    )
    if(this.cedula != '' || this.nombre != '' || this.apellido != '' || this.correo != '' || this.telefono != '' || this.clave != ''){
      if(this.clave != this.clave1){
        this.toastService.presentToast('Las contraseñas no coinciden', 3000).then(() => {
          setTimeout(() => {
            return
          }, 500);
        });
      }else{
        await this.loginservice.registrar(this.cedula,this.nombre,this.apellido,this.correo,this.telefono,this.clave).subscribe({
          next: (data: any) => {
            console.log(data);
            this.toastService.presentToast(data.mensaje, 3000).then(() => {
              setTimeout(() => {
                this.route.navigate(['/login']);
              }, 500);
            });
          },
          error: async (error) => {
            this.mostrartAlert("Login", "Error de conexion");
          }
        });
      }
    }else{
      this.toastService.presentToast('Todos los datos son necesarios', 3000).then(() => {
        setTimeout(() => {
          return
        }, 500);
      });
    }
  }

  onChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.id === 'cedula') {
      this.cedula = input.value;
    } else if (input.id === 'nombre') {
      this.nombre = input.value;
    } else if (input.id === 'apellido') {
      this.apellido = input.value;
    } else if (input.id === 'correo') {
      this.correo = input.value;
    } else if (input.id === 'telefono') {
      this.telefono = input.value;
    } else if (input.id === 'clave') {
      this.clave = input.value;
    } else if (input.id === 'clave1') {
      this.clave1 = input.value;
    }
  }

  async mostrartAlert(header: string, message: string) {
    const alert = await this.alertController.create({
      header,
      message,
      buttons: ['OK']
    });
  
    await alert.present();
  }
}
