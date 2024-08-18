import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { LoginsService } from '../services/auth/login.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private authService: LoginsService, private router: Router) {}

  canActivate(): boolean {
    console.log(this.authService.estaAutenticado());
    if (this.authService.estaAutenticado()) {
      return true;
    } else {
      this.router.navigate(['/login']); // Redirige a la página de login si no está autenticado
      return false;
    }
  }
}
