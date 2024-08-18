import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { GestionDiasPageRoutingModule } from './gestion-dias-routing.module';

import { GestionDiasPage } from './gestion-dias.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    GestionDiasPageRoutingModule
  ],
  declarations: [GestionDiasPage]
})
export class GestionDiasPageModule {}
