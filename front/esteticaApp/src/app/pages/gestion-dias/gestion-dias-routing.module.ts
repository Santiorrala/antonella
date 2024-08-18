import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { GestionDiasPage } from './gestion-dias.page';

const routes: Routes = [
  {
    path: '',
    component: GestionDiasPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class GestionDiasPageRoutingModule {}
