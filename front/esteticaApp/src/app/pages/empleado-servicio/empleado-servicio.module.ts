import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { EmpleadoServicioPageRoutingModule } from './empleado-servicio-routing.module';

import { EmpleadoServicioPage } from './empleado-servicio.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    EmpleadoServicioPageRoutingModule
  ],
  declarations: [EmpleadoServicioPage]
})
export class EmpleadoServicioPageModule {}
