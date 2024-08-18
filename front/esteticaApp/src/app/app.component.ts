import { Component } from '@angular/core';
import { environment } from 'src/environments/environment';
@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent {
  public appPages = [
    { title: 'home', url: '/home', icon: 'home' },
    { title: 'Cerrar Sesion', url: '', icon: 'people' },
  ];
  public labels = [];

  usuario: string;

  constructor() {
    this.usuario = environment.user.us_nombre + ' ' + environment.user.us_apellido
  }

}
