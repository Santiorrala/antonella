import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { PopModalPage } from './pop-modal.page';

const routes: Routes = [
  {
    path: '',
    component: PopModalPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class PopModalPageRoutingModule {}
