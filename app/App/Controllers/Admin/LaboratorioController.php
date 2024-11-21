<?php

namespace App\Controllers\Admin;

use App\Controllers\Clases\BalanceClass;
use App\Controllers\Clases\MovimientosClass;
use App\Controllers\Controller;
use App\Models\TableModel;

/**
 * Class Laboratorio Controller
 */
class LaboratorioController extends Controller
{
	protected $permisos = [];
	protected $responseFactory;
	protected $guard;


	/**
	 * Constructor de la clase
	 */
	public function __construct()
	{
		parent::__construct();
		$this->permisos = getPermisos($this->className($this));
	}


	/**
	 * Muestra la vista principal
	 */
	public function index($request, $response)
	{
		return $this->render($response, 'App.Laboratorio.Laboratorio', [
			'titulo_web' => 'Laboratorio',
			'url' => $request->getUri()->getPath(),
			'permisos' => $this->permisos,
			"css" => [
				"vendor/select2/select2/dist/css/select2.min.css",
				'node_modules/flatpickr/dist/flatpickr.min.css',
				"css/select2-custom.css",
			],
			"js" => [
				"vendor/select2/select2/dist/js/select2.min.js",
				'node_modules/flatpickr/dist/flatpickr.min.js',
				'node_modules/flatpickr/dist/l10n/es.js',
				"js/app/nw_laboratorio.js"
			],
		]);
	}


	/**
	 * Lista los datos de la tabla
	 */
	public function list($request, $response)
	{
		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");
		$arrData = $model
			->select("lab_ingresos_laboratorios.*", "lab_docentes.nombre as docente")
			->leftJoin("lab_docentes", "lab_ingresos_laboratorios.iddocente", "lab_docentes.iddocente")
			->orderBy("fecha", "DESC")
			->orderBy("hora_inicio")
			->get();
		for ($i = 0; $i < count($arrData); $i++) {
			$arrData[$i]['delete'] = 0;
			$arrData[$i]['edit'] = 0;
			if ($this->permisos['perm_d'] == 1) {
				$arrData[$i]['delete'] = 1;
			}
			if ($this->permisos['perm_u'] == 1) {
				$arrData[$i]['edit'] = 1;
			}
		}
		return $this->respondWithJson($response, $arrData);
	}

	public function listDocentes($request, $response)
	{
		$model = new TableModel;
		$model->setTable("lab_docentes");
		$model->setId("iddocente");
		return $this->respondWithJson($response, $model->orderBy("nombre")->get());
	}

	/* public function listMateriales($request, $response)
	{
		$bienes = [];
		$producto = new TableModel;
		$producto->setTable("lab_detalle_inventarios");
		$producto->setId("idinventariodetalle");
		$bienes = array_merge(
			$bienes,
			$producto
				->select(
					"lab_productos.idproducto as id",
					"lab_productos.nombre",
					"lab_detalle_inventarios.idinventariodetalle"
				)
				->join("lab_productos", "lab_detalle_inventarios.idproducto", "lab_productos.idproducto")
				->get()
		);

		$insumos = new TableModel;
		$insumos->setTable("lab_detalle_inventarios");
		$insumos->setId("idinventariodetalle");
		$bienes = array_merge(
			$bienes,
			$insumos
				->select(
					"lab_insumos.idinsumo as id",
					"lab_insumos.nombre",
					"lab_detalle_inventarios.idinventariodetalle"
				)
				->join("lab_insumos", "lab_detalle_inventarios.idinsumo", "lab_insumos.idinsumo")
				->get()
		);

		$materiales = new TableModel;
		$materiales->setTable("lab_detalle_inventarios");
		$materiales->setId("idinventariodetalle");
		$bienes = array_merge(
			$bienes,
			$materiales
				->select(
					"lab_materiales.idmaterial as id",
					"lab_materiales.nombre",
					"lab_detalle_inventarios.idinventariodetalle"
				)
				->join("lab_materiales", "lab_detalle_inventarios.idmaterial", "lab_materiales.idmaterial")
				->get()
		);

		// dep($model->previewSql(), 1);
		return $this->respondWithJson($response, $bienes);
	} */

