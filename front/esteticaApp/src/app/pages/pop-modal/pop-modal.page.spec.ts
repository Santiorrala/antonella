import { ComponentFixture, TestBed } from '@angular/core/testing';
import { PopModalPage } from './pop-modal.page';

describe('PopModalPage', () => {
  let component: PopModalPage;
  let fixture: ComponentFixture<PopModalPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(PopModalPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
