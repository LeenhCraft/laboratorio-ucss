<div class="modal fade" id="mdlServicios" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmServicios" class="modal-content" onsubmit="return save(this,event)">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">
                    <span>
                        Crear servicio nuevo
                    </span>

                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="idservicio" name="idservicio" value="">
                <div class="mb-3 col-lg-12 col-12">
                    <label class="form-label text-capitalize" for="nombre">nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" data-char-limit="100">
                    <div class="form-text">Máximo 100 caracteres.</div>
                </div>
                <div class="mb-3 col-lg-12 col-12">
                    <label class="form-label text-capitalize" for="precio">precio</label>
                    <input type="number" class="form-control" id="precio" name="precio" value="1">
                </div>
                <div class="mb-3 col-lg-12 col-12">
                    <label class="form-label text-capitalize" for="descripcion">descripcion</label>
                    <input type="text" class="form-control" id="descripcion" name="descripcion" data-char-limit="150">
                    <div class="form-text">Máximo 150 caracteres.</div>
                    <div></div>
                </div>
                <div class="mb-3 col-lg-12 col-12">
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
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
            </div>
        </form>
    </div>
</div>