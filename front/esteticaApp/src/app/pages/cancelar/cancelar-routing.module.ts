import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CancelarPage } from './cancelar.page';
import { AuthGuard } from 'src/app/guard/AuthGuard.guard';

const routes: Routes = [
  {
    path: '',
    component: CancelarPage,
    canActivate: [AuthGuard]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CancelarPageRoutingModule {}
