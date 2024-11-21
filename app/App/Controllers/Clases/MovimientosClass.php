<?php

namespace App\Controllers\Clases;

use App\Models\TableModel;

class MovimientosClass
{
    /* 
    los diferentes tipos de movimientos (tipo_movimiento) son:
    1 = Ingreso
    0 = Salida

    los diferentes tipos de detalle (tipo_detalle) son:
    1 = por Inventario
    2 = por Prestamo
    3 = por Devolucion
    4 = por Ajuste
    5 = por Perdida
    6 = por Donacion
    7 = por Venta
    8 = por Otro
     */

    public function store($data)
    {
        $model = new TableModel;
        $model->setTable("lab_movimientos");
        $model->setId("idmovimiento");
        $model->create(
            [
                "idbalance" => $data["idbalance"],
                "idusuario" => $_SESSION["app_id"],
                "idinventariodetalle" => $data["idinventariodetalle"],
                "tipo_movimiento" => $data["tipo_movimiento"],
                "tipo_detalle" => $data["tipo_detalle"],
                "idmedida" => $data["idmedida"],
                "cantidad" => $data["cantidad"],
                "factor" => $data["factor"],
                "fecha_movimiento" => date("Y-m-d H:i:s"),
                "observaciones" => $data["observaciones"],
            ]
        );
    }
}
