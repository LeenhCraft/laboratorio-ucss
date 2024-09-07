<div class="modal fade" id="mdlReservarcitas" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<form id="frmReservarcitas" class="modal-content" onsubmit="return save(this,event)">
			<input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
			<input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">Crear Nuevo Reservarcitas</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="idreservacita" name="idreservacita" value="">
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="nombres">nombres</label>
					<input type="text" class="form-control" id="nombres" name="nombres">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="apellidos">apellidos</label>
					<input type="text" class="form-control" id="apellidos" name="apellidos">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="correo">correo</label>
					<input type="text" class="form-control" id="correo" name="correo">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="celular">celular</label>
					<input type="text" class="form-control" id="celular" name="celular">
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
					<label class="form-label text-capitalize" for="idespecie">idespecie</label>
					<input type="text" class="form-control" id="idespecie" name="idespecie">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idgenero">idgenero</label>
					<input type="text" class="form-control" id="idgenero" name="idgenero">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idraza">idraza</label>
					<input type="text" class="form-control" id="idraza" name="idraza">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="nombre_mascota">nombre_mascota</label>
					<input type="text" class="form-control" id="nombre_mascota" name="nombre_mascota">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="descripcion_mascota">descripcion_mascota</label>
					<input type="text" class="form-control" id="descripcion_mascota" name="descripcion_mascota">
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="motivo_consulta">motivo_consulta</label>
					<input type="text" class="form-control" id="motivo_consulta" name="motivo_consulta">
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