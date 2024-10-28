<?php

namespace App\Controllers\Clases;

use App\Controllers\Controller;
use App\Models\TableModel;
use Exception;

class BalanceClass extends Controller
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
        $existe = $model->query("SELECT * FROM lab_balance_inventarios WHERE $whereClause", $params)->first();
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
                "stock_total" => 0,
            ];

            // Verificar si se trata de unidades sueltas (2) o cajas (3)
            if (in_array($data["idmedida"], [2, 3])) {
                // Determinar si es una caja
                $isCaja = $data["idmedida"] == 3;

                // Actualizar el stock correspondiente (cajas o unidades sueltas)
                $dataInsert["stock_" . ($isCaja ? "cajas" : "unidades_sueltas")] = $data["cantidad"];

                // Actualizar el factor de caja si es necesario
                $dataInsert["factor_caja"] = $isCaja ? $data["factor"] : 0;

                // Calcular el stock total
                $dataInsert["stock_total"] = $isCaja ? $data["cantidad"] * $data["factor"] : $data["cantidad"];
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

                // Calcular el stock total
                "stock_total" => $existe["stock_total"] + ($isCaja ? $data["cantidad"] * $data["factor"] : $data["cantidad"]),

                // Actualizar la fecha de última actualización
                "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
            ];

            // Realizar la actualización en la base de datos
            $response = $model->update($existe["idbalance"], $dataUpdate);
        }
        return [
            'status' => true,
            'message' => 'Stock actualizado correctamente',
            'data' => $response
        ];
    }

    public function agregarStock($data)
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
        $existe = $model->query("SELECT * FROM lab_balance_inventarios WHERE $whereClause", $params)->first();
        $isCaja = $data["idmedida"] == 3;
        $dataUpdate = [
            // Actualizar stock de cajas: Si es caja, restar la cantidad; si no, mantener el valor actual
            "stock_cajas" => $existe["stock_cajas"] - ($isCaja ? $data["cantidad"] : 0),

            // Actualizar stock de unidades sueltas: Si no es caja, restar la cantidad; si es caja, mantener el valor actual
            "stock_unidades_sueltas" => $existe["stock_unidades_sueltas"] - ($isCaja ? 0 : $data["cantidad"]),

            // Actualizar factor de caja: Si es caja, usar el nuevo factor; si no, mantener el factor existente
            "factor_caja" => $isCaja ? $data["factor"] : $existe["factor_caja"],

            // Calcular el stock total
            "stock_total" => $existe["stock_total"] - ($isCaja ? $data["cantidad"] * $data["factor"] : $data["cantidad"]),

            // Actualizar la fecha de última actualización
            "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
        ];

        // Realizar la actualización en la base de datos
        return $model->update($existe["idbalance"], $dataUpdate);
    }

    public function reponerStockPrestamo($data)
    {
        // en $data viene el idbalance y la cantidad a reponer
        // primero se debe obtener el registro del balance de inventario
        $model = new TableModel;
        $model->setTable("lab_balance_inventarios");
        $model->setId("idbalance");
        $existe = $model
            ->where("idbalance", $data["idbalance"])
            ->first();
        if (!$existe) {
            return [
                'status' => false,
                'message' => 'No hay registro de stock para este item'
            ];
        }
        // la cantidad a reponer esta en unidades sueltas
        $dataUpdate = [
            // Actualizar stock de unidades sueltas: Sumar la cantidad
            "stock_unidades_sueltas" => $existe["stock_unidades_sueltas"] + $data["reponer_cantidad"],

            // Calcular el stock total
            "stock_total" => $existe["stock_total"] + $data["reponer_cantidad"],

            // Actualizar la fecha de última actualización
            "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
        ];

        // Realizar la actualización en la base de datos
        $respuesta = $model->update($existe["idbalance"], $dataUpdate);
        if (!empty($respuesta)) {
            return [
                'status' => true,
                'message' => 'Stock repuesto correctamente',
                "idbalance" => $existe["idbalance"],
            ];
        }
        return [
            'status' => false,
            'message' => 'Error al reponer el stock'
        ];
    }

    public function quitarStockPrestamo($data)
    {
        // Verificamos que tengamos todos los datos necesarios
        if (
            !isset($data['status']) || !isset($data['cajas_necesarias']) || !isset($data['unidades_necesarias']) ||
            !isset($data['stock_restante_cajas']) || !isset($data['stock_restante_unidades']) || !isset($data['idbalance'])
        ) {
            return [
                'status' => false,
                'message' => 'Faltan datos necesarios para actualizar el stock'
            ];
        }

        $model = new TableModel;
        $model->setTable("lab_balance_inventarios");
        $model->setId("idbalance");
        $existe = $model
            ->where("idbalance", $data["idbalance"])
            ->first();
        if (!$existe) {
            return [
                'status' => false,
                'message' => 'No hay registro de stock para este item'
            ];
        }

        // Verificamos que el balance exista y coincida con los datos proporcionados
        try {
            // Actualizamos el stock en la base de datos
            $actualizacion = $model->update($data['idbalance'], [
                'stock_cajas' => $data['stock_restante_cajas'],
                'stock_unidades_sueltas' => $data['stock_restante_unidades'],
                'stock_total' => ($data['stock_restante_cajas'] * $existe['factor_caja']) + $data['stock_restante_unidades'],
                'fecha_ultima_actualizacion' => date('Y-m-d H:i:s')
            ]);

            if ($actualizacion) {
                // // Registramos el movimiento en el historial (opcional, si tienes una tabla de movimientos)
                // $modelHistorial = new TableModel;
                // $modelHistorial->setTable("lab_historial_movimientos_inventario");
                // $modelHistorial->insert([
                //     'idbalance' => $data['idbalance'],
                //     'tipo_movimiento' => 'SALIDA',
                //     'cajas' => $data['cajas_necesarias'],
                //     'unidades' => $data['unidades_necesarias'],
                //     'stock_anterior_cajas' => $existe['stock_cajas'],
                //     'stock_anterior_unidades' => $existe['stock_unidades_sueltas'],
                //     'stock_nuevo_cajas' => $data['stock_restante_cajas'],
                //     'stock_nuevo_unidades' => $data['stock_restante_unidades'],
                //     'motivo' => 'Préstamo',
                //     'fecha_registro' => date('Y-m-d H:i:s'),
                //     'usuario' => $data['usuario'] ?? null // Si tienes el usuario que realiza la operación
                // ]);

                return [
                    'status' => true,
                    'message' => 'Stock actualizado correctamente',
                    'data' => [
                        'cajas_descontadas' => $data['cajas_necesarias'],
                        'unidades_descontadas' => $data['unidades_necesarias'],
                        'nuevo_stock_cajas' => $data['stock_restante_cajas'],
                        'nuevo_stock_unidades' => $data['stock_restante_unidades']
                    ]
                ];
            } else {
                return [
                    'status' => false,
                    'message' => 'Error al actualizar el stock'
                ];
            }
        } catch (Exception $e) {
            return [
                'status' => false,
                'message' => 'Error en la operación: ' . $e->getMessage()
            ];
        }
    }

    public function verificarStock($data)
    {
        $model = new TableModel;
        $model->setTable("lab_balance_inventarios");
        $model->setId("idbalance");
        $existe = $model
            ->where("idbalance", $data["idbalance"])
            ->first();
        if (!$existe) {
            return [
                'status' => false,
                'message' => 'No hay registro de stock para este item'
            ];
        }
        $cantidadSolicitada = $data['cantidad_solicitada'];
        $stockDisponible = $existe['stock_unidades_sueltas'];
        $cajasNecesarias = 0;
        while ($stockDisponible < $cantidadSolicitada && $existe['stock_cajas'] > 0) {
            $stockDisponible += $existe['factor_caja'];
            $cajasNecesarias++;
            if ($cajasNecesarias > $existe['stock_cajas']) {
                return [
                    'status' => false,
                    'message' => 'No hay stock suficiente. Stock disponible: ' .
                        ($existe['stock_unidades_sueltas'] + ($existe['stock_cajas'] * $existe['factor_caja'])) .
                        ' unidades'
                ];
            }
        }
        if ($stockDisponible < $cantidadSolicitada) {
            return [
                'status' => false,
                'message' => 'No hay stock suficiente. Stock disponible: ' . $stockDisponible . ' unidades'
            ];
        }
        $unidadesNecesarias = $cantidadSolicitada;
        $resultado = [
            'status' => true,
            'cajas_necesarias' => $cajasNecesarias,
            'unidades_necesarias' => $unidadesNecesarias,
            'stock_restante_cajas' => $existe['stock_cajas'] - $cajasNecesarias,
            'stock_restante_unidades' => $stockDisponible - $cantidadSolicitada
        ];

        return $resultado;

        // en $existe viene el stock unitarioy el stock por cajas
        // ahora para verificar el stock primero debemos verificar el stock por unidades si no alcanza
        // agarrar de stock por cajas y convertir una caja a unidades y volver a verificar si alcanza
        // repetimos le proceso de convertir cajas a unidades hasta que alcance el stock siempre y cuando
        // el stock por cajas sea mayor a 0, pero si no hay stock en cajas y no alcanza el stock por unidades
        // entonces no hay stock suficiente y retorna false y el mensaje de que no hay stock suficiente
        // estructura de los datos en $existe
        /* Array
        (
            [idbalance] => 1
            [idproducto] => 
            [idinsumo] => 1
            [idmaterial] => 
            [stock_cajas] => 0
            [stock_unidades_sueltas] => 1
            [stock_total] => 1
            [factor_caja] => 0
            [fecha_ultima_actualizacion] => 2024-10-15 15:38:43
            [fecha_registro] => 2024-10-15 15:38:43
        ) */
    }

    public function quitarStockIngresos($data)
    {
        $model = new TableModel;
        $model->setTable("lab_balance_inventarios");
        $model->setId("idbalance");
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
        $existe = $model->query("SELECT * FROM lab_balance_inventarios WHERE $whereClause", $params)->first();
        if (!$existe) {
            return [
                'status' => false,
                'message' => 'No hay registro de stock para este item'
            ];
        }
        // descuenta la cantidad de stock
        $isCaja = $data["idmedida"] == 3;
        $dataUpdate = [
            // Actualizar stock de cajas: Si es caja, restar la cantidad; si no, mantener el valor actual
            "stock_cajas" => $existe["stock_cajas"] - ($isCaja ? $data["cantidad"] : 0),

            // Actualizar stock de unidades sueltas: Si no es caja, restar la cantidad; si es caja, mantener el valor actual
            "stock_unidades_sueltas" => $existe["stock_unidades_sueltas"] - ($isCaja ? 0 : $data["cantidad"]),

            // Actualizar factor de caja: Si es caja, usar el nuevo factor; si no, mantener el factor existente
            "factor_caja" => $isCaja ? $data["factor"] : $existe["factor_caja"],

            // Calcular el stock total
            "stock_total" => $existe["stock_total"] - ($isCaja ? $data["cantidad"] * $data["factor"] : $data["cantidad"]),

            // Actualizar la fecha de última actualización
            "fecha_ultima_actualizacion" => date("Y-m-d H:i:s"),
        ];

        // Realizar la actualización en la base de datos
        $respuesta = $model->update($existe["idbalance"], $dataUpdate);
        if ($respuesta) {
            return [
                'status' => true,
                'message' => 'Stock actualizado correctamente',
                "idbalance" => $existe["idbalance"],
            ];
        }
        return [
            'status' => false,
            'message' => 'Error al actualizar el stock'
        ];
    }
}
