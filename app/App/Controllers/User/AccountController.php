<?php

namespace App\Controllers\User;

use App\Controllers\Clases\MascotasClass;
use App\Controllers\Clases\ReservarCitasClass;
use App\Controllers\Controller;
use App\Controllers\Login\ForgotPasswordController;
use App\Models\TableModel;
use App\Models\UsuarioModel;
use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

class AccountController extends Controller
{
    protected $responseFactory;

    protected $guard;

    public function __construct()
    {
        parent::__construct();
        $this->responseFactory = new ResponseFactory();
        $this->guard = new Guard($this->responseFactory);
        $this->guard->setStorageLimit(1);
    }

    public function index($request, $response, $args)
    {
        $usuarioModel = new TableModel();
        $usuarioModel->setTable("vet_usuarios");
        $usuarioModel->setId("idusuario");
        $usuario = $usuarioModel->find($_SESSION['lnh']);
        $propietarioModel = new TableModel();
        $propietarioModel->setTable("vet_propietarios");
        $propietarioModel->setId("idpropietario");
        $propietario = $propietarioModel->find($usuario['idpropietario']);
        // Generate new tokens
        $csrfNameKey = $this->guard->getTokenNameKey();
        $csrfValueKey = $this->guard->getTokenValueKey();
        $keyPair = $this->guard->generateToken();
        return $this->render($response, "Web.User.account", [
            'title' => 'Mi cuenta',
            "css" => [
                "vendor/select2/select2/dist/js/select2.min.css",
                'node_modules/flatpickr/dist/flatpickr.min.css',
                "css/select2-custom.css",
            ],
            "js" => [
                "vendor/select2/select2/dist/js/select2.min.js",
                'node_modules/autosize/dist/autosize.js',
                'node_modules/flatpickr/dist/flatpickr.min.js',
                'node_modules/flatpickr/dist/l10n/es.js',
                "js/web/account.js"
            ],
            "tk" => [
                "name" => $csrfNameKey,
                "value" => $csrfValueKey,
                "key" => $keyPair
            ],
            "user" => $usuario,
            "propietario" => $propietario,
        ]);
        // $return = $this->view("Web.User.account", [
        //     "data" => [
        //         'title' => 'Mi cuenta',
        //     ],
        //     "js" => [
        //         "js/web/account.js"
        //     ],
        //     "tk" => [
        //         "name" => $csrfNameKey,
        //         "value" => $csrfValueKey,
        //         "key" => $keyPair
        //     ],
        //     "user" => $usuario,
        // ]);
        // $response->getBody()->write($return);
        // return $response;
    }

