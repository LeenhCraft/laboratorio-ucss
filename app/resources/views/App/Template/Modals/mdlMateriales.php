<div class="modal fade" id="mdlMateriales" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmMateriales" class="modal-content">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">Registrar nuevo material</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body row">
                <input type="hidden" id="idmaterial" name="idmaterial" value="">
                <input type="hidden" id="tipo_material_original" name="tipo_material_original" value="">
                <div>
                    <button id="limpiar" class="btn btn-outline-primary btn-sm text-primary" type="button">
                        <i class='bx bxs-brush'></i>
                    </button>
                </div>
                <hr class="my-2">
                <div>
                    <div class="row">
                        <div class="col-12 col-lg-6">
                            <label class="fw-bold form-label text-capitalize" for="idtipomaterial">Tipo de material</label>
                            <select name="idtipomaterial" id="idtipomaterial" class="form-select">
                                <option value="0" selected>Seleccione</option>
                                <option value="1">Material</option>
                                <option value="2">Insumo</option>
                                <option value="3">Productos</option>
                            </select>
                        </div>
                    </div>
                    <div id="tipo_material_detail" class="form-text text-primary">We'll never share your details with anyone else.</div>
                </div>
                <div class="col-lg-12 col-12">
                    <label class="fw-bold form-label text-capitalize" for="nombre">Nombre del Material</label>
                    <input type="text" class="form-control" id="nombre" name="nombre">
                </div>
                <div class="col-12 col-lg-6 mb-3 mb-md-0">
                    <label class="fw-bold form-label text-capitalize" for="modelo">Modelo</label>
                    <input type="text" class="form-control" id="modelo" name="modelo">
                </div>
                <div class="col-12 col-lg-6 mb-3 mb-md-0">
                    <label class="fw-bold form-label text-capitalize" for="codigo_ucss">Código UCSS</label>
                    <input type="text" class="form-control" id="codigo_ucss" name="codigo_ucss">
                </div>
                <div class="col-12">
                    <label class="fw-bold form-label text-capitalize" for="codigo_ucss">Observaciones</label>
                    <textarea name="observaciones" id="observaciones" class="form-control"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">
                    <i class='bx bx-x-circle me-1'></i>
                    <span>Cancelar</span>
                </button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary">
                    <i class='bx bx-check-double me-1'></i>
                    <span>Guardar</span>
                </button>
            </div>
        </form>
    </div>
</div>