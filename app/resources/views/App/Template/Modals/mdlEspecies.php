<div class="modal fade" id="mdlEspecies" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmEspecies" class="modal-content" onsubmit="return save(this,event)">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">Crear Nuevo Especies</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="idespecie" name="idespecie" value="">
                <div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="nombre">nombre</label>
                	<input type="text" class="form-control" id="nombre" name="nombre">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="estado">estado</label>
                	<input type="text" class="form-control" id="estado" name="estado">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="eliminado">eliminado</label>
                	<input type="text" class="form-control" id="eliminado" name="eliminado">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="fecha_registro">fecha_registro</label>
                	<input type="text" class="form-control" id="fecha_registro" name="fecha_registro">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="ultima_actualizacion">ultima_actualizacion</label>
                	<input type="text" class="form-control" id="ultima_actualizacion" name="ultima_actualizacion">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button id="btnActionForm" type="submit" class="btn btn-outline-primary">Guardar</button>
            </div>
        </form>
    </div>
</div>