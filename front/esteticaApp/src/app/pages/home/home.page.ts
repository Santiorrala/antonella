import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CategoriaService } from 'src/app/services/funciones/categoria.services';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
})
export class HomePage implements OnInit {
  categorias: any[] = [];
  items: any[] = [];
  codigoRol: number;

  constructor(
    private cateService: CategoriaService,
    private router: Router
  ) { 
    this.codigoRol = 1;
  }

  ngOnInit() {
    this.getCategorias();
    this.items =  this.cateService.getItems();
    this.codigoRol = Number(environment.user.ro_codigo);
  }

  async getCategorias(){
    this.cateService.getCategorias().subscribe({
      next: (data: any) => {
        this.categorias = data;
        //this.route.navigate(['/home']);
      }
    })
  }

  getImageUrl(imageName: string): string {
    return `assets/categorias/${imageName}`;
  }

  cargarServicos(id: any){
    this.router.navigate(['/servicios', id]);
  }

  irAgendar(){
    this.router.navigate(['/categoria'])
  }
  
  irHistorial(){
    if(Number(environment.user.ro_codigo) == 0){
      this.router.navigate(['/administrar'])
    }else{
      this.router.navigate(['/historial'])
    }
  }

  irCancelar(){
    this.router.navigate(['/cancelar'])
  }
  

}
