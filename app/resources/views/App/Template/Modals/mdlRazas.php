<div class="modal fade" id="mdlRazas" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmRazas" class="modal-content" onsubmit="return save(this,event)">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">Crear Nuevo Razas</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="idraza" name="idraza" value="">
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
                <div class="mb-3 col-lg-12 col-12">
                    <label class="form-label text-capitalize" for="nombreRaza">nombre</label>
                    <input type="text" class="form-control" id="nombreRaza" name="nombre">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
            </div>
        </form>
    </div>
</div>