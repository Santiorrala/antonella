import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ServiciosPage } from './servicios.page';
import { AuthGuard } from 'src/app/guard/AuthGuard.guard';

const routes: Routes = [
  {
    path: '',
    component: ServiciosPage,
    canActivate: [AuthGuard]
  },
  {
    path: 'servicios/:id',
    component: ServiciosPage,
    canActivate: [AuthGuard]

  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ServiciosPageRoutingModule {}
