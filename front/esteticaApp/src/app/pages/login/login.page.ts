import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AlertController, IonModal, ModalController, NavController } from '@ionic/angular';
import { LoginsService } from 'src/app/services/auth/login.service';
import { User } from '../../services/auth/User';
import { environment } from 'src/environments/environment';
import { PdfServicio } from 'src/app/services/funciones/pdfservicio.service';
import { FileSaverService } from 'ngx-filesaver';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {
  formLogin: FormGroup;
  alertaError: boolean

  constructor(
    private route: Router,
    public form: FormBuilder,
    private navCtrl: NavController,
    private modalController: ModalController,
    private loginservice: LoginsService, 
    private alertController: AlertController
  ) { 
    this.formLogin = this.form.group({
      us_cedula: new FormControl('', [
        Validators.required,
        Validators.minLength(1),
      ]),
      us_clave: new FormControl('', [
        Validators.required,
        Validators.minLength(1),
      ]),
    });
    this.alertaError = false;
  }

  ngOnInit() {
  }

  async iniciarSesion(){
    //this.navCtrl.navigateRoot('/home');
    let usuario: User = new User();
    usuario.us_cedula = this.formLogin.get('us_cedula')?.value
    usuario.us_clave = this.formLogin.get('us_clave')?.value
    this.loginservice.postAuthorized(usuario.us_cedula, usuario.us_clave).subscribe({
      next: (data: any) => {
        if(data.codigo_error != null){
          this.alertaError = true;
          this.mostrartAlert("Login", data.mensaje);
        }else{
          environment.user.us_codigo = data.us_codigo;
          environment.user.us_cedula = data.us_cedula;
          environment.user.us_nombre = data.us_nombre + ' ' + data.us_apellido;
          environment.user.us_telefono = data.us_telefono;
          environment.user.ro_codigo = data.ro_codigo;
          environment.user.us_correo = data.us_correo;
          //this.route.navigate(['/home']);
          this.route.navigate(['/home']);
        }
        //this.route.navigate(['/home']);
      },
      error: async (error) => {
        // Manejo de errores de la petición
        this.alertaError = true;
        this.mostrartAlert("Login", "Error de conexion");
        
      }
    })
    //this.storage.set('viewOnboarding', 'true');
  } 

  closeAlertaError(){
    this.alertaError = false;
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
