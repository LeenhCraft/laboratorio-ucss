<?php

namespace App\Controllers\Admin;

use Slim\Csrf\Guard;
use Slim\Psr7\Factory\ResponseFactory;

use App\Complements\ImageClass;
use App\Complements\Snowflake;
use App\Controllers\Controller;
use App\Http\ImageGPT;
use App\Models\Admin\UserModel;
use App\Models\TableModel;
use App\Models\UsuarioModel;

class PersonasController extends Controller
{
    protected $permisos;
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
        return $this->render($response, 'App.Usuarios.personal', [
            'titulo_web' => 'Personal',
            "url" => $request->getUri()->getPath(),
            "permisos" => $this->permisos,
            "css" => [
                "vendor/select2/select2/dist/css/select2.min.css",
                "css/select2-custom.css",
                // 'css/custom.css'
            ],
            "js" => [
                "vendor/select2/select2/dist/js/select2.full.min.js",
                "js/app/nw_personal.js"
            ],
            "tk" => [
                "name" => $this->guard->getTokenNameKey(),
                "value" => $this->guard->getTokenValueKey(),
                "key" => $this->guard->generateToken()
            ]
        ]);
    }

    public function list($request, $response)
    {
        $model = new UsuarioModel;
        $arrData = $model->query("SELECT idpersona as 'id',per_nombre as 'name',per_email as 'email',per_estado as 'status' FROM `sis_personal` ORDER BY idpersona DESC")->get();
        $nmr = 1;
        for ($i = 0; $i < count($arrData); $i++) {
            $arrData[$i]['nmr'] = $nmr;
            $nmr++;
            $btnEdit = '';
            $btnDelete = '';

            if ($arrData[$i]['status'] == 1) {
                $arrData[$i]['status'] = "<i class='bx-1 bx bx-check text-success'></i>";
            } else {
                $arrData[$i]['status'] = "<i class='bx-1 bx bx-x text-danger'></i>";
            }
            if ($this->permisos['perm_u'] == '1') {
                $btnEdit = '<button class="btn btn-success btn-sm" onClick="fntEdit(' . $arrData[$i]['id'] . ')" title="Editar Autor"><i class="bx bx-pencil"></i></button>';
            } else {
                $btnEdit = '<button class="btn btn-success btn-sm" title="Editar Autor" disabled><i class="bx bx-penceil"></i></button>';
            }
            if ($this->permisos['perm_d'] == '1') {
                $btnDelete = '<button class="btn btn-danger btn-sm" onclick="fntDel(' . $arrData[$i]['id'] . ')" title="Eliminar Autor"><i class="bx bxs-trash-alt"></i></button>';
            } else {
                $btnDelete = '<button class="btn btn-danger btn-sm" title="Eliminar Autor" disabled><i class="bx bxs-trash-alt"></i></button>';
            }
            $arrData[$i]['opciones'] = '<div class="btn-group" role="group" aria-label="Basic example">' . $btnEdit . ' ' . $btnDelete . '</div>';
        }
        return $this->respondWithJson($response, $arrData);
    }

    public function store($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        $data["per_foto"] = $_FILES["photo"];
        // return $this->respondWithJson($response, $data);

        $validate = $this->guard->validateToken($data['csrf_name'], $data['csrf_value']);
        if (!$validate) {
            $msg = "Error de validación, por favor recargue la página";
            return $this->respondWithError($response, $msg);
        }

        $errors = $this->validar($data);
        if (!$errors) {
            $msg = "Verifique los datos ingresados";
            return $this->respondWithError($response, $msg);
        }

        $model = new TableModel;
        $model->setTable("sis_personal");
        $model->setId("idpersona");
        $existe = $model->where("per_nombre", "LIKE", $data['name'])->where("per_dni", "!=", $data['dni'])->first();
        if (!empty($existe)) {
            $msg = "Ya tiene un usuario registrado con ese nombre";
            return $this->respondWithError($response, $msg);
        }

        if (!empty($data["per_foto"]["name"])) {
            $snow = new Snowflake(12);
            $objImg = new ImageGPT($data["per_foto"]);
            $url = substr($data["name"], 0, 10) . "." . $snow->generateId();
            $img = $objImg
                ->setName(urls_amigables($url))
                ->setSize(1, 5242880)
                ->setMime(['image/jpeg', 'image/png'])
                ->setStorage('img/usu_web', 0755)
                ->upload();

            if (!$img) {
                return $this->respondWithError($response, $objImg->getErrorMessage());
            }
            if ($img) {
                $dataInsert["per_foto"] = "/" . $objImg->getPath();
            }
        }

        $dataInsert = [
            "per_dni" => $data["dni"],
            "per_nombre" => ucwords($data['name']),
            "per_celular" => $data['phone'],
            "per_email" => strtolower($data['email']),
            "per_direcc" => ucwords($data['address']),
            "per_estado" => $data['status'] ?? 0,
        ];


        $rq = $model->create($dataInsert);
        if (!empty($rq)) {
            // $image = new ImageClass;
            // $img = $image->cargarImagenUsuario($_FILES['photo'], $rq, "img/person");
            // $msg = "Datos guardados correctamente";
            $msg = "Datos guardados correctamente" . $img['text'];
            return $this->respondWithSuccess($response, $msg);
        }
        $msg = "Error al guardar los datos";
        return $this->respondWithJson($response, $msg);
    }

    private function validar($data)
    {
        // if (empty($data["dni"])) {
        //     return false;
        // }
        if (empty($data["name"])) {
            return false;
        }
        // if (empty($data["email"])) {
        //     return false;
        // }
        // if (empty($data["phone"])) {
        //     return false;
        // }
        // if (empty($data["address"])) {
        //     return false;
        // }
        // if ($data["status"] != 0 && $data["status"] != 1) {
        //     return false;
        // }
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
        $model->setTable("sis_personal");
        $model->setId("idpersona");
        $rq = $model->find($data['id']);
        if (!empty($rq)) {
            // adjuntar imagen de sis_imagen
            // $objImg = new TableModel;
            // $objImg->setTable("sis_imagenes");
            // $objImg->setId("idimagen");
            // $img = $objImg->where("img_propietario", $rq['idpersona'])->where("img_type", "USER::AVATAR")->first();
            // if (!empty($img)) {
            //     $rq = array_merge($rq, $img);
            // }
            $rq["per_foto"] = !empty($rq["per_foto"]) ? $rq["per_foto"] : "/img/404.webp";
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
        $data["per_foto"] = $_FILES["photo"];

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

        $model = new TableModel;
        $model->setTable("sis_personal");
        $model->setId("idpersona");
        $existe = $model->where("per_nombre", "LIKE", $data['name'])->where("idpersona", "!=", $data['id'])->first();
        if (!empty($existe)) {
            $msg = "Ya tiene un usuario registrado con ese nombre";
            return $this->respondWithError($response, $msg);
        }
        $dataUpdate = [
            "per_dni" => $data["dni"],
            "per_nombre" => ucwords($data['name']),
            "per_celular" => $data['phone'],
            "per_email" => strtolower($data['email']),
            "per_direcc" => ucwords($data['address']),
            "per_estado" => $data['status'] ?? 0,
        ];

        if (!empty($data["per_foto"]["name"])) {
            $snow = new Snowflake(13);
            $objImg = new ImageGPT($data["per_foto"]);
            $img = $objImg
                ->setName(urls_amigables(substr($data["name"], 0, 10)) . "." . $snow->generateId())
                ->setSize(1, 5242880)
                ->setMime(['image/jpeg', 'image/png'])
                ->setStorage('img/usu_web', 0755)
                ->upload();

            if (!$img) {
                return $this->respondWithError($response, $objImg->getErrorMessage());
            }
            if ($img) {
                $dataUpdate["per_foto"] = "/" . $objImg->getPath();
            }
        }

        $rq = $model->update($data['id'], $dataUpdate);
        if (!empty($rq)) {
            // $image = new ImageClass;
            // $img = ['text' => ''];
            // if ($image->verificar($_FILES['photo'])) {
            //     $img = $image->cargarImagenUsuario($_FILES['photo'], $rq, "img/person");
            // }
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
        // if (empty($data["dni"])) {
        //     return false;
        // }
        if (empty($data["name"])) {
            return false;
        }
        // if (empty($data["email"])) {
        //     return false;
        // }
        // if (empty($data["phone"])) {
        //     return false;
        // }
        // if (empty($data["address"])) {
        //     return false;
        // }
        // if ($data["status"] != 0 && $data["status"] != 1) {
        //     return false;
        // }
        return true;
    }

    public function delete($request, $response)
    {
        $data = $this->sanitize($request->getParsedBody());
        if (empty($data["id"])) {
            return $this->respondWithError($response, "Error de validación, por favor recargue la página");
        }
        $model = new TableModel;
        $model->setTable("sis_personal");
        $model->setId("idpersona");
        $rq = $model->find($data["id"]);
        if (!empty($rq)) {
            $rq = $model
                ->query("SELECT * FROM `sis_usuarios` WHERE `idpersona` = {$data["id"]}")
                ->first();

            if (!empty($rq)) {
                $msg = "No se puede eliminar el registro, ya que tiene usuarios asociados";
                return $this->respondWithError($response, $msg);
            }

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
