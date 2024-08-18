import { ComponentFixture, TestBed } from '@angular/core/testing';
import { GestionDiasPage } from './gestion-dias.page';

describe('GestionDiasPage', () => {
  let component: GestionDiasPage;
  let fixture: ComponentFixture<GestionDiasPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(GestionDiasPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
