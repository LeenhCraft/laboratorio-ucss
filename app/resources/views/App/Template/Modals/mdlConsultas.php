<div class="modal fade" id="mdlConsultas" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable">
		<form id="frmConsultas" class="modal-content" onsubmit="return save(this,event)">
			<input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
			<input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">Crear Nuevo Consultas</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="idconsulta" name="idconsulta" value="">
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idreservacita">idreservacita</label>
					<input type="text" class="form-control" id="idreservacita" name="idreservacita">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idpropietario">idpropietario</label>
					<input type="text" class="form-control" id="idpropietario" name="idpropietario">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idmascota">idmascota</label>
					<input type="text" class="form-control" id="idmascota" name="idmascota">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idestado">idestado</label>
					<input type="text" class="form-control" id="idestado" name="idestado">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idpersonal">idpersonal</label>
					<input type="text" class="form-control" id="idpersonal" name="idpersonal">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="codigo">codigo</label>
					<input type="text" class="form-control" id="codigo" name="codigo">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="fecha_consulta">fecha_consulta</label>
					<input type="text" class="form-control" id="fecha_consulta" name="fecha_consulta">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="hora_consulta">hora_consulta</label>
					<input type="text" class="form-control" id="hora_consulta" name="hora_consulta">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="diagnostico">diagnostico</label>
					<input type="text" class="form-control" id="diagnostico" name="diagnostico">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="observaciones">observaciones</label>
					<input type="text" class="form-control" id="observaciones" name="observaciones">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="fecha_registro">fecha_registro</label>
					<input type="text" class="form-control" id="fecha_registro" name="fecha_registro">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="ultima_actualizacion">ultima_actualizacion</label>
					<input type="text" class="form-control" id="ultima_actualizacion" name="ultima_actualizacion">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="eliminado">eliminado</label>
					<input type="text" class="form-control" id="eliminado" name="eliminado">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
				<button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
			</div>
		</form>
	</div>
</div>