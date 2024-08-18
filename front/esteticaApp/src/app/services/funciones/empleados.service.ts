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
export class EmpleadosService {
  private empleadoUrl = environment.baseUrl + 'cempleadoxservicio'
  private horrarioXempleadoUrl = environment.baseUrl + 'pa_horariosXFecha'

  constructor(private http: HttpClient) {}

  
  getEmpleadosXServicios(se_codigo: number):Observable<any>{
    const url = this.empleadoUrl;
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(url + '/?se_codigo=' + se_codigo).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );

  }

  getHorariosXEmpleado(e_fecha: string, e_empleado: number):Observable<any>{
    const url = this.horrarioXempleadoUrl;
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(url + '/?e_fecha=' + e_fecha + '&e_empleado=' + e_empleado).pipe(
        catchError(error => {
          // Manejo de errores
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
