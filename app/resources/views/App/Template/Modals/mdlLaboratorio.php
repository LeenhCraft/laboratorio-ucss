<div class="modal fade" id="mdlLaboratorio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<form id="frmLaboratorio" class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title title-laboratorio">
					<i class="fa-solid fa-flask-vial me-1"></i>
					<span>Laboratorio - Nuevo Ingreso</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" name="id" id="id">
				<div class="row">
					<div class="col-12">
						<button id="limpiar" class="btn btn-label-info btn-sm fw-light" type="button">
							<i class='bx bxs-brush me-2'></i>
							<span class="d-none d-lg-block">Borrar todo</span>
						</button>
					</div>
					<hr class="my-3">
					<div class="col-12 col-lg-8">
						<label class="fw-bold form-label text-capitalize" for="titulo_practica">Titulo de la practica</label>
						<input id="titulo_practica" name="titulo_practica" type="text" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="nro_practicas">N° Practicas</label>
						<input id="nro_practicas" name="nro_practicas" type="number" class="form-control" value="0">
					</div>
					<div class="col-12">
						<label class="fw-bold form-label text-capitalize" for="carrera">Carrera</label>
						<input id="carrera" name="carrera" type="text" class="form-control">
					</div>
					<div class="col-12">
						<label class="fw-bold form-label text-capitalize" for="iddocente">Docente</label>
						<div class="row">
							<div class="col-9 col-lg-9">
								<select name="iddocente" id="iddocente" class="form-select"></select>
							</div>
							<div class="col-3 col-lg-2">
								<button id="nuevoDocente" class="btn btn-outline-primary" type="button">
									<i class="fa-solid fa-user-plus me-1"></i>
									<span>Nuevo</span>
								</button>
							</div>
						</div>
					</div>
					<!--  -->
					<!--  -->
					<div class="col-12">
						<label class="fw-bold form-label text-capitalize" for="asignatura">Asignatura</label>
						<input id="asignatura" name="asignatura" type="text" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="turno">Turno</label>
						<input id="turno" name="turno" type="text" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="ciclo">Ciclo</label>
						<input id="ciclo" name="ciclo" type="number" class="form-control" value="0">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="fecha">Fecha</label>
						<input id="fecha" name="fecha" type="date" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="hora_inicio">Hora inicio</label>
						<input id="hora_inicio" name="hora_inicio" type="time" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="hora_fin">Hora fin</label>
						<input id="hora_fin" name="hora_fin" type="time" class="form-control">
					</div>
					<div class="col-12 col-lg-4">
						<label class="fw-bold form-label text-capitalize" for="nro_estudiantes">N° Estudiantes</label>
						<input id="nro_estudiantes" name="nro_estudiantes" type="number" class="form-control" value="0">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary fw-normal" data-bs-dismiss="modal">
					<i class="fa-regular fa-circle-xmark me-2"></i>
					<span>Cerrar</span>
				</button>
				<button type="submit" class="btn btn-primary fw-semibold">
					<i class="fa-solid fa-shield-halved me-2"></i>
					<span>
						Guardar
					</span>
				</button>
			</div>
		</form>
	</div>
</div>

<div class="modal fade" id="mdlCargo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title title-laboratorio">
					<i class="fa-solid fa-flask-vial me-1"></i>
					<span>Prestamos de equipos y materiales</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" name="id" id="idingreso">
				<div class="row">
					<div class="col-12">
						<button id="limpiarEquipos" class="btn btn-label-info btn-sm fw-light" type="button">
							<i class='bx bxs-brush me-2'></i>
							<span class="d-none d-lg-block">Borrar todo</span>
						</button>
					</div>
					<hr class="my-3">
					<div class="col-12">
						<h4 id="ver_titulo" class="m-0 fw-bold"></h4>
						<div id="ver_docente" class="fw-semibold form-text text-upercase text-black"></div>
					</div>
				</div>
				<hr class="my-3">
				<div class="row mb-3">
					<div class="col-12 col-lg-6">
						<label class="fw-bold form-label text-capitalize" for="titulo_practica">Material <span class="text-lowercase">y/o</span> Equipo</label>
						<select name="idbien" id="idbien" class="form-select">
							<option value="0">Seleccione una opción</option>
						</select>
					</div>
					<div class="col-6 col-lg-2">
						<label for="cantidad" class="fw-bold form-label text-capitalize">Cantidad</label>
						<input type="text" name="cantidad" id="cantidad" class="form-control" value="1">
					</div>
					<div class="col-12 col-lg-3 d-flex align-items-end">
						<button id="add-bien" class="btn btn-outline-primary py-1" type="button">
							<i class="fa-solid fa-shield-halved me-2"></i>
							<span>Agregar</span>
						</button>
					</div>
				</div>
				<div class="min-h-52">
					<style>
						#tbll_wrapper {
							padding: 0;
						}
					</style>
					<table id="tbll" class="table table-hover" width="100%">
						<thead>
							<tr>
								<th>Equipo/Material</th>
								<th>cantidad</th>
								<th>estado</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary fw-normal" data-bs-dismiss="modal">
					<i class="fa-regular fa-circle-xmark me-2"></i>
					<span>Cerrar</span>
				</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="mdlListaArticulos" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title title-view">
					<i class="fa-solid fa-flask-vial me-1"></i>
					<span>Lista de articulos</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="min-h-52">
					<style>
						#tbll_wrapper {
							padding: 0;
						}
					</style>
					<table id="lista-articulos" class="table table-hover" width="100%">
						<thead>
							<tr>
								<th>Equipo/Material</th>
								<th>cantidad</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>

<div class="modal fade" id="mdlRetorno" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title title-view">
					<i class="fa-solid fa-flask-vial me-1"></i>
					<span>Lista de articulos - Retornar</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="min-h-52">
					<style>
						#tbll_wrapper {
							padding: 0;
						}
					</style>
					<table id="articulos-retorno" class="table" width="100%">
						<thead>
							<tr>
								<th>Equipo/Material</th>
								<th>cantidad</th>
								<th>Estado</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>