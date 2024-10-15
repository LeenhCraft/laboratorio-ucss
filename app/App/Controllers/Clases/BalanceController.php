<?php

namespace App\Controllers\Clases;

use App\Controllers\Controller;
use App\Models\TableModel;

class BalanceController extends Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function nuevoRegistro($data)
    {
        $model = new TableModel;
        $model->setTable("lab_balance_inventarios");
        $model->setId("idbalance");
        // verificar si el articulo ya existe
        $where = [];
        $params = [];
        $fields = ['idproducto', 'idinsumo', 'idmaterial'];
        foreach ($fields as $field) {
            if (empty($data[$field])) {
                $where[] = "$field IS NULL";
            } else {
                $where[] = "$field = ?";
                $params[] = $data[$field];
            }
        }
        $whereClause = implode(' AND ', $where);
        $existe = $model->query("SELECT * FROM lab_balance_inventarios WHERE $whereClause", $params)->get();
        // si no existe, se crea un nuevo registro
        if (empty($existe)) {
            // Preparar los datos para insertar un nuevo registro
            $dataInsert = [
                "idproducto" => $data["idproducto"],
                "idinsumo" => $data["idinsumo"],
                "idmaterial" => $data["idmaterial"],
                "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
                // Inicializar valores por defecto
                "stock_cajas" => 0,
                "stock_unidades_sueltas" => 0,
                "factor_caja" => 0,
            ];

            // Verificar si se trata de unidades sueltas (2) o cajas (3)
            if (in_array($data["idmedida"], [2, 3])) {
                // Determinar si es una caja
                $isCaja = $data["idmedida"] == 3;

                // Actualizar el stock correspondiente (cajas o unidades sueltas)
                $dataInsert["stock_" . ($isCaja ? "cajas" : "unidades_sueltas")] = $data["cantidad"];

                // Actualizar el factor de caja si es necesario
                $dataInsert["factor_caja"] = $isCaja ? $data["factor"] : 0;
            }

            // Crear el nuevo registro en la base de datos
            $response = $model->create($dataInsert);
        }

        // si existe, se actualiza el registro
        if (!empty($existe)) {
            // Determinar si estamos tratando con cajas (true) o unidades sueltas (false)
            $isCaja = $data["idmedida"] == 3;

            $dataUpdate = [
                // Actualizar stock de cajas: Si es caja, sumar la cantidad; si no, mantener el valor actual
                "stock_cajas" => $existe["stock_cajas"] + ($isCaja ? $data["cantidad"] : 0),

                // Actualizar stock de unidades sueltas: Si no es caja, sumar la cantidad; si es caja, mantener el valor actual
                "stock_unidades_sueltas" => $existe["stock_unidades_sueltas"] + ($isCaja ? 0 : $data["cantidad"]),

                // Actualizar factor de caja: Si es caja, usar el nuevo factor; si no, mantener el factor existente
                "factor_caja" => $isCaja ? $data["factor"] : $existe["factor_caja"],

                // Actualizar la fecha de última actualización
                "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
            ];

            // Realizar la actualización en la base de datos
            $response = $model->update($existe["idbalance"], $dataUpdate);
        }
        return $response;
    }
}
