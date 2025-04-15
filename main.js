import { initApp, handleInitError } from './js/app.js';

initApp().then(tracer => {
  console.log(tracer);
}).catch(error => {
  handleInitError(error);
});
