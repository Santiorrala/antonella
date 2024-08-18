import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalController } from '@ionic/angular';
import { ServiciosService } from 'src/app/services/funciones/servicios.service';
import { EmpleadoServicioPage } from '../empleado-servicio/empleado-servicio.page';

@Component({
  selector: 'app-servicios',
  templateUrl: './servicios.page.html',
  styleUrls: ['./servicios.page.scss'],
})
export class ServiciosPage implements OnInit {

  id: any;
  servicios: any[] = [];

  constructor(
    private router: Router,
    private _formBuilder: FormBuilder,
    private activatedRoute: ActivatedRoute,
    private servService: ServiciosService,
    private modalController: ModalController
  ) { }

  ngOnInit() {
    this.activatedRoute.params.subscribe((params) => {
      if (params['id']) {
        this.id = params['id'];
        this.getServicios(this.id);
      }else{
        this.router.navigate(['/home']);
      }
    });
  }

  async getServicios(id: number){
    this.servService.getServicios(-1,id).subscribe({
      next: (data: any) => {
        this.servicios = data;
        //this.route.navigate(['/home']);
      }
    })
  }

  async openModal(id: number, duracion: number) {
    const modal = await this.modalController.create({
      component: EmpleadoServicioPage,
      componentProps: {
        id: id,
        duracion: duracion
      }
    });
    return await modal.present();
  }

}
