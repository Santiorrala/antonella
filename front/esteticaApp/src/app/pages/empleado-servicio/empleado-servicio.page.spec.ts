import { ComponentFixture, TestBed } from '@angular/core/testing';
import { EmpleadoServicioPage } from './empleado-servicio.page';

describe('EmpleadoServicioPage', () => {
  let component: EmpleadoServicioPage;
  let fixture: ComponentFixture<EmpleadoServicioPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(EmpleadoServicioPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
