<!DOCTYPE html>
<html lang="es" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="/assets/" data-template="vertical-menu-template-free">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title><?php echo $data['titulo_web']; ?></title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/img/logo.png">
    <!-- <link rel="icon" type="image/x-icon" href="/img/favicon/favicon.ico" /> -->

    <!-- Fonts -->
    <link rel="stylesheet" href="/css/app/appfonts.css">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="/css/app/vendor/fonts/boxicons.css" />
    <script src="https://kit.fontawesome.com/b4dffa1b79.js" crossorigin="anonymous"></script>

    <!-- Core CSS -->
    <link rel="stylesheet" href="/css/app/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/css/app/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/css/app/custom.css" />

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
    <link rel="stylesheet" href="/css/app/demo.css">
    <!-- <link rel="stylesheet" href="/css/plugins/bootstrap-select.min.css"> -->

    <!-- <link rel="stylesheet" href="/css/app/plugins/select2.min.css">
    <link rel="stylesheet" href="/css/app/plugins/select2-bootstrap4.min.css"> -->
    <link rel="stylesheet" href="/css/datatables.bootstrap5.css">

    <!-- <link rel="stylesheet" href="https://cdn.datatables.net/1.12.0/css/jquery.dataTables.css"> -->

    <?php
    if (isset($data['css']) && !empty($data['css'])) {
        for ($i = 0; $i < count($data['css']); $i++) {
            echo '<link rel="stylesheet" type="text/css" href="' . base_url() . $data['css'][$i] . '">';
        }
    }
    ?>
</head>

<body>
    <div class="layout-wrapper layout-content-navbar">
        <div id="divLoading">
            <div>
                <img src="/img/loading.svg" alt="Loading">
            </div>
        </div>
        <div class="layout-container">
            <?php
            require_once __DIR__ . "/nav.php";
            ?>
            <div class="layout-page">
                <!-- Navbar -->

                <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
                    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                            <i class="bx bx-menu bx-sm"></i>
                        </a>
                    </div>

                    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                        <div class="w-100">
                            <div class="navbar-nav align-items-center w-100">
                                <div class="nav-item d-flex align-items-center w-100">
                                    <a class="w-100 border-0 app-header__logo text-dark text-start text-break user-select-none">
                                        <span>Bienvenido</span> <?php echo $nombre['nombre'] ?? "UNDEFINED"; ?>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <ul class="navbar-nav flex-row align-items-center ms-auto">
                            <!-- User -->
                            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                    <div class="avatar avatar-online">
                                        <img src="/img/placeholder-150x150.png" alt class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <div class="avatar avatar-online">
                                                        <img src="/img/placeholder-150x150.png" alt class="w-px-40 h-auto rounded-circle" />
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <span class="fw-semibold d-block"><?php echo $nombre['nombre'] ?? "UNDEFINED"; ?></span>
                                                    <small class="text-muted"><?php echo $nombre['rol'] ?? "UNDEFINED"; ?></small>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <div class="dropdown-divider"></div>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="bx bx-user me-2"></i>
                                            <span class="align-middle">Mi cuenta</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <i class="bx bx-cog me-2"></i>
                                            <span class="align-middle">Configuración</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/admin/logout">
                                            <i class="bx bx-power-off me-2"></i>
                                            <span class="align-middle">Cerrar y Salir</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <!--/ User -->
                        </ul>
                    </div>
                </nav>

                <!-- / Navbar -->
                <!-- Content wrapper -->
                <div class="content-wrapper">
                    <!-- Content -->
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="row mb-4 d-none">
                            <div class="col-6 mb-3 col-md-3 mb-md-0">
                                <a href="/" target="_blank">
                                    <div class="card card-border-shadow-primary h-100">
                                        <div class="card-body p-2 px-md-4 py-md-2">
                                            <div class="d-md-flex align-items-center mb-2 pb-md-1 gap-md-3">
                                                <div class="avatar m-0">
                                                    <span class="avatar-initial rounded bg-label-primary">
                                                        <i class="fa-solid fa-globe"></i>
                                                    </span>
                                                </div>
                                                <h5 class="m-0">Visitar el sitio web</h5>
                                            </div>
                                            <p class="mb-1 text-normal d-none d-md-block">
                                                El sitio web de la empresa donde los usuarios pueden consultar los servicios.
                                            </p>
                                            <p class="mb-0 d-none">
                                                <span class="fw-medium me-1">+18.2%</span>
                                                <small class="text-muted">than last week</small>
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-6 mb-3 col-md-3 mb-md-0">
                                <a href="/admin/mascotas">
                                    <div class="card card-border-shadow-warning h-100">
                                        <div class="card-body p-2 px-md-4 py-md-2">
                                            <div class="d-md-flex align-items-center mb-2 pb-md-1 gap-md-3">
                                                <div class="avatar m-0">
                                                    <span class="avatar-initial rounded bg-label-warning">
                                                        <i class="fa-solid fa-paw"></i>
                                                    </span>
                                                </div>
                                                <h5 class="m-0">Registrar Mascotas</h5>
                                            </div>
                                            <p class="mb-1 text-normal d-none d-md-block">
                                                El sitio web de la empresa donde los usuarios pueden consultar los servicios.
                                            </p>
                                            <p class="mb-0 d-none">
                                                <span class="fw-medium me-1">+18.2%</span>
                                                <small class="text-muted">than last week</small>
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-6 mb-3 col-md-3 mb-md-0">
                                <a href="/admin/crearconsulta">
                                    <div class="card card-border-shadow-success h-100">
                                        <div class="card-body p-2 px-md-4 py-md-2">
                                            <div class="d-md-flex align-items-center mb-2 pb-md-1 gap-md-3">
                                                <div class="avatar m-0">
                                                    <span class="avatar-initial rounded bg-label-success">
                                                        <i class="fa-solid fa-house-medical"></i>
                                                    </span>
                                                </div>
                                                <h5 class="m-0">Registrar Consultas</h5>
                                            </div>
                                            <p class="mb-1 text-normal d-none d-md-block">
                                                El sitio web de la empresa donde los usuarios pueden consultar los servicios.
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-6 mb-3 col-md-3 mb-md-0">
                                <a href="/admin/reservarcitas">
                                    <div class="card card-border-shadow-danger h-100">
                                        <div class="card-body p-2 px-md-4 py-md-2">
                                            <div class="d-md-flex align-items-center mb-2 pb-md-1 gap-md-3">
                                                <div class="avatar m-0">
                                                    <span class="avatar-initial rounded bg-label-danger">
                                                        <i class="fa-solid fa-house-medical"></i>
                                                    </span>
                                                </div>
                                                <h5 class="m-0">Reservar Citas</h5>
                                            </div>
                                            <p class="mb-1 text-normal d-none d-md-block">
                                                El sitio web de la empresa donde los usuarios pueden consultar los servicios.
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>