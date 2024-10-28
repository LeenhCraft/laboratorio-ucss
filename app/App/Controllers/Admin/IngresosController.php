<?php

namespace App\Controllers\Admin;

use App\Controllers\Clases\BalanceClass;
use App\Controllers\Clases\MovimientosClass;
use App\Controllers\Controller;
use App\Models\TableModel;
use Exception;
use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

class IngresosController extends Controller
{
    protected $permisos = [];
    protected $responseFactory;
    protected $guard;

    public function __construct()
    {
        parent::__construct();
        $this->permisos = getPermisos($this->className($this));
    }

    public function index($request, $response)
    {
        return $this->render($response, 'App.Ingresos.ingresos', [
            'titulo_web' => 'Ingresos',
            "url" => $request->getUri()->getPath(),
            "permisos" => $this->permisos,
            "css" => [
                "vendor/select2/select2/dist/css/select2.min.css",
                'node_modules/flatpickr/dist/flatpickr.min.css',
                "css/select2-custom.css",
            ],
            "js" => [
                "vendor/select2/select2/dist/js/select2.min.js",
                'node_modules/flatpickr/dist/flatpickr.min.js',
                'node_modules/flatpickr/dist/l10n/es.js',
                'node_modules/autosize/dist/autosize.js',
                "js/app/nw_ingresos.js"
            ],
        ]);
    }

