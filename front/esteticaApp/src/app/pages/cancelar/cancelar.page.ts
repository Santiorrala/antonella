import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CitasService } from 'src/app/services/funciones/citas.service';
import { ToastService } from 'src/app/services/toast/toast.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-cancelar',
  templateUrl: './cancelar.page.html',
  styleUrls: ['./cancelar.page.scss'],
})
export class CancelarPage implements OnInit {

  datos: any[] = [];

  constructor(
    private citaServ: CitasService,
    private router: Router,
    private toastService: ToastService
  ) { 
    console.log('categorias constructor');
  }

  ngOnInit() {
    this.getCategorias();
  }

  async getCategorias(){
    this.citaServ.getHistorial(environment.user.us_codigo, 0, Number(environment.user.ro_codigo)).subscribe({
      next: (data: any) => {
        console.log(data);
        this.datos = data;
      }
    })
  }

  async cancelar(cita: any){
    console.log(cita);
    this.citaServ.getCancelarCita(Number(cita)).subscribe({
      next: (data: any) => {
        console.log(data);
        this.toastService.presentToast(data.mensaje, 2000).then(() => {
          setTimeout(() => {
            this.router.navigate(['/home']);
          }, 2000);  // La duración debe coincidir con la duración del toast
        });
      }
    })

  }

}
