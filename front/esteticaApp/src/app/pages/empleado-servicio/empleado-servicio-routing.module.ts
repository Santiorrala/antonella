import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { EmpleadoServicioPage } from './empleado-servicio.page';
import { AuthGuard } from 'src/app/guard/AuthGuard.guard';

const routes: Routes = [
  {
    path: '',
    component: EmpleadoServicioPage,
    canActivate: [AuthGuard]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class EmpleadoServicioPageRoutingModule {}
