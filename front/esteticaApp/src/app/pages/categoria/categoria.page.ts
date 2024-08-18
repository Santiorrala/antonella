import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CategoriaService } from 'src/app/services/funciones/categoria.services';

@Component({
  selector: 'app-categoria',
  templateUrl: './categoria.page.html',
  styleUrls: ['./categoria.page.scss'],
})
export class CategoriaPage implements OnInit {

  categorias: any[] = [];
  items: any[] = [];

  constructor(
    private cateService: CategoriaService,
    private router: Router
  ) { 
    console.log('categorias constructor');
  }

  ngOnInit() {
    console.log('categorias');
    this.getCategorias();
    this.items =  this.cateService.getItems();
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

}
