<div class="modal fade" id="mdlIngresos" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmIngresos" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title title-ingresos text-primary fw-semibold">
                    <i class='bx bx-transfer me-1'></i>
                    Ingresos - Nuevo Ingreso
                    <span></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="id" name="id" value="">
                <div>
                    <button id="limpiar" class="btn btn-outline-primary btn-sm text-primary" type="button">
                        <i class='bx bxs-brush'></i>
                    </button>
                </div>
                <hr class="my-2">
                <div class="row mb-2">
                    <div class="col-12 col-lg-6">
                        <label class="fw-bold form-label text-capitalize" for="fecha_ingreso">Fecha Ingreso</label>
                        <input id="fecha_ingreso" name="fecha_ingreso" type="date" class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 col-lg-6 mb-2">
                        <label for="motivo_ingreso" class="fw-bold form-label text-capitalize">Motivo Ingreso</label>
                        <select name="motivo_ingreso" id="motivo_ingreso" class="form-select">
                            <option value="0">Seleccione una opcion</option>
                            <option value="1">Compras</option>
                            <option value="2">Devolución</option>
                            <option value="3">Inventario</option>
                            <option value="4">No especificado</option>
                            <option value="5">Transferencia</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-6 mb-2">
                        <label for="tipo_documento" class="fw-bold form-label text-capitalize">Tipo Documento</label>
                        <select name="tipo_documento" id="tipo_documento" class="form-select">
                            <option value="0">Seleccione una opcion</option>
                            <option value="1">Cargo</option>
                            <option value="2">No especificado</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-12">
                        <label for="observaciones" class="fw-bold form-label text-capitalize">Observaciones</label>
                        <textarea name="observaciones" id="observaciones" class="form-control"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class='bx bx-x-circle me-1'></i>
                    <span>Cerrar</span>
                </button>
                <button id="btnActionForm" type="submit" class="btn btn-primary">
                    <i class='bx bx-check-double me-1'></i>
                    <span>Guardar</span>
                </button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="mdlAgregar" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form id="frmIngresosArticulos" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary fw-semibold" id="modal-title">
                    <i class='bx bx-transfer me-1'></i>
                    <span class="title-text">Agregar Articulos</span> <span class="title-text-2"></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="idingreso" name="idingreso">
                <div class="row">
                    <div class="col-12 col-lg-8">
                        <label for="lista_articulos" class="form-label text-capitalize">Producto:</label>
                        <select name="lista_articulos" id="lista_articulos" class="form-select">
                            <option value="0">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-4">
                        <label for="estado_articulos" class="form-label text-capitalize">Estado Producto:</label>
                        <select name="estado_articulos" id="estado_articulos" class="form-select">
                            <option value="0">Seleccione una opción</option>
                        </select>
                    </div>
                    <hr class="m-0 my-3 ">
                    <div class="col-12 col-lg-4">
                        <label for="und_medida" class="form-label text-capitalize">Und Medida:</label>
                        <select name="und_medida" id="und_medida" class="form-select">
                            <option value="0">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-2">
                        <label for="cantidad" class="form-label text-capitalize">Cantidad:</label>
                        <input type="number" class="form-control" name="cantidad" id="cantidad" value="1">
                    </div>
                    <div class="col-12 col-lg-2">
                        <label for="factor" class="form-label text-capitalize">Factor: <span class="text-danger fw-bold">*</span> </label>
                        <input type="number" class="form-control" name="factor" id="factor" value="1">
                    </div>
                    <div class="col-12 col-lg-3 mb-3">
                        <label for="fecha_vencimiento" class="form-label text-capitalize">Fecha Vencimiento:</label>
                        <input type="date" class="form-control" name="fecha_vencimiento" id="fecha_vencimiento">
                    </div>
                    <div class="col-12 col-lg-auto mb-3 d-flex align-items-end p-0">
                        <button id="cargar_fecha_hoy" class="btn p-0 mb-2 text-info" type="button" title="Cargar la fecha de hoy">
                            <i class='bx bxs-magic-wand bx-sm'></i>
                        </button>
                        <button id="limpiar_fecha_hoy" class="btn p-0 mb-2 text-warning" type="button" title="Limpiar la fecha de hoy">
                            <i class='bx bxs-brush-alt bx-sm'></i>
                        </button>
                    </div>
                    <div class="col-12 col-lg-6">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class='bx bx-check-double me-1'></i>
                            <span>Agregar</span>
                        </button>
                        <button type="button" class="btn btn-outline-secondary border-0" onclick="resetFormArt()">
                            <i class='bx bxs-brush-alt me-2'></i>
                            <span>Limpiar</span>
                        </button>
                    </div>
                    <hr class="my-3">
                    <p class="fw-normal text-primary">
                        <span class="text-danger fw-bold">*</span> El Factor es la cantidad de unidades que conforman un paquete o grupo.
                    </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class='bx bx-x-circle me-1'></i>
                    <span>Cerrar</span>
                </button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="mdlVer" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <form id="frmIngresosArticulos" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title title-articulos-ingreso text-primary fw-semibold">
                    <span>Articulos del Ingreso N° </span>
                    <span class="ver-articulos-ingreso"></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive text-nowrap mb-4 min-h-52">
                    <table id="tbl2" class="table table-striped min-h-52" width="100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Articulo</th>
                                <th>Cantidad</th>
                                <th>Estado</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div>
                    <p class="text-primary fw-semibold">
                        <span class="fw-bold text-danger">*</span> Solo se podra eliminar los articulos que no han sido utilizados o no hallan sido asignados a un prestamo.
                    </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                    <i class='bx bx-x-circle me-1'></i>
                    <span>Cerrar</span>
                </button>
            </div>
        </form>
    </div>
</div>