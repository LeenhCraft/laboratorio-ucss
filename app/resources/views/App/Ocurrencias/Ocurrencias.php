<?php headerApp('Template/header_dash', $data); ?>
<style>
    #descripcion {
        max-height: 200px;
    }
</style>
<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="m-0 p-0 me-4">Ocurrencias - Sala de Enfermería UCSS</h3>
    <button id="nuevoRegistro" class="btn btn-primary ms-4 fw-semibold" type="button">
        <i class='bx bx-plus me-1'></i> Nueva Ocurrencia
    </button>
</div>

<form id="filtros" class="d-flex gap-2 align-items-center justify-content-start my-4">
    <div class="col-6 col-lg-4">
        <input id="filt_search" name="search" type="text" class="form-control" placeholder="Buscar...">
    </div>
    <select name="estados" id="filt_estados" class="form-select border w-auto">
        <option value="">Todos los estados</option>
        <option value="1">Atendido</option>
        <option value="2">Pendiente</option>
        <option value="3">Completado</option>
    </select>
    <select name="severidad" id="filt_severidad" class="form-select border w-auto">
        <option value="">Todas las severidades</option>
        <option value="1">Baja</option>
        <option value="2">Media</option>
        <option value="3">Alta</option>
    </select>
    <button id="btn_filt" type="button" class="btn btn-outline-primary">
        <i class='bx bx-search'></i>
    </button>
</form>

<div class="borderr p-2 rounded-2">

    <div class="col-12 p-0 m-0">
        <table id="tbl" width="100%">
            <thead>
                <tr>
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
    getModal('mdlOcurrencias', $data);
}
footerApp('Template/footer_dash', $data);
?>