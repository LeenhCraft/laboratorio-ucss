<div class="modal fade" id="mdlDesparasitaciones" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<form id="frmDesparasitaciones" class="modal-content" onsubmit="return save(this,event)">
			<input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
			<input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">Crear Nuevo Desparasitaciones</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="iddesparacitacion" name="iddesparacitacion" value="">
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idpropietario">Propietarios</label>
					<select name="idpropietario" id="idpropietario" class="form-select"></select>
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idmascota">mascota</label>
					<select name="idmascota" id="idmascota" class="form-select"></select>
				</div>
				<div class="row">
					<div class="mb-3 col-lg-6 col-12">
						<label class="form-label text-capitalize" for="tipo">tipo</label>
						<input type="text" class="form-control" id="tipo" name="tipo">
					</div>
					<div class="mb-3 col-lg-6 col-12">
						<label class="form-label text-capitalize" for="producto">producto</label>
						<input type="text" class="form-control" id="producto" name="producto">
					</div>
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="peso">peso</label>
					<input type="text" class="form-control" id="peso" name="peso">
				</div>
				<div class="row">
					<div class="mb-3 col-lg-6 col-12">
						<label class="form-label text-capitalize" for="fecha_vacuna">fecha vacuna</label>
						<input type="text" class="form-control" id="fecha_vacuna" name="fecha_vacuna">
					</div>
					<div class="mb-3 col-lg-6 col-12">
						<label class="form-label text-capitalize" for="proxima_vacuna">proxima vacuna</label>
						<input type="text" class="form-control" id="proxima_vacuna" name="proxima_vacuna">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
				<button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
			</div>
		</form>
	</div>
</div>