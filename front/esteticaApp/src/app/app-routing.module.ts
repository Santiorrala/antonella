import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./pages/login/login.module').then( m => m.LoginPageModule)
  },
  {
    path: 'folder/:id',
    loadChildren: () => import('./folder/folder.module').then( m => m.FolderPageModule)
  },
  {
    path: 'login',
    loadChildren: () => import('./pages/login/login.module').then( m => m.LoginPageModule)
  },
  {
    path: 'registrar',
    loadChildren: () => import('./pages/registrar/registrar.module').then( m => m.RegistrarPageModule)
  },
  {
    path: 'home',
    loadChildren: () => import('./pages/home/home.module').then( m => m.HomePageModule)
  },
  {
    path: 'pop-modal',
    loadChildren: () => import('./pages/pop-modal/pop-modal.module').then( m => m.PopModalPageModule)
  },
  {
    path: 'servicios/:id',
    loadChildren: () => import('./pages/servicios/servicios.module').then( m => m.ServiciosPageModule)
  },
  {
    path: 'empleado-servicio',
    loadChildren: () => import('./pages/empleado-servicio/empleado-servicio.module').then( m => m.EmpleadoServicioPageModule)
  },
  {
    path: 'categoria',
    loadChildren: () => import('./pages/categoria/categoria.module').then( m => m.CategoriaPageModule)
  },
  {
    path: 'historial',
    loadChildren: () => import('./pages/historial/historial.module').then( m => m.HistorialPageModule)
  },
  {
    path: 'cancelar',
    loadChildren: () => import('./pages/cancelar/cancelar.module').then( m => m.CancelarPageModule)
  },
  {
    path: 'administrar',
    loadChildren: () => import('./pages/administrar/administrar.module').then( m => m.AdministrarPageModule)
  },
  {
    path: 'gestion-dias',
    loadChildren: () => import('./pages/gestion-dias/gestion-dias.module').then( m => m.GestionDiasPageModule)
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {}
