<?php headerApp('Template/header_dash', $data); ?>
<div class="card mb-4">
    <div class="card-body">
        <form id="filtros">
            <div class="row">
                <div class="col-12 col-lg-2 mb-4 mb-lg-0">
                    <label for="tipo_material" class="form-label">Tipo de Material</label>
                    <select class="form-select" id="tipo_material" name="tipo_material" aria-label="Default select example">
                        <option value="1" selected>Todos</option>
                        <option value="2">Insumos</option>
                        <option value="3">Materiales</option>
                        <option value="4">Productos</option>
                    </select>
                </div>
                <div class="col-12 col-lg-2 mb-4 mb-lg-0">
                    <label for="condicion_material" class="form-label">Condicion del Material</label>
                    <select class="form-select" id="condicion_material" name="condicion_material" aria-label="Default select example">
                        <option value="1" selected>Todos</option>
                        <option value="2">Buenos</option>
                        <option value="3">Regulares</option>
                        <option value="4">Dañados</option>
                    </select>
                </div>
                <div class="col-12 col-lg-auto mb-4 mb-lg-0 d-flex align-items-end">
                    <button class="btn btn-outline-primary m-lg-0 px-lg-2 py-lg-1 w-100" type="submit">
                        <i class='bx bx-search-alt-2 me-2'></i>
                        <span>
                            Filtrar Materiales
                        </span>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="card">
    <div class="card-header d-flex justify-content-end">
        <?php
        if ($data['permisos']['perm_w'] == 1) :
        ?>
            <button id="btnNuevo" class="btn btn-primary fw-bold" type="button">
                <i class='bx bx-plus-circle me-1'></i>
                <span>
                    Nuevo Material
                </span>
            </button>
        <?php
        endif;
        ?>
    </div>
    <div class="table-responsive text-nowrap mb-4 min-h-52">
        <table id="tbl" class="table table-hover min-h-52" width="100%">
            <thead>
                <tr>
                    <th>n°</th>
                    <th>Código UCSS</th>
                    <th>Tipo</th>
                    <th>Material</th>
                    <th>stock</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<?php
if ($data['permisos']['perm_w'] == 1 || $data['permisos']['perm_u'] == 1) {
    getModal('mdlMateriales', $data);
}
footerApp('Template/footer_dash', $data);
?>