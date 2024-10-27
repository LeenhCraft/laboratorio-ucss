<?php headerApp('Template/header_dash', $data); ?>
<div class="card">
    <div class="card-header">
        <h4 class="fs-2 text-center">Ingreso Laboratorio UCSS</h4>

        <?php
        if ($data['permisos']['perm_w'] == 1) :
        ?>
            <button id="btnNuevo" class="btn btn-primary fw-semibold" type="button">
                <i class='bx bx-plus-circle me-2'></i> Nuevo
            </button>
        <?php
        endif;
        ?>
    </div>
    <div class="table-responsive text-nowrap mb-4">
        <table id="tbl" class="table" width="100%">
            <thead>
                <tr>
                    <th></th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Docente</th>
                    <th>Practica</th>
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
    getModal('mdlLaboratorio', $data);
}
footerApp('Template/footer_dash', $data);
?>