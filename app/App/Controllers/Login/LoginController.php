<?php

namespace App\Controllers\Login;

use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

use App\Controllers\Controller;
use App\Models\TableModel;
use App\Models\UsuarioModel;

class LoginController extends Controller
{
    protected $responseFactory;

    protected $guard;

    public function __construct()
    {
        parent::__construct();
        $this->responseFactory = new ResponseFactory();
        $this->guard = new Guard($this->responseFactory);
    }

    public function index($request, $response, $args)
    {
        $csrfNameKey = $this->guard->getTokenNameKey();
        $csrfValueKey = $this->guard->getTokenValueKey();
        $keyPair = $this->guard->generateToken();
        return $this->render($response, "Web.Login.login", [
            'title' => 'Login',
            "js" => [
                "js/web/login.js"
            ],
            "tk" => [
                "name" => $csrfNameKey,
                "value" => $csrfValueKey,
                "key" => $keyPair
            ],
        ]);
    }

    public function login($request, $response, $args)
    {
        $data = $this->sanitize($request->getParsedBody());
        $usuarioModel = new TableModel();
        $usuarioModel->setTable("vet_usuarios");
        $usuarioModel->setId("idusuario");
        $usuario = $usuarioModel
            ->where("usu_cuenta", "LIKE", $data["usu_cuenta"])
            ->first();

        if (empty($usuario)) {
            $msg = "El usuario no existe";
            return $this->respondWithError($response, $msg);
        }

        if (!password_verify($data["usu_password"], $usuario["usu_password"])) {
            $msg = "La contraseña no es valida";
            return $this->respondWithError($response, $msg);
        }
        if (!empty($usuario["usu_token"])) {
            return $this->respondWithError($response, "El usuario no ha verificado su cuenta. Revise su correo electrónico para activar su cuenta.");
        }

        if ($usuario["usu_estado"] == 0) {
            $msg = "El usuario está desactivado";
            return $this->respondWithError($response, $msg);
        }

        if ($usuario["usu_estado"] == 1) {
            $_SESSION['lnh'] = $usuario['idusuario'];
            $_SESSION['pe'] = true;
            $msg = "Bienvenido! ";
            return $this->respondWithSuccess($response, $msg);
        }
        $msg = "Erorr inesperado";
        return $this->respondWithError($response, $msg);
    }
}
