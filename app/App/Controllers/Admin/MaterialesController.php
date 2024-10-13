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
            "css" => [
                "vendor/select2/select2/dist/css/select2.min.css",
                'node_modules/flatpickr/dist/flatpickr.min.css',
                // "css/select2-custom.css",
            ],
            "js" => [
                "vendor/select2/select2/dist/js/select2.min.js",
                'node_modules/flatpickr/dist/flatpickr.min.js',
				'node_modules/flatpickr/dist/l10n/es.js',
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
        switch ($data["tipo_material"]) {
            case 1:
                $productos = new TableModel;
                $productos->setTable("lab_productos");
                $productos->setId("idproducto");

                $insumos = new TableModel;
                $insumos->setTable("lab_insumos");
                $insumos->setId("idinsumo");

                $materiales = new TableModel;
                $materiales->setTable("lab_materiales");
                $materiales->setId("idmaterial");

                // $model = new TableModel;
                // $model
                //     ->unionAll([$productos->getQuery()])
                //     ->unionAll([$insumos->getQuery()])
                //     ->unionAll([$materiales->getQuery()]);
                $datos = $productos->get();
                break;
            case 2:
                $insumos = new TableModel;
                $insumos->setTable("lab_insumos");
                $insumos->setId("idinsumo");

                if ($data["condicion_material"] == 2) {
                    $insumos->where("stock", ">", 0)->get();
                }
                if ($data["condicion_material"] == 3) {
                    $insumos->where("stock", "=", 0)->get();
                }
                if ($data["condicion_material"] == 4) {
                    $insumos->where("stock", "<", 0)->get();
                }

                $datos = $insumos->get();
                break;
            case 3:
                $materiales = new TableModel;
                $materiales->setTable("lab_materiales");
                $materiales->setId("idmaterial");

                $datos = $materiales->get();
                break;
            case 4:
                # code...
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
        $data = $this->sanitize($request->getParsedBody());
        if (isset($data["idmaterial"]) && !empty($data["idmaterial"])) {
            dep("actualizar", 1);
            return $this->update($request, $response);
        }

        $errors = $this->validar($data);
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

        $msg = "Error al guardar los datos";
        return $this->respondWithJson($response, $existe);
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

        $model = new MenuAdminModel;
        $rq = $model->find($data['id']);
        if (!empty($rq)) {
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
        return true;
    }

    public function update($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        // return $this->respondWithJson($response, $data);

        $validate = $this->guard->validateToken($data['csrf_name'], $data['csrf_value']);
        if (!$validate) {
            $msg = "Error de validación, por favor recargue la página";
            return $this->respondWithError($response, $msg);
        }

        $errors = $this->validarUpdate($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new MenuAdminModel;
        $existe = $model->where("men_nombre", "LIKE", $data['name'])->where("idmenu", "!=", $data['id'])->first();
        if (!empty($existe)) {
            $msg = "Ya tiene un submenu con el mismo nombre";
            return $this->respondWithError($response, $msg);
        }

        $rq = $model->update($data['id'], [
            "men_nombre" => ucfirst($data['name']) ?? "UNDEFINED",
            "men_url" => $data['url'] ?? "#",
            "men_controlador" => $data['controller'] ?? null,
            // "men_icono" => !empty($data['icon']) ? $data['icon'] : "bx-circle",
            "men_icono" => $data['icon'] ?: "bx-circle",
            "men_url_si" => isset($data['url_si']) && $data['url_si'] == "on" ? '1' : "0",
            "men_orden" => $data['order'] ?: '1',
            "men_visible" => $data['visible'] ?: "0"
        ]);
        if (!empty($rq)) {
            $msg = "Datos actualizados";
            return $this->respondWithSuccess($response, $msg);
        }
        $msg = "Error al guardar los datos";
        return $this->respondWithJson($response, $existe);
    }

    private function validarUpdate($data)
    {
        if (empty($data["id"])) {
            return false;
        }
        if (empty($data["name"])) {
            return false;
        }
        if (isset($data['url_si']) && $data['url_si'] == "on") {
            if (empty($data["url"])) {
                return false;
            }
            if (empty($data["controller"])) {
                return false;
            }
        }
        return true;
    }

    public function delete($request, $response)
    {
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
