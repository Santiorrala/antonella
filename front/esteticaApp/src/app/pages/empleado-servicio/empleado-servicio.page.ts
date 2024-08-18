import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AlertController, ModalController, NavParams } from '@ionic/angular';
import { EmpleadosService } from 'src/app/services/funciones/empleados.service';
import { ServiciosService } from 'src/app/services/funciones/servicios.service';
import { ToastService } from 'src/app/services/toast/toast.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-empleado-servicio',
  templateUrl: './empleado-servicio.page.html',
  styleUrls: ['./empleado-servicio.page.scss'],
})
export class EmpleadoServicioPage implements OnInit {
  empleados: any[] = []
  EmpleadoSeleccionado: boolean;
  codigoEmpleado: number;
  codServicio: string;
  duraServicio: number;
  fechaSeleccionda: string;
  seleccionarHora: boolean;
  horaSeleccionada: number;
  listo: boolean;
  minDate: string; 
  hoy: Date;
  horario: any[] = [
    {id: 8, hora: '08:00 - 09:00', estado: 0},
    {id: 9, hora: '09:00 - 10:00', estado: 0},
    {id: 10, hora: '10:00 - 11:00', estado: 0},
    {id: 11, hora: '11:00 - 12:00', estado: 0},
    {id: 12, hora: '12:00 - 13:00', estado: 0},
    {id: 13, hora: '13:00 - 14:00', estado: 0},
    {id: 14, hora: '14:00 - 15:00', estado: 0},
    {id: 15, hora: '15:00 - 16:00', estado: 0},
    {id: 16, hora: '16:00 - 17:00', estado: 0},
    {id: 17, hora: '17:00 - 18:00', estado: 0},
    {id: 18, hora: '18:00 - 19:00', estado: 0}
  ]
  horarios: any[] = []
  horas: any[] = [];

  constructor(
    private emplServ: EmpleadosService,
    private navParams: NavParams,
    private modalController: ModalController,
    private alertController: AlertController,
    private servServicio: ServiciosService,
    private router: Router,
    private toastService: ToastService
  ) { 
    this.EmpleadoSeleccionado = false;
    this.codigoEmpleado = -1
    this.codServicio = '';
    this.fechaSeleccionda = '';
    this.duraServicio = 0;
    this.seleccionarHora = false
    this.horaSeleccionada = 0;
    this.listo = false;
    this.minDate = '';
    this.hoy = new Date();
  }

  ngOnInit() {
    this.codServicio = this.navParams.get('id');
    this.duraServicio = this.navParams.get('duracion');
    this.getServicios(Number(this.codServicio));
    this.fechaInicio();
    this.setMinDate();
    this.hoy = new Date();
  }

  setMinDate() {
    const today = new Date();
    this.minDate = this.formatoFecha(today);
  }

  async getServicios(id: number){
    this.emplServ.getEmpleadosXServicios(id).subscribe({
      next: (data: any) => {
        this.empleados = data;
        //this.route.navigate(['/home']);
      }
    })
  }

  async cerrar(){
    await this.modalController.dismiss();
  }

  seleccionarFecha(id: number){
    this.EmpleadoSeleccionado = true
    this.codigoEmpleado = id
    this.fechaInicio();
  }

  cambioFecha(event: any) {
    const isoDate = event.detail.value;
    this.fechaSeleccionda = this.formatoFecha(isoDate);
  }

  elegirFecha() {
    
    let nuva: Date = new Date(this.fechaSeleccionda)
    
    if(nuva < this.hoy){
      this.toastService.presentToast('La fecha seleccionada es incorrecta', 3000).then(() => {
        setTimeout(() => {
          this.seleccionarHora = false;
          return
        }, 500);  // La duración debe coincidir con la duración del toast
      });
    }else{
      this.procesarFecha(this.fechaSeleccionda);
    }
  }

  fechaInicio() {
    const today = new Date();
    this.fechaSeleccionda = this.formatoFecha(today);
  }

  formatoFecha(date: Date): string {
    const day = ('0' + date.getDate()).slice(-2);
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
  }

  formatDate(isoDate: string): string {
    const [day, month, year] = isoDate.split('-');
    return `${day}-${month}-${year}`;
  }

  async procesarFecha(date: string) {
    // Aquí puedes manejar la fecha en formato dd-MM-yyyy
    this.fechaSeleccionda = this.formatDate(date).substring(0,10);
    await this.emplServ.getHorariosXEmpleado(this.formatDate(date).substring(0,10), this.codigoEmpleado).subscribe({
      next: async (data: any) => {
        this.empleados = data;
        this.horas = data;
        await this.validarHorarios();
        this.horarios = this.horario;
        this.seleccionarHora = true;
        
        //this.route.navigate(['/home']);
      }
    })
  }

  async validarHorarios(){
    this.horario.forEach(element => {
      this.horas.forEach(ele => {
        if(element.id == Number(ele.hora)){
          element.estado = 1;
        }else{
          if(element.estado != 1){
            element.estado = 0;
          }
        }
      });
    });
  }

  async agendar(hora_id: number){
    let banderaHora: number;
    let sal = 0;
    let exito: boolean = true;
    if(this.horarios[this.horarios.length-1].id >= hora_id + this.duraServicio -1){
      sal = hora_id;
      for(sal = hora_id; sal<hora_id+this.duraServicio; sal++){
        this.horarios.forEach(element => {
          if(element.id == sal){
            if(element.estado == 1){
              sal=hora_id+this.duraServicio+1;
              this.mostrartAlert("Agenda", 'La agenda de el servicio no es posible por la duracion del mismo con respecto al horario del profesional');    
              exito = false;
            }
          }
        });
      }
      this.validarHorarios();
      if(exito){
        for(sal = hora_id; sal<hora_id+this.duraServicio; sal++){
          this.horarios.forEach(element => {
            if(element.id == sal){
              element.estado = 2;
            }
          });
        }
      }
    }else{
      this.mostrartAlert("Agenda", 'La agenda no cumple con el horario de la estetica');
      return;
    }
    this.horaSeleccionada = hora_id;
    this.listo = true;
  }

  async mostrartAlert(header: string, message: string) {
    const alert = await this.alertController.create({
      header,
      message,
      buttons: ['OK']
    });
  
    await alert.present();
  }

  async agendarCita(){
    let mensaje: string;
    await this.servServicio.postAgendarCita(this.fechaSeleccionda.toString(), this.horaSeleccionada.toString(), this.codigoEmpleado.toString(), environment.user.us_codigo.toString(), this.codServicio).subscribe({
      next: (data: any) => {
        if(Number(data.codigo_error) != -1){
          this.toastService.presentToast(data.mensaje, 2000).then(() => {
            setTimeout(() => {
              this.enviaCorreo(data.codigo_error);
              this.router.navigate(['/home']);
            }, 2000); 
          });
          
        }else{
          this.mostrartAlert("Error", data.mensaje);
        }
        
      },
      error: async (error) => {
        this.mostrartAlert("Error", "Error de conexion");
        
      }
    })
  }

  async enviaCorreo(e_cita: number){
    await this.servServicio.getEnviaCorreo(e_cita).subscribe({
      next: async (data: any) => {
        await this.cerrar();
        this.router.navigate(['/home']);
        
      },
      error: async (error) => {
        this.mostrartAlert("Error", "Error de conexion");
      }
    })
  }

}
