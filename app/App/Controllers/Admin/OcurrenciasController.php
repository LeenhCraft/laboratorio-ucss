<?php

namespace App\Controllers\Admin;

use App\Controllers\Controller;
use App\Models\TableModel;
use Exception;

class OcurrenciasController extends Controller
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
        return $this->render($response, 'App.Ocurrencias.Ocurrencias', [
            'titulo_web' => 'Ocurrencias',
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
                "js/app/nw_ocurrencias.js"
            ],
            "data" => []
        ]);
    }

    public function list($request, $response)
    {
        // obtener los parametros del $_GET en slim framework
        $params = $request->getQueryParams();
        $model = new TableModel;
        $model->setTable('lab_ocurrencias');
        $model->setId("idocurrencia");

        $model
            ->join("lab_prestamos", "lab_prestamos.idprestamo", "lab_ocurrencias.idprestamo")
            ->join("lab_ingresos_laboratorios", "lab_ingresos_laboratorios.idingreso", "lab_prestamos.idingreso")
            ->join("lab_docentes", "lab_docentes.iddocente", "lab_ingresos_laboratorios.iddocente");

        if (isset($params['estados']) && $params['estados'] != "") {
            $model->where("lab_ocurrencias.idestado", $params['estados']);
        }
        if (isset($params['severidad']) && $params['severidad'] != "") {
            $model->where("lab_ocurrencias.idseveridad", $params['severidad']);
        }

        return $this->respondWithJson(
            $response,
            $model->select(
                "lab_ingresos_laboratorios.titulo_practica",
                "lab_ingresos_laboratorios.asignatura",
                "lab_ocurrencias.idocurrencia",
                "lab_ocurrencias.fecha",
                "lab_ocurrencias.idestado",
                "lab_ocurrencias.idseveridad",
                "lab_ocurrencias.estudiante",
                "lab_ocurrencias.descripcion",
                "lab_docentes.nombre as docente",
            )
                ->orderBy("lab_ocurrencias.fecha", "DESC")
                ->get()
        );
    }

    public function listIngresos($request, $response)
    {
        $model = new TableModel;
        $model->setTable('lab_ingresos_laboratorios');
        $model->setId("idingreso");
        return $this->respondWithJson(
            $response,
            $model
                ->join("lab_docentes", "lab_docentes.iddocente", "lab_ingresos_laboratorios.iddocente")
                ->select(
                    "lab_ingresos_laboratorios.idingreso",
                    "lab_ingresos_laboratorios.titulo_practica",
                    "lab_ingresos_laboratorios.asignatura",
                    "lab_ingresos_laboratorios.ciclo",
                    "lab_docentes.nombre as docente",
                )
                ->orderBy("lab_ingresos_laboratorios.fecha", "DESC")
                ->get()
        );
    }

    public function listMateriales($request, $response, $args)
    {
        $data = $this->sanitize($args);
        $model = new TableModel;
        $model->setTable('lab_prestamos');
        $model->setId("idprestamo");

        $materiales = $model
            ->join("lab_detalle_prestamos", "lab_detalle_prestamos.idprestamo", "lab_prestamos.idprestamo")
            ->join("lab_balance_inventarios", "lab_balance_inventarios.idbalance", "lab_detalle_prestamos.idbalance")
            ->where("lab_prestamos.idingreso", $data['idingreso'])
            ->get();

        foreach ($materiales as $key => $value) {
            if (!empty($value['idproducto'])) {
                $model = new TableModel;
                $model->setTable("lab_productos");
                $model->setId("idproducto");
            }
            if (!empty($value['idinsumo'])) {
                $model = new TableModel;
                $model->setTable("lab_insumos");
                $model->setId("idinsumo");
            }
            if (!empty($value['idmaterial'])) {
                $model = new TableModel;
                $model->setTable("lab_materiales");
                $model->setId("idmaterial");
            }
            $objeto = $model->find($value['idproducto'] ?? $value['idinsumo'] ?? $value['idmaterial']);
            $materiales[$key]['nombre'] = $objeto['nombre'] ?? "";
            $materiales[$key]['id'] = $objeto['idproducto'] ?? $objeto['idinsumo'] ?? $objeto['idmaterial'];
        }

        return $this->respondWithJson($response, $materiales);
    }

    public function searchIngreso($request, $response, $args)
    {
        if ($this->permisos['perm_r'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $this->sanitize($args);
        // return $this->respondWithJson($response, $data);
        if (empty($data['idingreso'])) {
            return $this->respondWithError($response, "Verifique los datos enviados, recargue la página e intente nuevamente");
        }
        $model = new TableModel;
        $model->setTable("lab_ingresos_laboratorios");
        $model->setId("idingreso");

        $rq = $model
            ->join("lab_docentes", "lab_docentes.iddocente", "lab_ingresos_laboratorios.iddocente")
            ->where("lab_ingresos_laboratorios.idingreso", $data['idingreso'])
            ->first();
        if (!empty($rq)) {
            return $this->respondWithJson($response, ["status" => true, "data" => $rq]);
        }

        return $this->respondWithError($response, "No se encontraron datos");
    }

    public function store($request, $response)
    {
        if ($this->permisos['perm_w'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $request->getParsedBody();
        $data["materiales"] = json_decode($data["materiales"], true);
        $data = $this->sanitize($data);

        if (isset($data["idocurrencia"]) && !empty($data["idocurrencia"])) {
            return $this->update($request, $response);
        }
        $errors = $this->validar($data);
        if (!$errors) {
            $msg = "Los campos con (*) son requeridos.";
            return $this->respondWithError($response, $msg);
        }
        if (empty($data["materiales"])) {
            return $this->respondWithError($response, "Debe seleccionar al menos un material.");
        }

        $model = new TableModel;
        $model->setTable("lab_prestamos");
        $model->setId("idprestamo");

        $prestamo = $model->where("idingreso", $data['idingreso'])->first();
        if (empty($prestamo)) {
            return $this->respondWithError($response, "No se encontraron datos del ingreso seleccionado.");
        }

        $model = new TableModel;
        $model->setTable("lab_ocurrencias");
        $model->setId("idocurrencia");

        $rq = $model->create([
            "idprestamo" => $prestamo["idprestamo"],
            "idestado" => $data['idestado'],
            "idseveridad" => $data['idseveridad'],
            "estudiante" => $data['estudiante'],
            "fecha" => date("Y-m-d"),
            "descripcion" => $data['descripcion'],
        ]);
        if (!empty($rq)) {
            // registrar el detalle de la ocurrencia
            $model = new TableModel;
            $model->setTable("lab_detalle_ocurrencias");
            $model->setId("iddetalle");

            foreach ($data['materiales'] as $key => $value) {
                $detalle = $model->create([
                    "idocurrencia" => $rq["idocurrencia"],
                    "iddetalle" => $value['materialId'],
                    "cantidad" => $value['cantidad'],
                    "descripcion" => $value['observaciones'],
                ]);
            }

            return $this->respondWithSuccess($response, "Ocurrencia registrada correctamente.");
        }
        return $this->respondWithError($response, "Error al guardar los datos.");
    }

    private  function validar($data)
    {
        if (empty($data['idingreso'])) {
            return false;
        }
        if (empty($data['estudiante'])) {
            return false;
        }
        if (empty($data['idestado'])) {
            return false;
        }
        if (empty($data['idseveridad'])) {
            return false;
        }
        if (empty($data['descripcion'])) {
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
        $model->setTable('lab_ocurrencias');
        $model->setId("idocurrencia");

        $rq = $model->find($data['idocurrencia']);
        if (!empty($rq)) {
            $model->emptyQuery();
            $model
                ->join("lab_prestamos", "lab_prestamos.idprestamo", "lab_ocurrencias.idprestamo")
                ->join("lab_ingresos_laboratorios", "lab_ingresos_laboratorios.idingreso", "lab_prestamos.idingreso")
                ->join("lab_docentes", "lab_docentes.iddocente", "lab_ingresos_laboratorios.iddocente");

            $cabecera = $model->select(
                "lab_ingresos_laboratorios.idingreso",
                "lab_ingresos_laboratorios.titulo_practica",
                "lab_ingresos_laboratorios.asignatura",
                "lab_ocurrencias.idocurrencia",
                "lab_ocurrencias.idprestamo",
                "lab_ocurrencias.fecha",
                "lab_ocurrencias.idestado",
                "lab_ocurrencias.idseveridad",
                "lab_ocurrencias.estudiante",
                "lab_ocurrencias.descripcion",
                "lab_docentes.nombre as docente",
            )
                ->where("lab_ocurrencias.idocurrencia", $data['idocurrencia'])
                ->first();

            $detalle = new TableModel;
            $detalle->setTable("lab_detalle_ocurrencias");
            $detalle->setId("id_detalle_ocurrencia");

            $body = $detalle
                ->select(
                    "lab_detalle_ocurrencias.id_detalle_ocurrencia as ido",
                    "lab_detalle_ocurrencias.iddetalle",
                    "lab_balance_inventarios.idproducto",
                    "lab_balance_inventarios.idinsumo",
                    "lab_balance_inventarios.idmaterial",
                    "lab_detalle_ocurrencias.cantidad",
                    "lab_detalle_ocurrencias.descripcion as observaciones",
                )
                ->join("lab_detalle_prestamos", "lab_detalle_ocurrencias.iddetalle", "lab_detalle_prestamos.iddetalle")
                ->join("lab_balance_inventarios", "lab_balance_inventarios.idbalance", "lab_detalle_prestamos.idbalance")
                ->where("lab_detalle_ocurrencias.idocurrencia", $data['idocurrencia'])
                ->get();

            foreach ($body as $key => $value) {
                if (!empty($value['idproducto'])) {
                    $model = new TableModel;
                    $model->setTable("lab_productos");
                    $model->setId("idproducto");
                }
                if (!empty($value['idinsumo'])) {
                    $model = new TableModel;
                    $model->setTable("lab_insumos");
                    $model->setId("idinsumo");
                }
                if (!empty($value['idmaterial'])) {
                    $model = new TableModel;
                    $model->setTable("lab_materiales");
                    $model->setId("idmaterial");
                }
                $objeto = $model->find($value['idproducto'] ?? $value['idinsumo'] ?? $value['idmaterial']);
                $body[$key]['nombre'] = $objeto['nombre'] ?? "";
            }

            $cabecera["detalle"] = $body;

            return $this->respondWithJson($response, [
                "status" => true,
                "message" => "Registro encontrado.",
                "data" =>  $cabecera
            ]);
        }
        return $this->respondWithError($response, "No se encontraron datos.");
    }

    private function validarSearch($data)
    {
        if (empty($data["idocurrencia"])) {
            return false;
        }
        return true;
    }

    public function update($request, $response)
    {
        if ($this->permisos['perm_u'] !== "1") {
            return $this->respondWithError($response, "No tiene permisos para realizar esta acción");
        }
        $data = $request->getParsedBody();
        $data["materiales"] = json_decode($data["materiales"], true);
        $data = $this->sanitize($data);
        // {
        //     "idocurrencia": "2",
        //     "idingreso": "1",
        //     "titulo_practica": "1",
        //     "estudiante": "benites",
        //     "idestado": "2",
        //     "idseveridad": "2",
        //     "descripcion": "asd",
        //     "materiales": [
        //         {
        //             "materialId": "1",
        //             "nombre": "\u00c1cido acetil sal\u00edcilico 100mg",
        //             "cantidad": "1",
        //             "unidad": "unidad",
        //             "observaciones": "",
        //             "tipo_item": "insumo",
        //             "id_item": "1"
        //         }
        //     ]
        // }
        $errors = $this->validarUpdate($data);
        if (!$errors) {
            $msg = "Los campos con (*) son requeridos.";
            return $this->respondWithError($response, $msg);
        }
        if (empty($data["materiales"])) {
            return $this->respondWithError($response, "Debe seleccionar al menos un material.");
        }

        $model = new TableModel;
        $model->setTable("lab_prestamos");
        $model->setId("idprestamo");

        $prestamo = $model->where("idingreso", $data['idingreso'])->first();
        if (empty($prestamo)) {
            return $this->respondWithError($response, "No se encontraron datos del ingreso seleccionado.");
        }

        $model = new TableModel;
        $model->setTable("lab_ocurrencias");
        $model->setId("idocurrencia");

        $rq = $model->update($data["idocurrencia"], [
            // "idprestamo" => $prestamo["idprestamo"],
            "idestado" => $data['idestado'],
            "idseveridad" => $data['idseveridad'],
            "estudiante" => $data['estudiante'],
            // "fecha" => date("Y-m-d"),
            "descripcion" => $data['descripcion'],
        ]);
        if (!empty($rq)) {
            // registrar el detalle de la ocurrencia
            $model = new TableModel;
            $model->setTable("lab_detalle_ocurrencias");
            $model->setId("iddetalle");

            /* obtener todos los registro del detalle en base al idocurrencia, luego compararlo con $data["materiales"] y actualizar los datos que coincidan, los datos que no estan en el $data debemos crearlo y los registros que estan en la base de datos pero no en $data significa que han sido eliminados */

            $detalle = $model
                ->where("idocurrencia", $data["idocurrencia"])
                ->get();
            $ids = array_column($detalle, "iddetalle");
            $idsData = array_column($data["materiales"], "materialId");

            // eliminar los registros que no estan en $data
            $delete = array_diff($ids, $idsData);

            // dep([
            //     "detalle" => $detalle,
            //     "materiales"=> $data["materiales"],
            //     "ids" => $ids,
            //     "idsData" => $idsData,
            //     "delete" => $delete
            // ], 1);

            if (!empty($delete)) {
                foreach ($delete as $key => $value) {
                    $model->delete($value);
                }
                // $model->deleteWhereIn("iddetalle", $delete);
            }

            foreach ($data['materiales'] as $key => $value) {
                if (empty($value['ido'])) {
                    $detalle = $model->create([
                        "idocurrencia" => $data["idocurrencia"],
                        "iddetalle" => $value['materialId'],
                        "cantidad" => $value['cantidad'],
                        "descripcion" => $value['observaciones'],
                    ]);
                } else {
                    $model->update($value['ido'], [
                        "iddetalle" => $value['materialId'],
                        "cantidad" => $value['cantidad'],
                        "descripcion" => $value['observaciones'],
                    ]);
                }
            }

            return $this->respondWithSuccess($response, "Ocurrencia actualizada correctamente.");
        }
        return $this->respondWithError($response, "Error al guardar los datos.");
    }

    private function validarUpdate($data)
    {
        if (empty($data['idocurrencia'])) {
            return false;
        }
        if (empty($data['idingreso'])) {
            return false;
        }
        if (empty($data['estudiante'])) {
            return false;
        }
        if (empty($data['idestado'])) {
            return false;
        }
        if (empty($data['idseveridad'])) {
            return false;
        }
        if (empty($data['descripcion'])) {
            return false;
        }
        return true;
    }

    public function generarpdf($request, $response)
    {
        try {
            $queryParams = $request->getQueryParams();
            $idocurrencia = isset($queryParams['idocurrencia']) ? $queryParams['idocurrencia'] : null;

            if (!$idocurrencia) {
                throw new Exception("ID de ocurrencia no proporcionado");
            }

            $model = new TableModel;
            $model->setTable('lab_ocurrencias');
            $model->setId("idocurrencia");

            // Obtener los datos de la ocurrencia
            $sql = "SELECT 
                    o.idocurrencia,
                    o.fecha,
                    o.descripcion,
                    e.nombre as estado,
                    s.nombre as severidad,
                    il.titulo_practica,
                    il.asignatura,
                    o.estudiante,
                    d.nombre as docente
                FROM lab_ocurrencias o
                INNER JOIN lab_estado e ON o.idestado = e.idestado
                INNER JOIN lab_severidad s ON o.idseveridad = s.idseveridad
                INNER JOIN lab_prestamos p ON o.idprestamo = p.idprestamo
                INNER JOIN lab_ingresos_laboratorios il ON p.idingreso = il.idingreso
                INNER JOIN lab_docentes d ON d.iddocente = il.iddocente
                WHERE o.idocurrencia = ?";

            $ocurrencia = $model
                ->query($sql, [$idocurrencia])
                ->first();

            if (empty($ocurrencia)) {
                throw new Exception("Ocurrencia no encontrada");
            }
            // Obtener los detalles/materiales
            $sqlDetalles = "SELECT 
                do.cantidad,
                do.descripcion as observaciones,
                CASE
                    WHEN b.idproducto > 0 THEN p.nombre
                    WHEN b.idinsumo > 0 THEN i.nombre
                    WHEN b.idmaterial > 0 THEN m.nombre
                END as nombre
                FROM lab_detalle_ocurrencias do
                INNER JOIN lab_detalle_prestamos dp ON do.iddetalle = dp.iddetalle
                INNER JOIN lab_balance_inventarios b ON dp.idbalance = b.idbalance
                LEFT JOIN lab_productos p ON b.idproducto = p.idproducto
                LEFT JOIN lab_insumos i ON b.idinsumo = i.idinsumo
                LEFT JOIN lab_materiales m ON b.idmaterial = m.idmaterial
                WHERE do.idocurrencia = ?";

            $detalles = $model
                ->query($sqlDetalles, [$idocurrencia])
                ->get();

            // Generar el nombre del archivo
            $fileName = 'Ocurrencia-' . preg_replace('/[^A-Za-z0-9\-]/', '', $ocurrencia['titulo_practica']);

            // Crear instancia de mPDF
            $mpdf = new \Mpdf\Mpdf([
                'margin_left' => 15,
                'margin_right' => 15,
                'margin_top' => 15,
                'margin_bottom' => 15,
                'format' => 'A4',
            ]);

            // Establecer el título del documento PDF
            $mpdf->SetTitle($fileName);

            // Estilos CSS
            $css = '
                body { font-family: Arial, sans-serif; }
                .header { 
                    text-align: center; 
                    margin-bottom: 30px;
                    border-bottom: 1px solid #000;
                    padding-bottom: 10px;
                }
                .fs-2 { font-size: 35px; }
                .logo-container {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 10px;
                }
                .title { 
                    font-size: 16px; 
                    font-weight: bold; 
                    text-align: center;
                    margin: 20px 0;
                }
                .form-group {
                    margin-bottom: 15px;
                    border-bottom: 1px dotted #999;
                    padding-bottom: 5px;
                }
                .label {
                    font-weight: bold;
                    margin-right: 10px;
                }
                .content {
                    min-height: 25px;
                }
                .large-content {
                    min-height: 80px;
                }
                .signature-section {
                    margin-top: 50px;
                    display: flex;
                    justify-content: space-between;
                }
                .signature {
                    text-align: center;
                    width: 45%;
                }
                .signature-line {
                    border-top: 1px solid #000;
                    margin-top: 40px;
                    padding-top: 5px;
                }';

            $mpdf->WriteHTML($css, \Mpdf\HTMLParserMode::HEADER_CSS);

            // Contenido HTML actualizado
            $html = '
                <div class="header">
                    <div class="logo-container">
                        <div class="fs-2">UCSS</div>
                    </div>
                    <div class="title">FICHA DE OCURRENCIAS - SALA DE LABORATORIO UCSS</div>
                </div>

                <div class="form-group">
                    <span class="label">NOMBRE DE LA PRÁCTICA:</span>
                    <div class="content">' . htmlspecialchars($ocurrencia['titulo_practica']) . '</div>
                </div>

                <div class="form-group">
                    <span class="label">FECHA:</span>
                    <div class="content">' . $ocurrencia['fecha'] . '</div>
                </div>

                <div class="form-group">
                    <span class="label">ESTUDIANTE(S):</span>
                    <div class="content">' . htmlspecialchars($ocurrencia['estudiante']) . '</div>
                </div>

                <div class="form-group">
                    <span class="label">GRUPO DE TRABAJO:</span>
                    <div class="content">' . htmlspecialchars($ocurrencia['grupo_trabajo'] ?? '-') . '</div>
                </div>

                <div class="form-group">
                    <span class="label">OBSERVADOR:</span>
                    <div class="content">' . htmlspecialchars($ocurrencia['docente']) . '</div>
                </div>

                <div class="form-group">
                    <span class="label">CURSO:</span>
                    <div class="content">' . htmlspecialchars($ocurrencia['asignatura']) . '</div>
                </div>

                <div class="form-group">
                    <span class="label">INCIDENTE:</span>
                    <div class="large-content">' . nl2br(htmlspecialchars($ocurrencia['descripcion'])) . '</div>
                </div>

                <div class="form-group">
                    <span class="label">TRATAMIENTO:</span>
                    <div class="large-content">
                        Estado: ' . htmlspecialchars($ocurrencia['estado']) . '<br>
                        Severidad: ' . htmlspecialchars($ocurrencia['severidad']) . '
                    </div>
                </div>

                <div class="form-group">
                    <span class="label">MATERIALES AFECTADOS:</span>
                    <div class="content">';

            foreach ($detalles as $detalle) {
                $html .= '- ' . htmlspecialchars($detalle['nombre']) .
                    ' (Cantidad: ' . $detalle['cantidad'] . ')' .
                    ($detalle['observaciones'] ? ': ' . htmlspecialchars($detalle['observaciones']) : '') .
                    '<br>';
            }

            $html .= '</div>
                </div>

                <div class="form-group">
                    <span class="label">COMPROMISO:</span>
                    <div class="large-content"></div>
                </div>

                <div class="signature-section">
                    <div class="signature">
                        <div class="signature-line">FIRMA DEL DOCENTE</div>
                    </div>
                    <div class="signature">
                        <div class="signature-line">FIRMA DEL ESTUDIANTE</div>
                    </div>
                </div>';

            $mpdf->WriteHTML($html);

            // Generar PDF
            $pdfContent = $mpdf->Output('', 'S');
            // Configurar headers para mostrar en línea
            $response = $response->withHeader('Content-Type', 'application/pdf')
                ->withHeader('Content-Disposition', 'inline; filename="' . $fileName . '.pdf"');
            $pdfContent = $mpdf->Output('', 'S');
            $response->getBody()->write($pdfContent);
            return $response;
        } catch (Exception $e) {
            return $this->respondWithJson($response, ["error" => $e->getMessage()]);
        }
    }
}