	public function listMateriales($request, $response)
	{
		$bienes = [];
		$producto = new TableModel;
		$producto->setTable("lab_balance_inventarios");
		$producto->setId("idbalance");
		$bienes = array_merge(
			$bienes,
			$producto
				->select(
					"lab_productos.idproducto as id",
					"lab_productos.nombre",
					"lab_balance_inventarios.idbalance"
				)
				->join("lab_productos", "lab_balance_inventarios.idproducto", "lab_productos.idproducto")
				->get()
		);
		$insumos = new TableModel;
		$insumos->setTable("lab_balance_inventarios");
		$insumos->setId("idbalance");
		$bienes = array_merge(
			$bienes,
			$insumos
				->select(
					"lab_insumos.idinsumo as id",
					"lab_insumos.nombre",
					"lab_balance_inventarios.idbalance"
				)
				->join("lab_insumos", "lab_balance_inventarios.idinsumo", "lab_insumos.idinsumo")
				->get()
		);
		$materiales = new TableModel;
		$materiales->setTable("lab_balance_inventarios");
		$materiales->setId("idbalance");
		$bienes = array_merge(
			$bienes,
			$materiales
				->select(
					"lab_materiales.idmaterial as id",
					"lab_materiales.nombre",
					"lab_balance_inventarios.idbalance"
				)
				->join("lab_materiales", "lab_balance_inventarios.idmaterial", "lab_materiales.idmaterial")
				->get()
		);
		// dep($model->previewSql(), 1);
		return $this->respondWithJson($response, $bienes);
	}