    public function updateAccount($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        // validar datos
        $validate = $this->guard->validateToken($data['csrf_name'], $data['csrf_value']);
        if (!$validate) {
            $msg = "Error de validación, por favor recargue la página";
            return $this->respondWithError($response, $msg);
        }
        unset($data['password'], $data['password_confirmation'], $data['csrf_name'], $data['csrf_value']);
        $errors = $this->validar($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $usuarioModel = new UsuarioModel();
        $res = $usuarioModel->update($data["id"], [
            "usu_ndoc" => $data['dni'],
            "usu_nombre" => $data['name'],
            "usu_direc" => $data['address'],
            "usu_cel" => $data['phone'],
        ]);

        if (empty($res)) {
            $msg = "Error al actualizar los datos";
            return $this->respondWithError($response, $msg);
        }
        $this->guard->removeAllTokenFromStorage();
        $msg = "Datos actualizados correctamente";
        return $this->respondWithSuccess($response, $msg);
    }

    public function formForgotPassword($request, $response, $args)
    {
        $usuarioModel = new UsuarioModel();
        $usuario = $usuarioModel->find($_SESSION['lnh']);
        $csrfNameKey = $this->guard->getTokenNameKey();
        $csrfValueKey = $this->guard->getTokenValueKey();
        $keyPair = $this->guard->generateToken();
        $return = $this->view("Web.User.changePassword", [
            "data" => [
                'title' => 'Mi cuenta',
            ],
            "js" => [
                "js/web/change_password.js"
            ],
            "tk" => [
                "name" => $csrfNameKey,
                "value" => $csrfValueKey,
                "key" => $keyPair
            ],
            "user" => $usuario,
        ]);
        $response->getBody()->write($return);
        return $response;
    }

    public function changePassword($request, $response, $args)
    {
        $forgot = new ForgotPasswordController();
        return $forgot->forgot($request, $response, $args);
        // return $this->respondWithJson($response, $request->getParsedBody());
    }

    private function validar($data)
    {
        if (empty($data["id"]) || is_int($data["id"])) {
            return false;
        }
        if (empty($data["dni"]) || strlen($data["dni"]) != 8) {
            return false;
        }
        if (empty($data["name"])) {
            return false;
        }
        if (empty($data["phone"])) {
            return false;
        }
        if (empty($data["address"])) {
            return false;
        }
        return true;
    }

    public function storeMascota($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $mascotaClass = new MascotasClass();
        if (isset($data['idmascota']) && !empty($data['idmascota'])) {
            $res = $mascotaClass->update($data);
            if ($res["status"]) {
                return $this->respondWithSuccess($response, $res["message"]);
            }
        } else {
            $res = $mascotaClass->store($data);
        }
        if ($res["status"]) {
            return $this->respondWithSuccess($response, $res["message"]);
        }
        return $this->respondWithError($response, $res["message"]);
    }

    public function storeCitas($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $citasClass = new ReservarCitasClass();
        return $this->respondWithJson($response, $citasClass->reservarCita($data));
    }

    public function listMascota($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $mascotaClass = new MascotasClass();
        $res = $mascotaClass->list($data);
        return $this->respondWithJson($response, $res);
    }

    public function listCitas($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $data["order"] = isset($data["order"]) ? $data["order"] : "";
        $data["dir"] = isset($data["dir"]) ? $data["dir"] : "";
        $citasClass = new ReservarCitasClass();
        $res = $citasClass->listarCitas($data);
        return $this->respondWithJson($response, $res);
    }

    public function listarVacunas($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $data["order"] = isset($data["order"]) ? $data["order"] : "";
        $data["dir"] = isset($data["dir"]) ? $data["dir"] : "";

        $model = new TableModel;
        $model->setTable("vet_vacunaciones");
        $model->setId("idvacuna");
        if ($data["order"] != "") {
            $model->orderBy($data["order"], $data["dir"]);
        } else {
            $model->orderBy("idvacuna", "DESC");
        }
        return $this->respondWithJson($response, $model
            ->select("vet_vacunaciones.*", "vet_mascotas.nombre as nombre_mascota")
            ->join("vet_mascotas", "vet_mascotas.idmascota", "vet_vacunaciones.idmascota")
            ->where("vet_vacunaciones.idpropietario", $_SESSION['lnh'] ?? '0')
            ->where("vet_vacunaciones.eliminado", 0)
            ->get());
    }

    public function listarDesparasitaciones($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $data["order"] = isset($data["order"]) ? $data["order"] : "";
        $data["dir"] = isset($data["dir"]) ? $data["dir"] : "";

        $model = new TableModel;
        $model->setTable("vet_desparasitaciones");
        $model->setId("iddesparacitacion");
        if ($data["order"] != "") {
            $model->orderBy($data["order"], $data["dir"]);
        } else {
            $model->orderBy("iddesparacitacion", "DESC");
        }
        return $this->respondWithJson($response, $model
            ->select("vet_desparasitaciones.*", "vet_mascotas.nombre as nombre_mascota")
            ->join("vet_mascotas", "vet_mascotas.idmascota", "vet_desparasitaciones.idmascota")
            ->where("vet_desparasitaciones.idpropietario", $_SESSION['lnh'] ?? '0')
            ->where("vet_desparasitaciones.eliminado", 0)
            ->get());
    }

    public function searchMascota($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["idpropietario"] = $_SESSION['lnh'] ?? '0';
        $mascotaClass = new MascotasClass();
        $res = $mascotaClass->search($data);
        return $this->respondWithJson($response,  ["status" => true, "data" => $res]);
    }

    public function deleteMascota($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        if (empty($data["idmascota"])) {
            return $this->respondWithError($response, "Error de validación, por favor recargue la página");
        }
        $model = new TableModel;
        $model->setTable("vet_mascotas");
        $model->setId("idmascota");
        $rq = $model->find($data['idmascota']);
        if (!empty($rq)) {
            $rq = $model->update($data['idmascota'], ["eliminado" => 1]);
            if (!empty($rq)) {
                $msg = "Datos eliminados correctamente";
                return $this->respondWithSuccess($response, $msg);
            }
        }
        $msg = "Error al eliminar los datos";
        return $this->respondWithError($response, $msg);
    }

    public function cancelarReservaCita($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $citasClass = new ReservarCitasClass();
        return $this->respondWithJson($response, $citasClass->cancelarReservaCita($data));
    }
}
