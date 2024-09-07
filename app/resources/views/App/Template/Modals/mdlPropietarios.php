<div class="modal fade" id="mdlPropietarios" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form id="frmPropietarios" class="modal-content" onsubmit="return save(this,event)">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title d-flex align-items-end" id="modal-title">
                    <span>
                        Crear Nuevo Propietarios
                    </span>
                    <i class='bx bx-check bx-md text-success'></i>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body row">
                <input type="hidden" id="idpropietario" name="idpropietario" value="">
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="nombres">nombres</label>
                    <input type="text" class="form-control" id="nombres" name="nombres">
                </div>
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="apellidos">apellidos</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos">
                </div>
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="cuenta">Cuenta / Correo electrónico</label>
                    <input type="text" class="form-control" id="cuenta" name="cuenta">
                </div>
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="celular">celular</label>
                    <input type="number" class="form-control" id="celular" name="celular">
                </div>
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="direccion">direccion</label>
                    <input type="text" class="form-control" id="direccion" name="direccion">
                </div>
                <div class="mb-3 col-12 col-lg-6">
                    <label class="form-label text-capitalize" for="fecha_registro">fecha registro</label>
                    <input type="date" class="form-control" id="fecha_registro" name="fecha_registro">
                </div>
                <hr>
                <div class="mb-3 d-flex align-items-end pb-1 col-12 col-lg-6">
                    <label class="switch">
                        <input type="checkbox" class="switch-input" id="estado" name="estado" checked>
                        <span class="switch-toggle-slider">
                            <span class="switch-on"></span>
                            <span class="switch-off"></span>
                        </span>
                        <span class="switch-label">Activo</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary text-capitalize">registrar dueño</button>
            </div>
        </form>
    </div>
</div>