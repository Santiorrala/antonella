import { Injectable } from '@angular/core';

import {
  HttpClient,
  HttpErrorResponse,
  HttpHeaders,
  HttpResponse,
} from '@angular/common/http';

import { Observable } from 'rxjs/internal/Observable';
import { User } from './User';
import { interval, throwError } from 'rxjs';


import { environment } from 'src/environments/environment';
import { catchError, map, switchMap, timeout } from 'rxjs/operators';


@Injectable({
  providedIn: 'root',
})
export class LoginsService {
  private loginUrl = environment.baseUrl + 'login/'

  constructor(private http: HttpClient) {}

  estaAutenticado(): boolean{
    console.log(environment.user);
    if(environment.user.us_codigo != -1){
      console.log('si esta');
      return true;
    }else{
      console.log('no esta');
      return false;
    }

  }
  
  postAuthorized(us_cedula :String, us_clave: String):Observable<any>{
    const url = this.loginUrl;
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    const body = JSON.stringify({us_cedula, us_clave });
    console.log(url);
    return this.http.post<any>(url, body, { headers }).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );
    //return this.http.post<LoginResponse>(url,form, { headers });

  }

  registrar(us_cedula :String, e_nombre: String, e_apellido: String, e_correo: String, e_telefono: String, e_clave: String):Observable<any>{
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    const body = JSON.stringify({us_cedula, e_nombre, e_apellido, e_correo, e_telefono, e_clave});
    return this.http.post<any>(environment.baseUrl + 'registrar/', body, { headers }).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );
  }

   //registro de cliente
   /*
   registerUser(body:RegisterRequest, token:string):Observable<RegisterResponse>{
    
    const url = this.apiUrlRegisterUrl;
    const headers = new HttpHeaders({
      'api-key': environment.getApiProd(),
      'channel': environment.getChannelProd(),
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<RegisterResponse>(url,body, { headers });
    
  }
    */
  


  private handleError(error: HttpErrorResponse) {
    if (error.status === 0) {
      console.error('se ha producido un error ', error.error);
    } else {
      console.error('Retorno el código de estado', error.status, error.error);
    }
    return throwError(() => new Error('Algo falló, intenta nuevamente'));
  }




}
