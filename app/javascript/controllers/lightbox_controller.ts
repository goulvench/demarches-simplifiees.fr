import { Controller } from '@hotwired/stimulus';
import lightGallery from 'lightgallery';
import { LightGallerySettings } from 'lightgallery/lg-settings';
import { LightGallery } from 'lightgallery/lightgallery';
import lgThumbnail from 'lightgallery/plugins/thumbnail';
import lgZoom from 'lightgallery/plugins/zoom';
import lgRotate from 'lightgallery/plugins/rotate';
import 'lightgallery/css/lightgallery-bundle.css';

export default class extends Controller {
  optionsValue?: LightGallerySettings;
  lightGallery?: LightGallery;

  static values = {
    options: Object
  };

  connect(): void {
    const options = {
      plugins: [lgZoom, lgThumbnail, lgRotate],
      flipVertical: false,
      flipHorizontal: false,
      animateThumb: false,
      zoomFromOrigin: false,
      allowMediaOverlap: true,
      toggleThumb: true
    };

    this.lightGallery = lightGallery(this.element as HTMLElement, options);
  }

  disconnect(): void {
    this.lightGallery?.destroy();
  }

  get defaultOptions(): LightGallerySettings {
    return {};
  }
}
