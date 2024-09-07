<div class="modal fade" id="mdlVentas" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <form id="frmVentas" class="modal-content" onsubmit="return save(this,event)">
            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">Crear Nuevo Ventas</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="idventa" name="idventa" value="">
                <div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="idconsulta">idconsulta</label>
                	<input type="text" class="form-control" id="idconsulta" name="idconsulta">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="idcliente">idcliente</label>
                	<input type="text" class="form-control" id="idcliente" name="idcliente">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="idusuario">idusuario</label>
                	<input type="text" class="form-control" id="idusuario" name="idusuario">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="idtipocomprobante">idtipocomprobante</label>
                	<input type="text" class="form-control" id="idtipocomprobante" name="idtipocomprobante">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="fecha_venta">fecha_venta</label>
                	<input type="text" class="form-control" id="fecha_venta" name="fecha_venta">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="serie_comprobante">serie_comprobante</label>
                	<input type="text" class="form-control" id="serie_comprobante" name="serie_comprobante">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="numero_comprobante">numero_comprobante</label>
                	<input type="text" class="form-control" id="numero_comprobante" name="numero_comprobante">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="subtotal">subtotal</label>
                	<input type="text" class="form-control" id="subtotal" name="subtotal">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="descuento">descuento</label>
                	<input type="text" class="form-control" id="descuento" name="descuento">
                </div>
				<div class="mb-3 col-lg-12 col-12">
                	<label class="form-label text-capitalize" for="total">total</label>
                	<input type="text" class="form-control" id="total" name="total">
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