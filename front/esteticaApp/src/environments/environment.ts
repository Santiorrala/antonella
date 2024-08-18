// This file can be replaced during build by using the `fileReplacements` array.
// `ng build` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  baseUrl: 'http://localhost:8000/api/',
  user: {
    us_codigo: -1,
    us_cedula: '',
    us_nombre: '',
    us_apellido: '',
    us_correo: '',
    us_telefono: '',
    us_clave: '',
    ro_codigo: '',
    us_estado: '',
    us_comentarios: ''
  }
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/plugins/zone-error';  // Included with Angular CLI.
