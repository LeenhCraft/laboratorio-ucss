<!DOCTYPE html>
<html lang="es" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="/assets/" data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title><?php echo $data['titulo_web']; ?></title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/favicon.ico">

    <!-- Fonts -->
    <link rel="stylesheet" href="/css/app/appfonts.css">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="/css/app/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="/css/app/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/css/app/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/css/app/custom.css" />
    <link rel="stylesheet" href="/css/app/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="/css/app/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="/css/app/vendor/css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="/js/app/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="/js/app/plugins/config.js"></script>

</head>

<body>
    <!-- Content -->

    <div class="container-xxl">
        <div class="authentication-wrapper authentication-basic container-p-y">
            <div class="authentication-inner">
                <div class="divLoading" style="display: none;">
                    <div>
                        <img src="/img/loading.svg" alt="Loading">
                    </div>
                </div>
                <!-- Register -->
                <div class="text-end mb-4 zindex-1 position-relative d-none">
                    <a href="/" class="text-end fw-bold" tabindex="0">
                        <i class='bx bx-arrow-back'></i>
                        Regresar
                    </a>
                </div>
                <div class="card">
                    <div class="card-body card-content">
                        <!-- Logo -->
                        <div class="app-brand justify-content-center mb-3">
                            <a href="/admin/login" class="app-brand-link gap-2">
                                <picture>
                                    <source srcset="/img/logo.png" type="image/webp">
                                    <img src="/img/logo.png" alt="Sneat" class="app-brand-logo w-px-200">
                                </picture>
                            </a>
                        </div>
                        <!-- /Logo -->
                        <h4 class="mb-2 text-center ff-niconne fs-1">Laboratorio UCSS</h4>
                        <form id="frmlogin" class="mb-3">
                            <input type="hidden" name="<?= $data['tk']['name'] ?>" value="<?= $data['tk']['key'][$data['tk']['name']]  ?>">
                            <input type="hidden" name="<?= $data['tk']['value'] ?>" value="<?= $data['tk']['key'][$data['tk']['value']] ?>">
                            <div class="mb-3">
                                <label for="email" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="email" name="email" placeholder="Ingrese su usuario" tabindex="1" value="admin" autofocus>
                            </div>
                            <div class="mb-3 form-password-toggle">
                                <div class="d-flex justify-content-between">
                                    <label class="form-label" for="password">Contraseña</label>
                                </div>
                                <div class="input-group input-group-merge">
                                    <input type="password" id="password" class="form-control" name="password" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="pass" tabindex="2" value="123123" />
                                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button id="boton" class="btn btn-primary d-grid w-100" type="submit" tabindex="3">Ingresar</button>
                            </div>
                        </form>

                        <p class="text-center">
                            <a href="#" class="">
                                <span>¿Ha olvidado tu contraseña?</span>
                            </a>
                        </p>
                    </div>
                    <div class="card-body card-success" style="display: none;">
                        <div class="app-brand justify-content-center">
                            <a href="/admin/login" class="app-brand-link gap-2">
                                <picture>
                                    <source srcset="/img/logo.png" type="image/webp">
                                    <img src="/img/logo.png" alt="<?= $_ENV["APP_NAME"]; ?>" class="app-brand-logo w-px-150">
                                </picture>
                            </a>
                        </div>
                        <h4 class="fs-1 ff-niconne mb-2 text-center"><?= $_ENV["APP_NAME"] ?></h4>
                        <p class="fs-2 text-center text-success">Redirigiendo...</p>
                    </div>
                </div>
                <!-- /Register -->
            </div>
        </div>
    </div>

    <!-- / Content -->

    <script>
        const base_url = "<?php echo base_url(); ?>";
    </script>

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="/js/app/plugins/jquery.min.js"></script>
    <script src="/js/app/plugins/popper.min.js"></script>
    <script src="/js/app/plugins/bootstrap.min.js"></script>

    <script src="/js/app/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="/js/app/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Main JS -->
    <script src="/js/app/plugins/main.js"></script>

    <script src="/js/app/plugins/sweetalert2.all.min.js"></script>
    <script>
        var divLoading = $(".divLoading");
        const Toast = Swal.mixin({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            showCloseButton: true,
            timer: 3000,
            timerProgressBar: true,
            didOpen: (toast) => {
                toast.addEventListener("mouseenter", Swal.stopTimer);
                toast.addEventListener("mouseleave", Swal.resumeTimer);
            },
        });

        function verpass(e, input) {
            let selector = "#" + input;
            let elem = $(selector);
            console.log(elem);

            if (elem.attr("type") == "password") {
                elem.attr("type", "text");
            } else {
                elem.attr("type", "password");
            }
        }
        document.addEventListener('DOMContentLoaded', (event) => {
            const tabOrder = ["email", "password", "boton"];
            const elements = tabOrder.map(id => document.getElementById(id));

            elements.forEach((el, index) => {
                el.addEventListener('keydown', (event) => {
                    if (event.key === 'Tab') {
                        event.preventDefault();
                        const nextIndex = (index + 1) % elements.length;
                        elements[nextIndex].focus();
                    }
                });
            });
        });
    </script>
    <?php
    if (isset($data['js']) && !empty($data['js'])) {
        for ($i = 0; $i < count($data['js']); $i++) {
            echo '<script src="' . base_url() . $data['js'][$i] . '"></script>';
        }
    }
    ?>

</body>

</html>