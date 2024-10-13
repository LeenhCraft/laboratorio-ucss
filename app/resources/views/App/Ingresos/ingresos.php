<?php headerApp('Template/header_dash', $data); ?>
<div class="card">
    <div class="card-header d-flex justify-content-end">
        <?php
        if ($data['permisos']['perm_w'] == 1) :
        ?>
            <button id="btnNuevo" class="btn btn-primary fw-bold" type="button">
                <i class='bx bx-plus-circle me-1'></i>
                <span>
                    Nuevo Ingreso
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
                    <th></th>
                    <th>Periodo</th>
                    <th>Código</th>
                    <th>Fec. Ing.</th>
                    <th>Tip. Pago</th>
                    <th>Datos Ingreso</th>
                    <th>Importe</th>
                    <th>Pagos</th>
                    <th>Deudas</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<?php
if ($data['permisos']['perm_w'] == 1 || $data['permisos']['perm_u'] == 1) {
    // getModal('mdlMateriales', $data);
}
footerApp('Template/footer_dash', $data);
?>