	public function listMaterialesIngreso($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		if (empty($data["id"])) {
			return $this->respondWithJson($response, []);
		}
		$model = new TableModel;
		$model->setTable("lab_prestamos");
		$model->setId("idprestamo");
		$prestamo = $model->where("idingreso", $data["id"])->first();
		if (empty($prestamo)) {
			return $this->respondWithJson($response, []);
		}
		$modelDetalle = new TableModel;
		$modelDetalle->setTable("lab_detalle_prestamos");
		$modelDetalle->setId("iddetalle");
		$detalles = $modelDetalle
			->select(
				"lab_detalle_prestamos.iddetalle",
				"lab_detalle_prestamos.idprestamo",
				"lab_detalle_prestamos.cantidad",
				"lab_detalle_prestamos.estado",
				"lab_balance_inventarios.idproducto",
				"lab_balance_inventarios.idinsumo",
				"lab_balance_inventarios.idmaterial",
			)
			->join("lab_balance_inventarios", "lab_detalle_prestamos.idbalance", "lab_balance_inventarios.idbalance")
			->where("idprestamo", $prestamo["idprestamo"])
			->get();
		if (empty($detalles)) {
			return $this->respondWithJson($response, []);
		}
		foreach ($detalles as $key => $value) {
			// segun el detalle, si idproducto, idinsumo o idmaterial hacer la busqueda en su respectiva tabla
			// para obtener los datos
			// (
			// 	[iddetalle] => 1
			// 	[idprestamo] => 1
			// 	[idproducto] => 
			// 	[idinsumo] => 4
			// 	[idmaterial] => 
			// )
			$detalles[$key]["nombre"] = "";
			if (!empty($value["idproducto"])) {
				$producto = new TableModel;
				$producto->setTable("lab_productos");
				$producto->setId("idproducto");
				$producto = $producto->find($value["idproducto"]);
				$detalles[$key]["nombre"] = $producto["nombre"];
			}
			if (!empty($value["idinsumo"])) {
				$insumo = new TableModel;
				$insumo->setTable("lab_insumos");
				$insumo->setId("idinsumo");
				$insumo = $insumo->find($value["idinsumo"]);
				$detalles[$key]["nombre"] = $insumo["nombre"];
			}
			if (!empty($value["idmaterial"])) {
				$material = new TableModel;
				$material->setTable("lab_materiales");
				$material->setId("idmaterial");
				$material = $material->find($value["idmaterial"]);
				$detalles[$key]["nombre"] = $material["nombre"];
			}
		}
		return $this->respondWithJson($response, $detalles);
	}
	/**
	 * Metodo para guardar nuevo registro
	 */
	public function store($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		if (isset($data["id"]) && !empty($data["id"])) {
			return $this->update($request, $response);
		}
		$errors = $this->validar($data);
		if (!$errors) {
			$msg = "Los campos con (*) son requeridos.";
			return $this->respondWithError($response, $msg);
		}
		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");
		// verificar que este disponible las horas de inicio y fin en la fecha seleccionada
		// 		SELECT * 
		// FROM lab_ingresos_laboratorios 
		// WHERE hora_inicio BETWEEN '14:15:00' AND '15:00:00' 
		//    OR hora_fin BETWEEN '14:15:00' AND '15:00:00' ;
		$existe = $model
			->orWhere(function ($query) use ($data) {
				$query
					->where("fecha", $data['fecha'])
					->where("hora_inicio", ">", $data['hora_inicio'])
					->where("hora_inicio", "<", $data['hora_fin']);
			})
			->orWhere(function ($query) use ($data) {
				$query
					->where("fecha", $data['fecha'])
					->where("hora_fin", ">", $data['hora_inicio'])
					->where("hora_fin", "<", $data['hora_fin']);
			})
			->where("cancelado", "0")
			->first();

		if (!empty($existe)) {
			return $this->respondWithError($response, "Ya existe un registro con esta hora de inicio y fin");
		}
		$data["titulo_practica"] = ucwords(strtolower($data["titulo_practica"]));
		$data["carrera"] = ucwords(strtolower($data["carrera"]));
		$data["asignatura"] = ucwords(strtolower($data["asignatura"]));
		$defaultValues = [
			"iddocente" => 0,
			'titulo_practica' => "Sin titulo",
			'nro_practicas' => 0,
			'carrera' => "Sin carrera",
			'asignatura' => "Sin asignatura",
			'turno' => "Sin turno",
			'ciclo' => 0,
			'fecha' => date("Y-m-d"),
			'hora_inicio' => "00:00",
			'hora_fin' => "00:00",
			'nro_estudiantes' => 0,
			'observaciones' => "",
			'completado' => 0
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

	public function storeDocente($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		if (isset($data["nombre"]) && empty($data["nombre"])) {
			return $this->respondWithError($response, "El nombre del docente es requerido");
		}
		$model = new TableModel;
		$model->setTable("lab_docentes");
		$model->setId("iddocente");
		$existe = $model
			->where("nombre", "LIKE", $data["nombre"])
			->where("codigo", "LIKE", $data["codigo"])
			->first();

		if (!empty($existe)) {
			return $this->respondWithError($response, "Ya existe un docente con este nombre y código");
		}
		$data["nombre"] = ucwords(strtolower($data["nombre"]));
		$rq = $model->create($data);
		if (!empty($rq)) {
			return $this->respondWithJson($response, ["status" => true, "data" => $rq]);
		}

		return $this->respondWithError($response, "Error al guardar los datos.");
	}

	public function storeMaterialIngreso($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		$errors = $this->validarStoreMaterial($data);
		if (!$errors) {
			$msg = "Verifique los datos ingresados";
			return $this->respondWithError($response, $msg);
		}
		$model = new TableModel();
		$model->setTable("lab_prestamos");
		$model->setId("idprestamo");
		$idprestamo = "";
		// buscando el prestamo
		$existe = $model
			->where("idingreso", $data["idingreso"])
			->first();
		// si no existe el prestamo
		if (empty($existe)) {
			// crear el prestamo
			$detalle = new TableModel();
			$detalle->setTable("lab_detalle_prestamos");
			$detalle->setId("iddetalle");
			$prestamo = $model->create([
				"idingreso" => $data["idingreso"],
				"fecha" => date("Y-m-d"),
				"observaciones" => null,
			]);
			$idprestamo = $prestamo["idprestamo"];
		}
		// si existe el prestamo
		if (!empty($existe)) {
			$idprestamo = $existe["idprestamo"];
		}
		$modelDetalle = new TableModel();
		$modelDetalle->setTable("lab_detalle_prestamos");
		$modelDetalle->setId("iddetalle");
		// buscando si existe el detalle
		$existeDetalle = $modelDetalle
			->where("idprestamo", $idprestamo)
			->where("idbalance", $data["id"])
			->first();
		$rq = "";
		// no existe el detalle
		if (empty($existeDetalle)) {
			// verificar stock en lab_balance_inventarios
			$existeDetalle["idbalance"] = $data["id"];
			$existeDetalle["cantidad_solicitada"] = $data["cantidad"];
			$hayStock = $this->verificarStock($existeDetalle);
			if (!$hayStock["status"]) {
				return $this->respondWithError($response, $hayStock["message"]);
			}
			// insertar el detalle
			$rq = $modelDetalle->create([
				"idprestamo" => $idprestamo,
				"idbalance" => $data["id"],
				"cantidad" => $data["cantidad"] ?? "1",
			]);
		} else {
			// existe el detalle

			// verificar stock en lab_balance_inventarios
			$existeDetalle["cantidad_solicitada"] = $data["cantidad"];
			$hayStock = $this->verificarStock($existeDetalle);
			if (!$hayStock["status"]) {
				return $this->respondWithError($response, $hayStock["message"]);
			}
			// actualizar el detalle

			// return $this->respondWithError($response, "Ya existe un detalle con este material");
			$rq = $modelDetalle->update(
				$existeDetalle["iddetalle"],
				[
					"cantidad" => $data["cantidad"] ?? "1",
				]
			);
		}
		// actualizar el estado del inventario
		$clsBalance = new BalanceClass;
		$hayStock["idbalance"] = $data["id"];
		$hayStock["descontar_cantidad"] = $data["cantidad"];
		$respuesta = $clsBalance->quitarStockPrestamo($hayStock);
		// registrar el movimiento en el historial
		$clsMovimientos = new MovimientosClass;
		$clsMovimientos->store([
			"idbalance" => $data["id"],
			"idinventariodetalle" => null,
			"tipo_movimiento" => 0,
			"tipo_detalle" => 2,
			"idmedida" => 2,
			"cantidad" => $data["cantidad"],
			"factor" => 1,
			"observaciones" => "Salida de inventario por prestamo",
		]);
		if (!empty($rq)) {
			return $this->respondWithSuccess($response, "Datos guardados correctamente. " . $respuesta["message"]);
		}
		return $this->respondWithError($response, "Error al guardar los datos.");
	}

	/**
	 * Metodo para verificar los datos
	 */
	public function validar($data)
	{
		if (empty($data['iddocente'])) {
			return false;
		}
		if (empty($data['titulo_practica'])) {
			return false;
		}
		if (empty($data['carrera'])) {
			return false;
		}
		if (empty($data['asignatura'])) {
			return false;
		}
		if (empty($data['turno'])) {
			return false;
		}
		if (empty($data['fecha'])) {
			return false;
		}
		if (empty($data['hora_inicio'])) {
			return false;
		}
		if (empty($data['hora_fin'])) {
			return false;
		}
		return true;
	}

	public function validarStoreMaterial($data)
	{
		if (empty($data['id'])) {
			return false;
		}
		if (empty($data['idingreso'])) {
			return false;
		}
		if (empty($data['cantidad'])) {
			return false;
		}
		return true;
	}

	private function verificarStock($data)
	{
		$clsBalance = new BalanceClass;
		return $respuesta = $clsBalance->verificarStock($data);
	}


	/**
	 * Metodo para buscar un registro por el id
	 */
	public function search($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		// return $this->respondWithJson($response, $data);

		$errors = $this->validarSearch($data);
		if (!$errors) {
			$msg = "Verifique los datos ingresados";
			return $this->respondWithError($response, $msg);
		}

		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");

		$rq = $model->find($data['id']);
		if (!empty($rq)) {
			return $this->respondWithJson($response, ["status" => true, "data" => $rq]);
		}

		$msg = "No se encontraron datos";
		return $this->respondWithError($response, $msg);
	}


	/**
	 * Metodo para verificar el campo de busqueda
	 */
	public function validarSearch($data)
	{
		if (empty($data['id'])) {
			return false;
		}
		return true;
	}


	/**
	 * Metodo para actualizar registro
	 */
	public function update($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		return $this->respondWithJson($response, $data);

		$errors = $this->validarUpdate($data);
		if (!$errors) {
			$msg = "Verifique los datos ingresados";
			return $this->respondWithError($response, $msg);
		}

		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");

		/*
		$existe = $model->where("field", "LIKE", $data['field'])->first();
		if (!empty($existe)) {
			$msg = "Ya tiene un registro creado con esta información.";
			return $this->respondWithError($response, $msg);
		}
		*/
		$defaultValues = [
			'titulo_practica' => '',
			'nro_practicas' => '',
			'carrera' => '',
			'asignatura' => '',
			'turno' => '',
			'ciclo' => '',
			'nro_estudiantes' => '',
			'observaciones' => '',
		];

		$dataInsert = [];
		foreach ($defaultValues as $key => $defaultValue) {
			$dataInsert[$key] = isset($data[$key]) && $data[$key] != "" ? $data[$key] : $defaultValue;
		}

		$rq = $model->update($data['idingreso'], $dataInsert);

		if (!empty($rq)) {
			$msg = "Datos actualizados";
			return $this->respondWithSuccess($response, $msg);
		}

		$msg = "Error al guardar los datos";

		return $this->respondWithJson($response, $msg);
	}


	/**
	 * Metodo para verificar los datos por actualizar
	 */
	public function validarUpdate($data)
	{
		if (empty($data['id'])) {
			return false;
		}
		if (empty($data['iddocente'])) {
			return false;
		}
		if (empty($data['titulo_practica'])) {
			return false;
		}
		if (empty($data['carrera'])) {
			return false;
		}
		if (empty($data['asignatura'])) {
			return false;
		}
		if (empty($data['turno'])) {
			return false;
		}
		return true;
	}


	/**
	 * Metodo para eliminar registro por id
	 */
	public function delete($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		// return $this->respondWithJson($response, $data);

		if (empty($data["idingreso"])) {
			return $this->respondWithError($response, "Error de validación, por favor recargue la página");
		}

		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");

		$rq = $model->find($data['idingreso']);
		if (!empty($rq)) {
			$rq = $model->delete($data["idingreso"]);
			if (!empty($rq)) {
				$msg = "Datos eliminados correctamente";
				return $this->respondWithSuccess($response, $msg);
			}
		}

		$msg = "Error al eliminar los datos";
		return $this->respondWithError($response, $msg);
	}

	public function deleteMaterialIngreso($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		// return $this->respondWithJson($response, $data);
		if (empty($data["id"])) {
			return $this->respondWithError($response, "Error de validación, por favor recargue la página");
		}
		$model = new TableModel;
		$model->setTable("lab_detalle_prestamos");
		$model->setId("iddetalle");
		$idbalance = [
			"idbalance" => "0",
			"reponer_cantidad" => "0",
		];
		$rq = $model->find($data['id']);
		if (!empty($rq)) {
			$idbalance["idbalance"] = $rq["idbalance"];
			$idbalance["reponer_cantidad"] = $rq["cantidad"];
			$rq = $model->delete($data["id"]);
			if (!empty($rq)) {
				$clsBalance = new BalanceClass;
				$respuesta = $clsBalance->reponerStockPrestamo($idbalance);
				// registrar el movimiento en el historial
				$clsMovimientos = new MovimientosClass;
				$clsMovimientos->store([
					"idbalance" => $idbalance["idbalance"],
					"idinventariodetalle" => NULL,
					"tipo_movimiento" => 1,
					"tipo_detalle" => 2,
					"idmedida" => 2,
					"cantidad" => $idbalance["reponer_cantidad"],
					"factor" => 1,
					"observaciones" => "Ingreso de inventario por eliminar un material que no se presto",
				]);
				return $this->respondWithSuccess($response, "Datos eliminados correctamente." . $respuesta["message"]);
			}
		}
		return $this->respondWithError($response, "Error al eliminar los datos.");
	}

	public function cancelarIngreso($request, $response)
	{
		// datos de entrada
		$data = $this->sanitize($request->getParsedBody());
		if (!isset($data["id"]) || empty($data["id"])) {
			return $this->respondWithError($response, "Para poder cancelar el ingreso, debe seleccionar un registro");
		}

		// proceso

		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");
		$existe = $model->find($data['id']);
		// verificar si el ingreso existe
		if (empty($existe)) {
			return $this->respondWithError($response, "No se encontro el registro");
		}
		// verificar si el ingreso ya fue cancelado
		if ($existe["cancelado"] == 1) {
			return $this->respondWithError($response, "El ingreso ya fue cancelado");
		}
		// reponer el stock de los materiales prestados
		$prestamo = new TableModel;
		$prestamo->setTable("lab_prestamos");
		$prestamo->setId("idprestamo");
		$cabeceraPrestamo = $prestamo->where("idingreso", $data["id"])->first();
		$detalle = new TableModel;
		$detalle->setTable("lab_detalle_prestamos");
		$detalle->setId("iddetalle");
		$cuerpoPrestamo = $detalle->where("idprestamo", $cabeceraPrestamo["idprestamo"])->get();
		foreach ($cuerpoPrestamo as $key => $value) {
			$clsBalance = new BalanceClass;
			$respuesta = $clsBalance->reponerStockPrestamo([
				"idbalance" => $value["idbalance"],
				"reponer_cantidad" => $value["cantidad"],
			]);
			// registrar el movimiento en el historial
			$clsMovimientos = new MovimientosClass;
			$clsMovimientos->store([
				"idbalance" => $value["idbalance"],
				"idinventariodetalle" => NULL,
				"tipo_movimiento" => 1,
				"tipo_detalle" => 3,
				"idmedida" => 2,
				"cantidad" => $value["cantidad"],
				"factor" => 1,
				"observaciones" => $data["motivo"] . " | Ingreso de inventario por cancelar un ingreso a laboratorio.",
			]);
		}
		// poner el stock de materiales prestados a cero en el detalle del prestamo
		foreach ($cuerpoPrestamo as $key => $value) {
			$detalle->update($value["iddetalle"], ["cantidad" => 0]);
		}
		// cancelar el ingreso
		$rq = $model->update($data['id'], ["cancelado" => 1]);

		// salida
		if (!empty($rq)) {
			return $this->respondWithSuccess($response, "Ingreso cancelado correctamente");
		}
		return $this->respondWithError($response, "Error al cancelar el ingreso");
	}

	function articuloDevuelto($request, $response)
	{
		// datos de entrada
		// viene el iddetalle
		$data = $this->sanitize($request->getParsedBody());
		if (!isset($data["id"]) || empty($data["id"])) {
			return $this->respondWithError($response, "Para poder devolver el material, debe seleccionar un registro");
		}

		// proceso
		$model = new TableModel;
		$model->setTable("lab_detalle_prestamos");
		$model->setId("iddetalle");
		$existe = $model->find($data['id']);
		// verificar que exista el detalle
		if (empty($existe)) {
			return $this->respondWithError($response, "No se encontro el registro");
		}

		if ($existe["estado"] === "Devuelto") {
			return $this->respondWithError($response, "El material ya fue devuelto");
		}

		// verificar que el material no tenga alguna ocurrencia
		$modelOcurrencia = new TableModel;
		$modelOcurrencia->setTable("lab_ocurrencias");
		$modelOcurrencia->setId("idocurrencia");

		$cabeceraOcurrencia = $modelOcurrencia
			->where("idprestamo", $data["idprestamo"])
			->first();

		$detallelOcurrencia = new TableModel;
		$detallelOcurrencia->setTable("lab_detalle_ocurrencias");
		$detallelOcurrencia->setId("id_detalle_ocurrencia");

		$ocurrencias = $detallelOcurrencia
			->where("iddetalle", $data["id"])
			->get();

		if (!empty($ocurrencias) && $cabeceraOcurrencia["idestado"] != "3") {
			return $this->respondWithError($response, "El material tiene ocurrencias, no se puede devolver");
		}

		// obtener la cantidad a retornar
		$cantidad = $existe["cantidad"];
		// obtener el idbalance para actualizar stock
		$idbalance = $existe["idbalance"];

		$balanceModel = new TableModel;
		$balanceModel->setTable("lab_balance_inventarios");
		$balanceModel->setId("idbalance");
		// actualizar estock
		$clsBalance = new BalanceClass;
		$respuesta = $clsBalance->reponerStockPrestamo([
			"idbalance" => $idbalance,
			"reponer_cantidad" => $cantidad,
		]);
		if (!$respuesta["status"]) {
			return $this->respondWithError($response, $respuesta["message"]);
		}
		// actualizar el estado como devuelto
		$model->update($data['id'], ["estado" => "Devuelto"]);
		// registrar el movimiento en el historial
		$clsMovimientos = new MovimientosClass;
		$clsMovimientos->store([
			"idbalance" => $idbalance,
			"idinventariodetalle" => NULL,
			"tipo_movimiento" => 1,
			"tipo_detalle" => 3,
			"idmedida" => 2,
			"cantidad" => $cantidad,
			"factor" => 1,
			"observaciones" => "Ingreso de inventario por devolución de material prestado.",
		]);
		// salida
		// retornar mensaje de exito o error
		return $this->respondWithSuccess($response, "Material devuelto correctamente");
	}

	public function completarIngreso($request, $response)
	{
		$data = $this->sanitize($request->getParsedBody());
		if (empty($data["id"])) {
			return $this->respondWithError($response, "Error de validación, por favor recargue la página.");
		}
		$model = new TableModel;
		$model->setTable("lab_ingresos_laboratorios");
		$model->setId("idingreso");
		$existe = $model->find($data["id"]);
		if (empty($existe)) {
			return $this->respondWithError($response, "No se encontro el registro");
		}
		if ($existe["completado"] == 1) {
			return $this->respondWithError($response, "El ingreso ya fue completado");
		}
		if ($existe["cancelado"] == 1) {
			return $this->respondWithError($response, "El ingreso fue cancelado, no se puede completar");
		}
		$rq = $model->update($data["id"], ["completado" => 1]);
		if (!empty($rq)) {
			return $this->respondWithSuccess($response, "Ingreso completado correctamente");
		}
		return $this->respondWithError($response, "Error al completar el ingreso.");
	}
}
