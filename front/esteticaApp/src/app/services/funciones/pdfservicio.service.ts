// pdf.service.ts
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import axios from 'axios';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class PdfServicio {

    private apiUrl = environment.baseUrl + 'api/prueba_pdf/'; // Cambia esto a la URL de tu API

    constructor(private http: HttpClient) { }
  
    generatePdf(e_fecha_inicio: string, e_fecha_fin: string): Observable<Blob> {
      return this.http.get(environment.baseUrl + 'prueba_pdf1/?e_fecha_inicio=' + e_fecha_inicio + '&e_fecha_fin=' + e_fecha_fin, { responseType: 'blob' });
    }

    generatePdfEsp(e_categoria: number, e_servicio: number, e_fecha_inicio: string, e_fecha_fin: string): Observable<Blob> {
        return this.http.get(environment.baseUrl + 'prueba_pdf/?e_categoria=' + e_categoria + '&e_servicio=' + e_servicio + '&e_fecha_inicio=' + e_fecha_inicio + '&e_fecha_fin=' + e_fecha_fin, { responseType: 'blob' });
      }

    getcargarTodo(e_fecha_inicio: string, e_fecha_fin: string):Observable<any>{
    const headers = new HttpHeaders({
        'Content-Type': 'application/json',
        });
    return this.http.get<any>(environment.baseUrl + 'cargartodo/?e_fecha_inicio=' + e_fecha_inicio + '&e_fecha_fin=' + e_fecha_fin).pipe(
        catchError(error => {
            // Manejo de errores
            console.error('Error en la solicitud', error);
            return throwError(error);
        })
        );

    }

    getcargarEsp(e_categoria: number, e_servicio: number, e_fecha_inicio: string, e_fecha_fin: string):Observable<any>{
        const headers = new HttpHeaders({
            'Content-Type': 'application/json',
            });
        return this.http.get<any>(environment.baseUrl + 'cargaresp/?e_categoria=' + e_categoria + '&e_servicio=' + e_servicio + '&e_fecha_inicio=' + e_fecha_inicio + '&e_fecha_fin=' + e_fecha_fin).pipe(
            catchError(error => {
                // Manejo de errores
                console.error('Error en la solicitud', error);
                return throwError(error);
            })
            );
    
        }

}