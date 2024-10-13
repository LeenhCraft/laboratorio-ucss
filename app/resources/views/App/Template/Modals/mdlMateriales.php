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
                <div>
                    <div class="row">
                        <div class="col-12 col-lg-6">
                            <label class="fw-bold form-label text-capitalize" for="idtipomaterial">Tipo de material</label>
                            <select name="idtipomaterial" id="idtipomaterial" class="form-select" aria-describedby="tipo_material_detail">
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
                    <label class="fw-bold form-label text-capitalize" for="codigo_ucss">Código</label>
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

<div class="modal fade" id="mdlInventario" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form id="frmInventario" class="modal-content">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title text-primary fw-semibold" id="modal-title">
                    <i class='bx bx-transfer me-1'></i>
                    Ingresos - Nuevo Ingreso
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-2">
                    <div class="col-12 col-lg-4">
                        <label class="fw-bold form-label text-capitalize" for="fecha_ingreso">Fecha Ingreso</label>
                        <input id="fecha_ingreso" name="fecha_ingreso" type="date" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 col-lg-4 mb-2">
                        <label for="motivo_ingreso" class="fw-bold form-label text-capitalize">Motivo Ingreso</label>
                        <select name="motivo_ingreso" id="motivo_ingreso" class="form-select">
                            <option value="1">Seleccionar</option>
                            <option value="2">Compras</option>
                            <option value="3">Devolución</option>
                            <option value="4">Inventario</option>
                            <option value="5">No especificado</option>
                            <option value="6">Transferencia</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-4 mb-2">
                        <label for="tipo_documento" class="fw-bold form-label text-capitalize">Tipo Documento</label>
                        <select name="tipo_documento" id="tipo_documento" class="form-select">
                            <option value="1">Seleccionar</option>
                            <option value="2">Cargo</option>
                            <option value="3">No especificado</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-12">
                        <label for="observaciones" class="fw-bold form-label text-capitalize">Observaciones</label>
                        <textarea name="observaciones" id="observaciones" class="form-control"></textarea>
                    </div>
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