import { Component, OnInit } from '@angular/core';
import { CitasService } from 'src/app/services/funciones/citas.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-historial',
  templateUrl: './historial.page.html',
  styleUrls: ['./historial.page.scss'],
})
export class HistorialPage implements OnInit {
  datos: any[] = []

  constructor(
    private citaServ: CitasService
  ) { }

  ngOnInit() {
    this.getCategorias();
  }

  async getCategorias(){
    this.citaServ.getHistorial(environment.user.us_codigo, 1, Number(environment.user.ro_codigo)).subscribe({
      next: (data: any) => {
        console.log(data);
        this.datos = data;
        //this.route.navigate(['/home']);
      }
    })
  }

}
