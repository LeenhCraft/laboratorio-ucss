<?php

namespace App\Controllers\Login;

use App\Controllers\Admin\PropietariosController;
use App\Controllers\Clases\RegistroClass;
use App\Controllers\Controller;
use App\Models\TableModel;
use App\Models\UsuarioModel;
use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

class RegisterController extends Controller
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
        // Generate new tokens
        $csrfNameKey = $this->guard->getTokenNameKey();
        $csrfValueKey = $this->guard->getTokenValueKey();
        $keyPair = $this->guard->generateToken();

        return $this->render($response, "Web.Login.register", [
            'title' => 'Register',
            "js" => [
                "js/web/register.js"
            ],
            "tk" => [
                "name" => $csrfNameKey,
                "value" => $csrfValueKey,
                "key" => $keyPair
            ],
        ]);
    }

    public function save($request, $response, $args = [])
    {
        $data = $this->sanitize($request->getParsedBody());
        $propietarioClass = new PropietariosController();
        $newRequest = $request->withParsedBody([
            "nombres" => $data["usu_nombres"],
            "apellidos" => $data["usu_apellidos"],
            "cuenta" => $data["usu_cuenta"],
            "password" => $data["usu_password"],
        ]);
        return $propietarioClass->store($newRequest, $response, $args, true);
    }
}
