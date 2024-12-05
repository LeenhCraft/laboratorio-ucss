<?php

namespace App\Controllers\Admin;

use App\Controllers\Controller;
use App\Models\Admin\MenuAdminModel;
use App\Models\TableModel;
use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

class MaterialesController extends Controller
{
    protected $permisos = [];
    protected $responseFactory;
    protected $guard;

    public function __construct()
    {
        parent::__construct();
        $this->permisos = getPermisos($this->className($this));
        $this->responseFactory = new ResponseFactory();
        $this->guard = new Guard($this->responseFactory);
    }

    public function index($request, $response)
    {
        return $this->render($response, 'App.Materiales.materiales', [
            'titulo_web' => 'Control de Inventario',
            "url" => $request->getUri()->getPath(),
            "permisos" => $this->permisos,
            "js" => [
                "js/app/nw_inventario.js"
            ],
            "tk" => [
                "name" => $this->guard->getTokenNameKey(),
                "value" => $this->guard->getTokenValueKey(),
                "key" => $this->guard->generateToken()
            ]
        ]);
    }

    public function list($request, $response, $args = [], $ignorePermissions = false)
    {
        if (!$ignorePermissions && $this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        $datos = [];
        $arrData = [];
        switch ($data["tipo_material"]) {
            case 1:
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

                foreach ($arrData as $key => $row) {
                    $articulosInventario = new TableModel;
                    $articulosInventario->setTable("lab_balance_inventarios");
                    $articulosInventario->setId("idbalance");
                    $arrData[$key]['tipo'] = "3";
                    $l = "idproducto";
                    if (isset($row['idinsumo'])) {
                        $arrData[$key]['tipo'] = "2";
                        $l = "idinsumo";
                    }
                    if (isset($row['idmaterial'])) {
                        $arrData[$key]['tipo'] = "1";
                        $l = "idmaterial";
                    }

                    $arrData[$key]['delete'] = 0;
                    $arrData[$key]['edit'] = 0;
                    if ($this->permisos['perm_d'] == 1) {
                        $arrData[$key]['delete'] = 1;
                    }
                    if ($this->permisos['perm_u'] == 1) {
                        $arrData[$key]['edit'] = 1;
                    }
                    $arrData[$key]['id'] = $row['idproducto'] ?? $row['idinsumo'] ?? $row['idmaterial'];

                    $total = $articulosInventario
                        ->where($l, $row[$l])
                        ->first();
                    $arrData[$key]["stock"] = $total["stock_total"] ?? 0;
                }

                $datos = $arrData;
                break;
            case 2:
                $insumos = new TableModel;
                $insumos->setTable("lab_insumos");
                $insumos->setId("idinsumo");

                // if ($data["condicion_material"] == 2) {
                //     $insumos->where("stock", ">", 0)->get();
                // }
                // if ($data["condicion_material"] == 3) {
                //     $insumos->where("stock", "=", 0)->get();
                // }
                // if ($data["condicion_material"] == 4) {
                //     $insumos->where("stock", "<", 0)->get();
                // }

                $arrData = $insumos->get();

                foreach ($arrData as $key => $row) {
                    $articulosInventario = new TableModel;
                    $articulosInventario->setTable("lab_balance_inventarios");
                    $articulosInventario->setId("idbalance");
                    $arrData[$key]['tipo'] = "2";
                    $arrData[$key]['delete'] = 0;
                    $arrData[$key]['edit'] = 0;
                    if ($this->permisos['perm_d'] == 1) {
                        $arrData[$key]['delete'] = 1;
                    }
                    if ($this->permisos['perm_u'] == 1) {
                        $arrData[$key]['edit'] = 1;
                    }
                    $arrData[$key]['id'] = $row['idinsumo'];
                    $total = $articulosInventario
                        ->where("idinsumo", $row["idinsumo"])
                        ->first();
                    $arrData[$key]["stock"] = $total["stock_total"] ?? 0;
                }
                $datos = $arrData;
                break;
            case 3:
                $materiales = new TableModel;
                $materiales->setTable("lab_materiales");
                $materiales->setId("idmaterial");

                $arrData = $materiales->get();

                foreach ($arrData as $key => $row) {
                    $articulosInventario = new TableModel;
                    $articulosInventario->setTable("lab_balance_inventarios");
                    $articulosInventario->setId("idbalance");
                    $arrData[$key]['tipo'] = "1";
                    $arrData[$key]['delete'] = 0;
                    $arrData[$key]['edit'] = 0;
                    if ($this->permisos['perm_d'] == 1) {
                        $arrData[$key]['delete'] = 1;
                    }
                    if ($this->permisos['perm_u'] == 1) {
                        $arrData[$key]['edit'] = 1;
                    }
                    $arrData[$key]['id'] = $row['idmaterial'];
                    $total = $articulosInventario
                        ->where("idmaterial", $row["idmaterial"])
                        ->first();
                    $arrData[$key]["stock"] = $total["stock_total"] ?? 0;
                }
                $datos = $arrData;
                break;
            default:
                # code...
                break;
        }
        for ($i = 0; $i < count($datos); $i++) {
            $datos[$i]['delete'] = 0;
            $datos[$i]['edit'] = 0;

            if ($this->permisos['perm_d'] == 1) {
                $datos[$i]['delete'] = 1;
            }
            if ($this->permisos['perm_u'] == 1) {
                $datos[$i]['edit'] = 1;
            }
        }
        return $this->respondWithJson($response, $datos);
    }

    public function store($request, $response, $args)
    {
        if ($this->permisos['perm_w'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($request->getParsedBody());
        $data["idtipomaterial"] = 1;
        if (isset($data["idmaterial"]) && !empty($data["idmaterial"])) {
            return $this->update($request, $response);
        }

        $errors = $this->validar($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $data["nombre"] = trim($data["nombre"]);
        $model = new TableModel;
        switch ($data['idtipomaterial']) {
            case 1:
                $model->setTable("lab_materiales");
                $model->setId("idmaterial");
                break;
            case 2:
                $model->setTable("lab_insumos");
                $model->setId("idinsumo");
                break;
            case 3:
                $model->setTable("lab_productos");
                $model->setId("idproducto");
                break;
            default:
                return $this->respondWithError($response, "Seleccione un tipo de material");
                break;
        }

        $existe = $model
            ->where("nombre", "LIKE", $data['nombre'])
            ->first();
        if (!empty($existe)) {
            $msg = "Ya tiene un registro creado con esta información.";
            return $this->respondWithError($response, $msg);
        }

        $defaultValues = [
            "nombre" => "UNDEFINED",
            "modelo" => null,
            "codigo_ucss" => null,
            "stock" => 0,
            "observaciones" => null
        ];

        $dataInsert = [];
        foreach ($defaultValues as $key => $defaultValue) {
            $dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
        }
        $rq = $model->create($dataInsert);
        if (!empty($rq)) {
            return $this->respondWithSuccess($response, "Datos guardados correctamente");
        }

        return $this->respondWithError($response, "Error al guardar los datos");
    }

    private function validar($data)
    {
        if (empty($data["nombre"])) {
            return false;
        }
        if (empty($data["idtipomaterial"])) {
            return false;
        }
        return true;
    }

    public function search($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        $errors = $this->validarSearch($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new TableModel;
        switch ($data['tipo']) {
            case '1':
                // materiales
                $model->setTable("lab_materiales");
                $model->setId("idmaterial");

                break;
            case '2':
                // insumos
                $model->setTable("lab_insumos");
                $model->setId("idinsumo");
                break;
            case '3':
                // productos
                $model->setTable("lab_productos");
                $model->setId("idproducto");
                break;
            default:
                $msg = "Seleccione un tipo de material";
                return $this->respondWithError($response, $msg);
                break;
        }

        $rq = $model->find($data['id']);
        if (!empty($rq)) {
            $rq["id"] = $data['id'];
            $rq["idtipomaterial"] = $data['tipo'];
            return $this->respondWithJson($response, ["status" => true, "data" => $rq]);
        }
        $msg = "No se encontraron datos";
        return $this->respondWithError($response, $msg);
    }

    public function validarSearch($data)
    {
        if (empty($data["id"])) {
            return false;
        }
        if (empty($data["tipo"])) {
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
        // return $this->respondWithJson($response, $data);

        $errors = $this->validarUpdate($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new TableModel;
        switch ($data['idtipomaterial']) {
            case 1:
                $model->setTable("lab_materiales");
                $model->setId("idmaterial");
                break;
            case 2:
                $model->setTable("lab_insumos");
                $model->setId("idinsumo");
                break;
            case 3:
                $model->setTable("lab_productos");
                $model->setId("idproducto");
                break;
            default:
                return $this->respondWithError($response, "Seleccione un tipo de material");
                break;
        }

        $existe = [];
        // verificare si se esta cambiando el tipo de material
        if ($data['tipo_material_original'] != $data['idtipomaterial']) {
            return $this->respondWithError($response, "No se puede cambiar el tipo de material, para cambiarlo elimine el registro y vuelva a crearlo.");
        }
        $existe = $model
            ->where("nombre", "LIKE", $data['nombre'])
            ->where($model->getId(), "!=", $data['idmaterial'])
            ->first();
        if (!empty($existe)) {
            $msg = "Ya tiene un submenu con el mismo nombre";
            return $this->respondWithError($response, $msg);
        }

        $defaultValues = [
            "nombre" => "UNDEFINED",
            "modelo" => null,
            "codigo_ucss" => null,
            "stock" => 0,
            "observaciones" => null
        ];
        $dataInsert = [];
        foreach ($defaultValues as $key => $defaultValue) {
            $dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
        }

        $rq = $model->update($data['idmaterial'], $dataInsert);
        if (!empty($rq)) {
            $msg = "Datos actualizados";
            return $this->respondWithSuccess($response, $msg);
        }
        $msg = "Error al guardar los datos";
        return $this->respondWithJson($response, $existe);
    }

    private function validarUpdate($data)
    {
        if (empty($data["idmaterial"])) {
            return false;
        }
        if (empty($data["nombre"])) {
            return false;
        }
        if (empty($data["idtipomaterial"])) {
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

        $model = new MenuAdminModel;
        $rq = $model->find($data["id"]);
        if (!empty($rq)) {
            $rq = $model->delete($data["id"]);
            if (!empty($rq)) {
                $msg = "Datos eliminados correctamente";
                return $this->respondWithSuccess($response, $msg);
            }
            $msg = "Error al eliminar los datos";
            return $this->respondWithError($response, $msg);
        }
        $msg = "No se encontraron datos para eliminar.";
        return $this->respondWithError($response, $msg);
    }
}
