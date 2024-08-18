import { Injectable } from '@angular/core';

import {
  HttpClient,
  HttpErrorResponse,
  HttpHeaders,
  HttpResponse,
} from '@angular/common/http';

import { Observable } from 'rxjs/internal/Observable';
import { interval, throwError } from 'rxjs';


import { environment } from 'src/environments/environment';
import { catchError, map, switchMap, timeout } from 'rxjs/operators';


@Injectable({
  providedIn: 'root',
})
export class ServiciosService {
  private servicioUrl = environment.baseUrl + 'cservicio'
  private agendarUrl = environment.baseUrl + 'agendarCita/'
  private correoUrl = environment.baseUrl + 'enviocorreo/'

  constructor(private http: HttpClient) {}

  
  getServicios(se_codigo: number, ca_codigo: number):Observable<any>{
    const url = this.servicioUrl;
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(url + '/?se_codigo=' + se_codigo + '&ca_codigo=' + ca_codigo, { headers }).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );

  }
  
  postAgendarCita(e_fecha: string, e_hora: string, e_empleado: string, e_cliente: string, e_servicio: string):Observable<any>{
    console.log(e_fecha);
    console.log(e_hora);
    console.log(e_empleado);
    console.log(e_cliente);
    console.log(e_servicio);
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    const body = JSON.stringify({
      "e_fecha": e_fecha, 
      "e_hora": e_hora, 
      "e_empleado": e_empleado, 
      "e_cliente": e_cliente, 
      "e_servicio": e_servicio
    });
    return this.http.post<any>(this.agendarUrl, body, { headers }).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );

  }

  getEnviaCorreo(e_cita: number):Observable<any>{
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(this.correoUrl + '?e_cita=' + e_cita, { headers }).pipe(
        catchError(error => {
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );

  }

  getHistorialRealizadas(e_cita: number):Observable<any>{
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(this.correoUrl + '?e_cita=' + e_cita, { headers }).pipe(
        catchError(error => {
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );

  }

  private handleError(error: HttpErrorResponse) {
    if (error.status === 0) {
      console.error('se ha producido un error ', error.error);
    } else {
      console.error('Retorno el código de estado', error.status, error.error);
    }
    return throwError(() => new Error('Algo falló, intenta nuevamente'));
  }




}
