<div class="modal fade" id="mdlHistoriaclinica" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form id="frmHistoriaclinica" class="modal-content">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">Crear Nuevo Historiaclinica</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <input type="hidden" id="id" name="id" value="">
                    <div class="mb-3 col-lg-6 col-12">
                        <label class="form-label text-capitalize" for="numero-historia">N° de Historia</label>
                        <input type="text" id="numero-historia" class="form-control ver-numero" readonly>
                        <input type="hidden" id="numero_historia" name="numero_historia">
                        <input type="hidden" id="hash" name="hash">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-lg-6 col-12">
                        <label class="form-label text-capitalize" for="idpropietario">propietario</label>
                        <select id="idpropietario" name="idpropietario" class="form-select"></select>
                    </div>
                    <div class="mb-3 col-lg-6 col-12">
                        <label class="form-label text-capitalize" for="idmascota">mascota</label>
                        <select id="idmascota" name="idmascota" class="form-select"></select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
            </div>
        </form>
    </div>
</div>