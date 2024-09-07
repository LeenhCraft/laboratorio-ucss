<?php

namespace App\Models;

class UsuarioModel extends Model
{
    protected $table = "sis_usuarios";
    protected $id = "idusuario";
    protected $fields = [
        "usu_ndoc",
        "usu_nombre",
        "usu_cuenta",
        "usu_usuario",
        "usu_pass",
        "usu_direc",
        "usu_cel",
        "usu_foto",
        "usu_token",
        "usu_expire",
        "usu_publish",
        "usu_estado",
        "usu_activo",
        "usu_factivo",
        "usu_fecha"
    ];

    public function getTable()
    {
        return $this->table;
    }

    public function setTable($table)
    {
        $this->table = $table;
    }

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function save($data = [])
    {
        $request = $this->create([
            "usu_ndoc" => strtolower($data["dni"]),
            "usu_nombre" => ucwords($data["name"]),
            "usu_cuenta" => 1,
            "usu_usuario" => $data["email"],
            "usu_pass" => password_hash($data["password"], PASSWORD_DEFAULT),
            "usu_token" => $data["token"],
            "usu_expire" => $data['expires'],
            "usu_estado" => 0,
            "usu_activo" => 1,
        ]);
        return $request;
    }

    public function usaurioToken($token = "")
    {
        $usuarioModel = new UsuarioModel();
        $dataUsuario = $usuarioModel->where("usu_token", "LIKE", $token)->where("usu_estado", 0)->first();

        if (empty($dataUsuario)) {
            return [];
        }
        return $dataUsuario;
    }

    public function lstUser()
    {
        if ($_SESSION['app_r'] == 1) {
            $where = "";
        } else {
            $where = " WHERE idusuario != 1";
        }
        $sql = "SELECT a.idusuario as id,a.usu_usuario as usu,a.usu_activo as estado,b.rol_nombre as rol FROM sis_usuarios a INNER JOIN sis_rol b ON b.idrol=a.idrol $where";
        $request = $this->query($sql)->get();
        return $request;
    }
}
