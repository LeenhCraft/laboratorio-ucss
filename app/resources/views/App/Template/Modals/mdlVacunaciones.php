<div class="modal fade" id="mdlVacunaciones" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<form id="frmVacunaciones" class="modal-content" onsubmit="return save(this,event)">
			<input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
			<input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">
					<span>
						Crear Nuevo Vacunaciones
					</span>
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="idvacuna" name="idvacuna" value="">
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idpropietario">Propietarios</label>
					<select name="idpropietario" id="idpropietario" class="form-select"></select>
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="idmascota">mascota</label>
					<select name="idmascota" id="idmascota" class="form-select"></select>
				</div>
				<div class="row">
					<div class="mb-3 col-lg-6 col-12 text-capitalize">
						<label class="form-label text-capitalize" for="edad">edad</label>
						<input type="text" class="form-control" id="edad" name="edad">
					</div>
					<div class="mb-3 col-lg-6 col-12 text-capitalize">
						<label class="form-label text-capitalize" for="peso">peso</label>
						<input type="text" class="form-control" id="peso" name="peso">
					</div>
				</div>
				<div class="mb-3 col-lg-12 col-12">
					<label class="form-label text-capitalize" for="tipo_vacuna">Tipo de Vacuna</label>
					<input type="text" class="form-control" id="tipo_vacuna" name="tipo_vacuna">
				</div>
				<div class="row">
					<div class="mb-3 col-12 col-lg-6">
						<label class="form-label text-capitalize" for="fecha_vacuna">Fecha</label>
						<input type="date" class="form-control" id="fecha_vacuna" name="fecha_vacuna">
					</div>
					<div class="mb-3 col-12 col-lg-6">
						<label class="form-label text-capitalize" for="proxima_vacuna">Proxima Fecha</label>
						<input type="date" class="form-control" id="proxima_vacuna" name="proxima_vacuna">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
				<button id="btnActionForm" type="submit" class="btn btn-outline-primary">
					<span>
						Guardar
					</span>
				</button>
			</div>
		</form>
	</div>
</div>