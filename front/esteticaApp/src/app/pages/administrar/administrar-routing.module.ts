import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AdministrarPage } from './administrar.page';
import { AuthGuard } from 'src/app/guard/AuthGuard.guard';

const routes: Routes = [
  {
    path: '',
    component: AdministrarPage,
    canActivate: [AuthGuard]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdministrarPageRoutingModule {}
