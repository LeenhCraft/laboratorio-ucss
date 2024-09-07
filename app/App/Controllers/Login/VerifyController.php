<?php

namespace App\Controllers\Login;

use App\Controllers\Clases\RegistroClass;
use App\Controllers\Controller;
use App\Models\TableModel;
use App\Models\UsuarioModel;

class verifyController extends Controller
{
    public function index($request, $response, $args)
    {
        $token = $args['url'];
        // $expires = $_GET['expires'];
        // $signature = $_GET['signature'];
        $usuarioModel = new TableModel();
        $usuarioModel->setTable("vet_usuarios");
        $usuarioModel->setId("idusuario");
        $dataUsuario = $usuarioModel
            ->where("usu_token", "LIKE", $token)
            ->where("usu_estado", '1')
            ->first();

        if (empty($dataUsuario)) {
            $msg = "El token no es valido";
            return $this->respondWithError($response, $msg);
        }

        if (time() - $dataUsuario["usu_expire"] > 0) { // si el token ha expirado
            return $this->render("Web.resendEmail", [
                'title' => 'Resend Email',
                "js" => ["js/web/resend_email.js"],
                "name" => $dataUsuario["usu_nombre"],
                "token" => $dataUsuario["usu_token"],
                "expires" => $dataUsuario["usu_expire"],
            ]);
        }

        $usuarioModel->update($dataUsuario["idusuario"], [
            "usu_token" => null,
            "usu_expire" => null,
            "usu_ultima_actualizacion" => date("Y-m-d H:i:s"),
        ]);

        $propietarioModel = new TableModel();
        $propietarioModel->setTable("vet_propietarios");
        $propietarioModel->setId("idpropietario");
        $propietario = $propietarioModel
            ->where("idpropietario", "LIKE", $dataUsuario["idpropietario"])
            ->first();

        if (empty($propietario)) {
            $msg = "El propietario no existe";
            return $this->respondWithError($response, $msg);
        }

        $propietarioModel->update($propietario["idpropietario"], [
            "estado" => "1",
        ]);

        // $usuarioModel->update($dataUsuario["idusuario"], [
        //     "usu_factivo" => date("Y-m-d H:i:s"),
        // ]);

        $_SESSION['lnh'] = $dataUsuario['idusuario'];
        $_SESSION['pe'] = true;


        return $response
            ->withHeader('Location', base_url() . "me")
            ->withStatus(302);
    }

    public function notification($request, $response, $args)
    {
        $registroClass = new RegistroClass();
        $usuarioModel = new UsuarioModel();
        $data = $registroClass->sanitize($request->getParsedBody()); // obtenemos los datos del formulario y sanitizamos los datos

        // $usuario = $usuarioModel->where("usu_token", "LIKE", $data["_token"] ?? "#")->first();
        $usuario = $usuarioModel->usaurioToken($data['_token'] ?? "#");
        if (empty($usuario)) { // si el token no es valido
            $msg = "El token no es valido";
            return $this->respondWithError($response, $msg);
        }

        // generar nuevo token y time, luego actualizar en la base de datos
        $token = token(7); // generamos un token
        $expires = time() + 24 * 60; // 24 horas

        $rq = $usuarioModel->update($usuario["idwebusuario"], [
            "usu_token" => $token,
            "usu_expire" => $expires,
        ]);

        if (empty($rq)) {
            $msg = "Error al actualizar el token";
            return $this->respondWithError($response, $msg);
        }


        $requestSendEmail = $registroClass->sendEmail([
            "nombre" => $rq['usu_nombre'],
            "email" => $rq['usu_usuario'],
            "token" => $rq['usu_token'],
            "expires" => $rq['usu_expire'],
        ]);

        if (!$requestSendEmail) {
            $msg = "Error al enviar el email";
            return $this->respondWithError($response, $msg);
        }

        $msg = "Se ha enviado un nuevo enlace de verificación a la dirección de correo electrónico que proporcionó durante el registro";
        return $this->respondWithJson($response, ["status" => true, "message" => $msg, "tk" => $rq['usu_token']]);
    }
}
