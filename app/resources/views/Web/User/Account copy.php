<?php headerWeb('Web.Template.header_web', $data); ?>
<section class="md:max-w-screen-lg md:mx-auto">
    <div class="container">
        <div class="row">
            <div class="col-12 col-sm-12 col-md-3 bborder border-success">
                <?php include_once __DIR__ . '/navbarUser.php'; ?>
            </div>
            <div class="col-12 col-sm-12 col-md-9 bborder border-success">
                <form id="account_form" novalidate="novalidate">
                    <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
                    <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
                    <input type="hidden" name="id" value="<?= $data['user']['idusuario'] ?>">

                    <div class="form-row align-items-end d-none">
                        <div class="form-group col-12 col-md-6">
                            <label for="address">Foto de perfil</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="profile" name="profile">
                                <label class="custom-file-label" for="profile">Choose file</label>
                            </div>
                        </div>
                        <div class="form-group col-12 col-md-6">
                            <div class="w-25 mx-auto">
                                <img src="https://via.placeholder.com/120x120" class="card-img-top" alt="...">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="email">Usuario</label>
                            <input type="email" class="form-control" id="email" readonly placeholder="<?= $data['user']['usu_cuenta'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="name">Nombre completo</label>
                            <input type="text" class="form-control" id="name" name="name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Ingrese su nombre completo'" placeholder='Ingrese su nombre completo' value="<?= $data['user']['usu_nombres'] . $data["user"]["usu_apellidos"] ?>">
                        </div>
                    </div>
                    <hr class="d-none">
                    <div class="form-row d-none">
                        <div class="form-group col-md-6">
                            <label for="password">Contraseña:</label>
                            <input type="password" class="form-control" id="password" name="password" autocomplete="new-password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Ingrese su contraseña'" placeholder='Ingrese su contraseña'>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="password_confirmation">Confirmar Contraseña:</label>
                            <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" autocomplete="new-password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Ingrese nuevamente la contraseña'" placeholder='Ingrese nuevamente la contraseña'>
                        </div>
                    </div>
                    <hr class="d-none">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="fecha">Fecha de registro</label>
                            <input type="text" class="form-control border border-0" id="fecha" value="<?= $data['user']['usu_fecha_registro'] ?>" readonly>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">Actualizar</button>
                </form>
            </div>
        </div>
    </div>
</section>
<?php footerWeb('Web.Template.footer_web', $data); ?>