<?php headerApp('Template/header_dash', $data); ?>
<style>
    /* Estilos para filas canceladas */
    .cancelled-row {
        position: relative !important;
    }

    .cancelled-banner {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        background-color: #dc3545;
        color: white;
        padding: 4px 8px;
        z-index: 1;
    }

    .cancelled-content {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.875rem;
        font-weight: 500;
    }

    .cancelled-text {
        margin-left: 4px;
    }

    /* Ajustar el padding de las celdas en filas canceladas */
    .cancelled-row td {
        padding-top: 40px !important;
    }

    /* Asegurar que el contenido de la celda esté por encima de la franja */
    .cancelled-row td>*:not(.cancelled-banner) {
        position: relative;
        z-index: 2;
    }
</style>
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