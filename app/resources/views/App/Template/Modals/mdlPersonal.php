<div class="modal fade" id="addModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <form id="person_form" name="form" class="form-horizontal" onsubmit="return save(this,event)" enctype="multipart/form-data">
            <input id="id" name="id" type="hidden">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleModal">Nuevo personal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="user-avatar-section">
                                <div class="position-relative d-flex align-items-center flex-column border rounded">
                                    <img class="mostrarimagen img-fluid rounded my-4 cursor-pointer" src="/img/placeholder-150x150.png" height="110" width="110" alt="User avatar">
                                    <input class="position-absolute w-100 h-100 opacity-0 cursor-pointer" type="file" accept="image/png,image/jpeg" onchange="viewImg(this,event)" name="photo" id="photo">
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-12 col-md-5" id="divBsc">
                            <label for="">DNI: </label>
                            <div class="input-group">
                                <input id="dni" name="dni" type="text" class="form-control" placeholder="000000000">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-primary" type="button" style="border-top-left-radius: 0; border-bottom-left-radius: 0;"><i class='bx bx-search-alt-2'></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="form-group col-12">
                            <label for="name">Nombre:</label>
                            <input id="name" name="name" type="text" class="form-control">
                        </div>
                        <div class="form-group col-12 mt-3">
                            <label for="email">Email:</label>
                            <input id="email" name="email" type="email" class="form-control">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="form-group col-12 col-md-6">
                            <label for="phone" class="text-capitalize">celular:</label>
                            <input id="phone" name="phone" type="number" class="form-control">
                        </div>
                        <div class="form-group col-12 col-md-6">
                            <label for="status" class="text-capitalize">Estado:</label>
                            <select name="status" id="status" class="form-control">
                                <option value="">Seleccione</option>
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <label for="address">Direccion: </label>
                            <input id="address" name="address" type="text" class="form-control">
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline-secondary text-capitalize fw-bold" type="button" data-bs-dismiss="modal">
                        <span class="text-capitalize">cerrar</span>
                    </button>
                    <button id="btnActionForm" class="btn btn-primary fw-bold" type="submit">
                        <span id="btnText">Guardar</span>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>