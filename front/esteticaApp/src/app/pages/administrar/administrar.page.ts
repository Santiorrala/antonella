import { Component, OnInit, ViewChild } from '@angular/core';
import { IonDatetime, ModalController } from '@ionic/angular';
import { FileSaverService } from 'ngx-filesaver';
import { CategoriaService } from 'src/app/services/funciones/categoria.services';
import { PdfServicio } from 'src/app/services/funciones/pdfservicio.service';
import { ServiciosService } from 'src/app/services/funciones/servicios.service';
import { ToastService } from 'src/app/services/toast/toast.service';

@Component({
  selector: 'app-administrar',
  templateUrl: './administrar.page.html',
  styleUrls: ['./administrar.page.scss'],
})
export class AdministrarPage implements OnInit {
  startDate: string;
  endDate: string;
  datos: any[] = [];
  mostrarTabla: Boolean;
  esGeneral: Boolean;
  esEspecifico: boolean;
  codCate: number;
  codServ: number;
  categorias: any[] = [];
  servicios: any[] = [];

  constructor(private modalCtrl: ModalController,
    private pdfServicio: PdfServicio,
    private fileSaver: FileSaverService,
    private toastService: ToastService,
    private servService: ServiciosService,
    private cateService: CategoriaService
  ) { 
    this.startDate = '';
    this.endDate = '';
    this.mostrarTabla = false;
    this.esGeneral = false;
    this.esEspecifico = false;
    this.codCate = -1;
    this.codServ = -1;
  }

  ngOnInit() {
  }

  onDateChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.id === 'startDate') {
      this.startDate = input.value;
    } else if (input.id === 'endDate') {
      this.endDate = input.value;
    }
  }

  async cargardatos(){
    console.log(this.startDate + ' - ' + this.endDate);
    if(this.startDate == '' || this.endDate == ''){
      this.toastService.presentToast('Las fechas son obigatorias', 2000).then(() => {
        setTimeout(() => {
          this.mostrarTabla = false;
          return
        }, 2000); 
      });
    }else{
      let ini: Date = new Date(this.startDate);
      let fin: Date = new Date(this.endDate);
      if(fin<ini){
        this.toastService.presentToast('Las fecha de fin no puede ser menor a la de inicio', 2000).then(() => {
          setTimeout(() => {
            this.mostrarTabla = false;
            return
          }, 2000); 
        });
      }else{
        console.log('Las fechas son correctas');
        await this.pdfServicio.getcargarTodo(this.startDate, this.endDate).subscribe({
          next: (data: any) => {
            console.log(data);
            this.datos = data;
            //this.route.navigate(['/home']);
          }
        });
        this.mostrarTabla = true;
      }
    }
  }

  async descargardatos(){
    console.log(this.startDate + ' - ' + this.endDate);
    if(this.startDate == '' || this.endDate == ''){
      this.toastService.presentToast('Las fechas son obigatorias', 2000).then(() => {
        setTimeout(() => {
          this.mostrarTabla = false;
          return
        }, 2000); 
      });
    }else{
      let ini: Date = new Date(this.startDate);
      let fin: Date = new Date(this.endDate);
      if(fin<ini){
        this.toastService.presentToast('Las fecha de fin no puede ser menor a la de inicio', 2000).then(() => {
          setTimeout(() => {
            this.mostrarTabla = false;
            return
          }, 2000); 
        });
      }else{
        console.log('Las fechas son correctas');
        await this.pdfServicio.generatePdf(this.startDate, this.endDate).subscribe(
          (blob: Blob) => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'report.pdf';
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            a.remove();
          },
          (error) => {
            console.error('Error downloading PDF:', error);
          }
        );
        this.mostrarTabla = true;
      }
    }
  }

  hagoGeneral(){
    this.esEspecifico = false;
    this.esGeneral = true;
    this.startDate = '';
    this.endDate = '';
    this.codCate = -1;
    this.codServ = -1;
    this.datos = [];
    this.mostrarTabla = false;
  }

  async hagoEspecifico(){
    this.esEspecifico = true;
    this.esGeneral = false;
    this.startDate = '';
    this.endDate = '';
    this.codCate = -1;
    this.codServ = -1;
    this.datos = [];
    await this.getCategorias();
    this.mostrarTabla = false;
  }

  async getCategorias(){
    this.cateService.getCategorias().subscribe({
      next: (data: any) => {
        console.log(data);
        this.categorias = data;
        //this.route.navigate(['/home']);
      }
    })
  }

  async getServicios(id: number){
    this.servService.getServicios(-1,id).subscribe({
      next: (data: any) => {
        console.log(data);
        this.servicios = data;
        //this.route.navigate(['/home']);
      }
    })
  }

  async onCatalogChange(event: any) {
    console.log('Selected catalog:', event.detail.value);
    await this.getServicios(this.codCate);
  }

  async onCatalogChange1(event: any) {
    console.log('Selected catalog:', event.detail.value);
  }

  async descargardatosEsp(){
    console.log(this.startDate + ' - ' + this.endDate);
    if(this.startDate == '' || this.endDate == ''){
      this.toastService.presentToast('Las fechas son obigatorias', 2000).then(() => {
        setTimeout(() => {
          this.mostrarTabla = false;
          return
        }, 2000); 
      });
    }else{
      let ini: Date = new Date(this.startDate);
      let fin: Date = new Date(this.endDate);
      if(fin<ini){
        this.toastService.presentToast('Las fecha de fin no puede ser menor a la de inicio', 2000).then(() => {
          setTimeout(() => {
            this.mostrarTabla = false;
            return
          }, 2000); 
        });
      }else{
        console.log('Las fechas son correctas especifico');
        await this.pdfServicio.generatePdfEsp(this.codCate, this.codServ, this.startDate, this.endDate).subscribe(
          (blob: Blob) => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'report.pdf';
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            a.remove();
          },
          (error) => {
            console.error('Error downloading PDF:', error);
          }
        );
        this.mostrarTabla = true;
      }
    }
  }

  async cargardatosEsp(){
    console.log(this.startDate + ' - ' + this.endDate);
    if(this.startDate == '' || this.endDate == ''){
      this.toastService.presentToast('Las fechas son obigatorias', 2000).then(() => {
        setTimeout(() => {
          this.mostrarTabla = false;
          return
        }, 2000); 
      });
    }else{
      let ini: Date = new Date(this.startDate);
      let fin: Date = new Date(this.endDate);
      if(fin<ini){
        this.toastService.presentToast('Las fecha de fin no puede ser menor a la de inicio', 2000).then(() => {
          setTimeout(() => {
            this.mostrarTabla = false;
            return
          }, 2000); 
        });
      }else{
        console.log('Las fechas son correctas especificos');
        await this.pdfServicio.getcargarEsp(this.codCate, this.codServ, this.startDate, this.endDate).subscribe({
          next: (data: any) => {
            console.log(data);
            this.datos = data;
            //this.route.navigate(['/home']);
          }
        });
        this.mostrarTabla = true;
      }
    }
  }
}
