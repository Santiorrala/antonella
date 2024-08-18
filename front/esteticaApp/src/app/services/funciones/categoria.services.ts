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
export class CategoriaService {
  private categoriaUrl = environment.baseUrl + 'gcategoria'

  private items = [
    { id: 1, name: 'Item 1' },
    { id: 2, name: 'Item 2' },
    { id: 3, name: 'Item 3' }
  ];

  constructor(private http: HttpClient) {}

  
  getCategorias():Observable<any>{
    const url = this.categoriaUrl;
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
      });
    return this.http.get<any>(url, { headers }).pipe(
        catchError(error => {
          // Manejo de errores
          console.error('Error en la solicitud', error);
          return throwError(error);
        })
      );
    //return this.http.post<LoginResponse>(url,form, { headers });

  }

  getItems() {
    return this.items;
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