    public function list($request, $response, $args = [], $ignorePermissions = false)
    {
        if (!$ignorePermissions && $this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");
        $arrData = $model
            ->orderBy("fecha_ingreso", "DESC")
            ->orderBy("idinventario", "DESC")
            ->get();
        foreach ($arrData as $key => $row) {
            $articulosInventario = new TableModel;
            $articulosInventario->setTable("lab_detalle_inventarios");
            $articulosInventario->setId("idinventariodetalle");
            $arrData[$key]["edit"] = 0;
            $arrData[$key]["delete"] = 0;

            if ($this->permisos['perm_u'] == "1") {
                $arrData[$key]["edit"] = 1;
            }
            if ($this->permisos['perm_d'] == "1") {
                $arrData[$key]["delete"] = 1;
            }
            $total = count($articulosInventario
                ->where("idinventario", $row["idinventario"])
                ->get());
            $arrData[$key]["total_articulos"] = $total;
        }
        return $this->respondWithJson($response, $arrData);
    }

    public function listProductos($request, $response, $args = [])
    {
        if ($this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $arrData = [];
        $productos = new TableModel;
        $productos->setTable("lab_productos");
        $productos->setId("idproducto");
        $arrData = array_merge($arrData, $productos->get());

        $insumos = new TableModel;
        $insumos->setTable("lab_insumos");
        $insumos->setId("idinsumo");
        $arrData = array_merge($arrData, $insumos->get());

        $materiales = new TableModel;
        $materiales->setTable("lab_materiales");
        $materiales->setId("idmaterial");
        $arrData = array_merge($arrData, $materiales->get());

        // order arrData by name
        usort($arrData, function ($a, $b) {
            $nombreA = iconv('UTF-8', 'ASCII//TRANSLIT', $a['nombre']);
            $nombreB = iconv('UTF-8', 'ASCII//TRANSLIT', $b['nombre']);
            return strcmp($nombreA, $nombreB);
        });

        foreach ($arrData as $key => $row) {
            $arrData[$key]['tipo'] = "Producto";
            if (isset($row['idinsumo'])) {
                $arrData[$key]['tipo'] = "Insumo";
            }
            if (isset($row['idmaterial'])) {
                $arrData[$key]['tipo'] = "Material";
            }
            $arrData[$key]['id'] = $row['idproducto'] ?? $row['idinsumo'] ?? $row['idmaterial'];
            $arrData[$key]['idtipo'] = "3";
            if (isset($row['idinsumo'])) {
                $arrData[$key]['idtipo'] = "2";
            }
            if (isset($row['idmaterial'])) {
                $arrData[$key]['idtipo'] = "1";
            }
        }
        return $this->respondWithJson($response, $arrData);
    }

    public function listEstadosProductos($request, $response, $args = [])
    {
        if ($this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $model = new TableModel;
        $model->setTable("lab_condiciones");
        $model->setId("idcondicion");
        return $this->respondWithJson($response, $model->get());
    }

    public function listUnidadesMedida($request, $response, $args = [])
    {
        if ($this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $model = new TableModel;
        $model->setTable("lab_unidades_medidas");
        $model->setId("idmedida");
        return $this->respondWithJson($response, $model->get());
    }

    public function store($request, $response, $args)
    {
        if ($this->permisos['perm_w'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        if (isset($data["id"]) && !empty($data["id"])) {
            return $this->update($request, $response);
        }

        $errors = $this->validar($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");

        $correlativo = $this->obtenerCorrelativo();
        $defaultValues = [
            "codigo" => "IN-" . addCeros($correlativo, 4),
            "fecha_ingreso" => date("Y-m-d"),
            "motivo_ingreso" => "4", // no especificado
            "tipo_documento" => "2", // no especificado
            "observaciones" => null,
        ];

        $dataInsert = [];
        foreach ($defaultValues as $key => $defaultValue) {
            $dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
        }
        $rq = $model->create($dataInsert);
        if (!empty($rq)) {
            return $this->respondWithSuccess($response, "Datos guardados correctamente");
        }

        return $this->respondWithError($response, "Error al guardar los datos.");
    }


    public function storeArticulos($request, $response, $args)
    {
        if ($this->permisos['perm_w'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());

        $errors = $this->validarArticulos($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new TableModel;
        $model->setTable("lab_detalle_inventarios");
        $model->setId("idinventariodetalle");

        $data["idinventario"] = $data["idingreso"];
        $data["idcondicion"] = $data["estado_articulos"];
        $data["idmedida"] = $data["und_medida"];
        $tipo = explode("-", $data["lista_articulos"])[1];
        $id = explode("-", $data["lista_articulos"])[0];
        $l = "";
        switch ($tipo) {
            case '1':
                $data["idmaterial"] = intval($id);
                $l = "idmaterial";
                break;
            case '2':
                $data["idinsumo"] = intval($id);
                $l = "idinsumo";
                break;
            case '3':
                $data["idproducto"] = intval($id);
                $l = "idproducto";
                break;
            default:
                break;
        }

        // buscar si existe el articulo en el inventario, considerando que la unidad de medida sea la misma
        $existe = $model
            ->where("idinventario", $data["idingreso"])
            ->where($l, $id)
            ->where("idmedida", $data["und_medida"])
            ->first();

        if (!empty($existe)) {
            $msg = "Ya tiene un articulo en el ingreso actual.";
            return $this->respondWithError($response, $msg);
        }

        unset($data["idingreso"]);
        unset($data["estado_articulos"]);
        unset($data["und_medida"]);

        $defaultValues = [
            "idinventario" => null,
            "idproducto" => null,
            "idinsumo" => null,
            "idmaterial" => null,
            "idcondicion" => null,
            "cantidad" => "0",
            "idmedida" => null,
            "factor" => "0",
            "fecha_vencimiento" => null,
            "observaciones" => null,
        ];

        $dataInsert = [];
        foreach ($defaultValues as $key => $defaultValue) {
            $dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
        }
        $rq = $model->create($dataInsert);
        if (!empty($rq)) {
            // actualizar stock en lab_balance_inventarios
            $clsBalance = new BalanceClass;
            $respuesta = $clsBalance->nuevoRegistro($dataInsert);
            // registrar el movimiento en el historial
            $clsMovimientos = new MovimientosClass;
            $clsMovimientos->store([
                "idbalance" => $respuesta["data"]["idbalance"],
                "idinventariodetalle" => $rq["idinventariodetalle"],
                "tipo_movimiento" => 1,
                "tipo_detalle" => 1,
                "idmedida" => $rq["idmedida"],
                "cantidad" => $rq["cantidad"],
                "factor" => $rq["factor"],
                "observaciones" => "Ingreso de inventario."
            ]);
            return $this->respondWithSuccess($response, "Datos guardados correctamente");
        }

        return $this->respondWithError($response, "Error al guardar los datos.");
    }

    private function validar($data)
    {
        if (empty($data["fecha_ingreso"])) {
            return false;
        }
        if (empty($data["motivo_ingreso"])) {
            return false;
        }
        if (empty($data["tipo_documento"])) {
            return false;
        }
        return true;
    }

    private function validarArticulos($data)
    {
        if (empty($data["idingreso"])) {
            return false;
        }
        if (empty($data["lista_articulos"])) {
            return false;
        }
        if (empty($data["estado_articulos"])) {
            return false;
        }
        if (empty($data["und_medida"])) {
            return false;
        }
        if (empty($data["cantidad"])) {
            return false;
        }
        return true;
    }


    public function search($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        $errors = $this->validarSearch($data);
        if (!$errors) {
            return $this->respondWithError($response, "Verifique los datos ingresados");
        }
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");

        $rq = $model->find($data['id']);
        if (!empty($rq)) {
            return $this->respondWithJson($response, ["status" => true, "data" => $rq]);
        }
        $msg = "No se encontraron datos";
        return $this->respondWithError($response, $msg);
    }

    public function  verArticulosIngresos($request, $response)
    {
        if ($this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        if (isset($data["id"]) && empty($data["id"])) {
            return $this->respondWithError($response, "Error de validación, por favor recargue la página");
        }

        $model = new TableModel;
        $model->setTable("lab_detalle_inventarios");
        $model->setId("idinventariodetalle");
        $model
            ->select(
                "lab_detalle_inventarios.idinventariodetalle",
                "lab_productos.nombre as producto",
                "lab_insumos.nombre as insumo",
                "lab_materiales.nombre as material",
                "lab_condiciones.nombre as estado",
                "lab_unidades_medidas.nombre as medida",
                "lab_detalle_inventarios.cantidad",
                "lab_detalle_inventarios.factor",
                "lab_detalle_inventarios.fecha_vencimiento",
            )
            ->leftJoin("lab_productos", "lab_productos.idproducto", "lab_detalle_inventarios.idproducto")
            ->leftJoin("lab_insumos", "lab_insumos.idinsumo", "lab_detalle_inventarios.idinsumo")
            ->leftJoin("lab_materiales", "lab_materiales.idmaterial", "lab_detalle_inventarios.idmaterial")
            ->leftJoin("lab_condiciones", "lab_condiciones.idcondicion", "lab_detalle_inventarios.idcondicion")
            ->leftJoin("lab_unidades_medidas", "lab_unidades_medidas.idmedida", "lab_detalle_inventarios.idmedida");

        $arrData = $model
            ->where("lab_detalle_inventarios.idinventario", $data["id"])
            ->get();

        foreach ($arrData as $key => $row) {
            // segun el tipo de articulo asignar que tipo es
            $arrData[$key]["tipo"] = "";
            if (!empty($row["idinsumo"])) {
                $arrData[$key]["idtipo"] = "2";
            }
            if (!empty($row["idmaterial"])) {
                $arrData[$key]["idtipo"] = "1";
            }
            if (!empty($row["idproducto"])) {
                $arrData[$key]["idtipo"] = "3";
            }
        }

        return $this->respondWithJson($response, ["status" => true, "data" => $arrData]);
    }

    public function validarSearch($data)
    {
        if (empty($data["id"])) {
            return false;
        }
        return true;
    }

    public function update($request, $response)
    {
        if ($this->permisos['perm_u'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        $errors = $this->validarUpdate($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");
        $defaultValues = [
            "fecha_ingreso" => date("Y-m-d"),
            "motivo_ingreso" => "4", // no especificado
            "tipo_documento" => "2", // no especificado
            "observaciones" => null,
        ];
        $dataInsert = [];
        foreach ($defaultValues as $key => $defaultValue) {
            $dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
        }
        $rq = $model->update($data["id"], $dataInsert);
        if (!empty($rq)) {
            return $this->respondWithSuccess($response, "Ingreso actualizado correctamente");
        }
        return $this->respondWithJson($response, "Error al guardar los datos");
    }

    private function validarUpdate($data)
    {
        if (empty($data["id"])) {
            return false;
        }
        if (empty($data["fecha_ingreso"])) {
            return false;
        }
        if (empty($data["motivo_ingreso"])) {
            return false;
        }
        if (empty($data["tipo_documento"])) {
            return false;
        }
        return true;
    }

    public function delete($request, $response)
    {
        if ($this->permisos['perm_d'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        if (empty($data["id"])) {
            return $this->respondWithError($response, "Error de validación, por favor recargue la página");
        }
        // verificar que noexistan articulos en lab_detalle_inventario
        $model = new TableModel;
        $model->setTable("lab_detalle_inventarios");
        $model->setId("idinventariodetalle");
        $rq = $model->where("idinventario", $data["id"])->first();
        if (!empty($rq)) {
            return $this->respondWithError($response, "No se puede eliminar el ingreso, ya tiene articulos asignados.");
        }
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");
        $rq = $model->delete($data["id"]);
        if (!empty($rq)) {
            $msg = "Datos eliminados correctamente";
            return $this->respondWithSuccess($response, $msg);
        }

        return $this->respondWithError($response, "No se encontraron datos para eliminar.");
    }

    public function deleteArticuloIngreso($request, $response)
    {
        if ($this->permisos['perm_d'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        if (empty($data["id"])) {
            return $this->respondWithError($response, "El id del articulo es requerido");
        }
        $model = new TableModel;
        $model->setTable("lab_detalle_inventarios");
        $model->setId("idinventariodetalle");

        $articulo = $model->find($data["id"]);
        if (!empty($articulo)) {
            $rq = $model->delete($data["id"]);
            if (!empty($rq)) {
                // descuenta el stock en lab_balance_inventarios
                $clsBalance = new BalanceClass;
                $respuesta = $clsBalance->quitarStockIngresos($articulo);
                // registrar el movimiento en el historial
                $clsMovimientos = new MovimientosClass;
                $clsMovimientos->store([
                    "idbalance" => $respuesta["idbalance"],
                    "idinventariodetalle" => $articulo["idinventariodetalle"],
                    "tipo_movimiento" => 2,
                    "tipo_detalle" => 1,
                    "idmedida" => $articulo["idmedida"],
                    "cantidad" => $articulo["cantidad"],
                    "factor" => $articulo["factor"],
                    "observaciones" => "Salida de inventario por eliminacion de articulo."
                ]);
                return $this->respondWithSuccess($response, "Datos eliminados correctamente. " . $respuesta["message"]);
            }
        }
        $msg = "Error al eliminar los datos";
        return $this->respondWithError($response, $msg);
    }

    public function cambiarCodigo($request, $response)
    {
        return $this->respondWithJson($response, [$this->obtenerCorrelativo()]);
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");
        $all = $model
            ->orderBy("fecha_ingreso", "DESC")
            ->orderBy("idinventario", "DESC")
            ->get();
        $correlativo = 1;
        foreach ($all as $key => $value) {
            $model->update($value["idinventario"], ["codigo" => "IN-" . addCeros($correlativo, 4)]);
            $correlativo++;
        }
        $all = $model->all();
        return $this->respondWithJson($response, $all);
    }

    private function obtenerCorrelativo()
    {
        $model = new TableModel;
        $model->setTable("lab_inventarios");
        $model->setId("idinventario");
        $all = $model->orderBy("fecha_ingreso", "DESC")
            ->orderBy("idinventario", "DESC")
            ->get();

        // Si no hay registros, comenzar desde 1
        if (empty($all)) {
            return 1;
        }

        // Si hay registros, obtener el último código y aumentar en 1
        try {
            $ultimoCodigo = $all[0]["codigo"] ?? '';
            $partes = explode("-", $ultimoCodigo);

            if (count($partes) < 2 || !is_numeric($partes[1])) {
                // Si el código no tiene el formato esperado, comenzar desde 1
                return 1;
            }

            return intval($partes[1]) + 1;
        } catch (Exception $e) {
            // Si ocurre cualquier error, comenzar desde 1
            return 1;
        }
    }
}
