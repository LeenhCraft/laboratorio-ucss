<div class="modal fade" id="mdlOcurrencias" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <form id="formOcurrencia" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title title-laboratorio">
                    <i class="fa-solid fa-flask-vial me-1"></i>
                    <span>Registrar Nueva Ocurrencia</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="idocurrencia" id="idocurrencia">
                <input type="hidden" name="idingreso" id="idingreso">
                <div class="row">
                    <div class="col-12">
                        <label class="fw-bold form-label text-capitalize" for="titulo_practica">Titulo de la practica <span class="text-danger fw-bold">*</span></label>
                        <select name="titulo_practica" id="titulo_practica" class="form-select">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="mt-3">
                        <p id="v_titulo" class="p-0 m-0 fw-semibold fs-5 text-info"></p>
                        <div class="d-flex align-items-center gap-2 text-black fs-normal">
                            <i class="bx bx-time"></i>
                            <span class="fw-semibold">Fecha Ingreso:</span> <span class="v_fecha"></span>
                        </div>
                        <div class="d-flex align-items-center gap-2 text-black fs-normal">
                            <i class="bx bx-user"></i>
                            <span class="fw-semibold">Docente:</span> <span class="v_docente"></span>
                        </div>
                    </div>
                    <hr class="my-3">
                    <div class="col-12 col-lg-6">
                        <label class="fw-bold form-label text-capitalize" for="estudiante">Estudiante(s) <span class="text-danger fw-bold">*</span></label>
                        <input id="estudiante" name="estudiante" type="text" class="form-control">
                    </div>
                    <div class="col-12 col-lg-6">
                        <label class="fw-bold form-label text-capitalize" for="asignatura">Asignatura <span class="text-danger fw-bold">*</span></label>
                        <input id="asignatura" type="text" class="form-control" disabled>
                    </div>
                    <div class="col-12 col-lg-6">
                        <label class="fw-bold form-label text-capitalize" for="estudiante">Estado <span class="text-danger fw-bold">*</span></label>
                        <select name="idestado" id="idestado" class="form-select">
                            <option value="">Seleccione una opción</option>
                            <option value="1">Atendido</option>
                            <option value="2">Pendiente</option>
                            <option value="3">Completado</option>
                        </select>
                    </div>
                    <div class="col-12 col-lg-6">
                        <label class="fw-bold form-label text-capitalize" for="asignatura">Severidad <span class="text-danger fw-bold">*</span></label>
                        <select name="idseveridad" id="idseveridad" class="form-select">
                            <option value="">Seleccione una opción</option>
                            <option value="1">Baja</option>
                            <option value="2">Media</option>
                            <option value="3">Alta</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="fw-bold form-label text-capitalize" for="descripcion">Incidente <span class="text-danger fw-bold">*</span></label>
                        <textarea name="descripcion" id="descripcion" class="form-control"></textarea>
                    </div>
                    <hr class="my-3">
                    <div class="col-8 mb-3">
                        <label class="fw-bold form-label text-capitalize" for="material">Materiales <span class="text-danger fw-bold">*</span></label>
                        <select id="material" class="form-select">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-2 mb-3 ps-0">
                        <label class="fw-bold form-label text-capitalize" for="material">Cantidad <span class="text-danger fw-bold">*</span></label>
                        <input id="cantidad_afectado" type="number" class="form-control" value="1" min="1">
                    </div>
                    <div class="col-2 mb-3 d-flex align-items-end p-0">
                        <button type="button" id="addMaterial" class="btn btn-outline-primary fw-semibold">
                            <i class="fa-solid fa-plus me-1"></i>
                            <span>Agregar</span>
                        </button>
                    </div>
                    <div class="col-12">
                        <table id="lista-materiales" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Material</th>
                                    <th>Cantidad</th>
                                    <th>Unidad</th>
                                    <th>Observaciones</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary fw-normal" data-bs-dismiss="modal">
                    <i class="fa-regular fa-circle-xmark me-2"></i>
                    <span>Cerrar</span>
                </button>
                <button type="submit" class="btn btn-primary fw-semibold">
                    <i class="fa-solid fa-shield-halved me-2"></i>
                    <span>
                        Guardar
                    </span>
                </button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="mdlVerOcurrencias" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detalles de la Ocurrencia</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="p-4 border-bottom">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div>
                            <p class="p-0 m-0 fw-bold fs-5 text-secondary">
                                
                            </p>
                            <div class="d-flex align-items-center gap-2 text-black fs-normal">
                                <i class="bx bx-time"></i>
                                <span></span>
                            </div>
                        </div>
                        <div>
                            <div class="d-flex flex-column align-items-end gap-2">
                                <span class="px-2 py-1 rounded-2 fw-semibold badge bg-label-warning">
                                    Pendiente
                                </span>
                                <span class="px-2 py-1 rounded-2 fw-semibold badge bg-label-success">
                                    Severidad Baja
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="px-4 pt-2 pb-4 my-3 gap-2 d-flex flex-column border-bottom">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bx bx-user text-info"></i>
                        <span>
                            Estudiante:
                        </span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bx bx-user text-info"></i>
                        <span>
                            Docente:
                        </span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bx bx-book-open text-primary"></i>
                        <span>
                            Curso:
                        </span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bx bxs-bell-ring text-warning"></i>
                        <span>
                        </span>
                    </div>
                </div>
                <div class="text-nowrap">
                    <table id="ver-materiales" class="table table-striped">
                        <thead>
                            <tr>
                                <th>Material</th>
                                <th>Cantidad</th>
                                <th>Observaciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary fw-normal" data-bs-dismiss="modal">
                    <i class="fa-regular fa-circle-xmark me-2"></i>
                    <span>Cerrar</span>
                </button>
                <button type="button" class="btn btn-primary" id="btnGenerarPDF">
                    <i class="bx bx-file-pdf me-2"></i>
                    Ver PDF
                </button>
            </div>
        </div>
    </div>
</div>