<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title><?php echo $data['title']; ?></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="description">
    <link rel="icon" type="image/png" href="/favicon.ico">
    <meta name="Author" lang="es" content="leenhcraft.com">
    <link rel="stylesheet" href="/css/output.css">
    <link href='/node_modules/boxicons/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://kit.fontawesome.com/b4dffa1b79.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/app/plugins/select2.min.css">
    <link rel="stylesheet" href="/css/app/plugins/select2-bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.min.css">

    <?php
    if (isset($data['css']) && !empty($data['css'])) {
        for ($i = 0; $i < count($data['css']); $i++) {
            echo '<link rel="stylesheet" type="text/css" href="' . $data['css'][$i] . '">';
        }
    }
    ?>

</head>

<body class="font-montserrat">
    <div id="divLoading" style="display: none;">
        <div>
            <img src="/img/loading.svg" alt="Loading">
        </div>
    </div>
    <div class="hidden w-full bg-gradient-to-r from-secondary-500 to-primary-500 md:block">
        <div class="py-2 px-4 md:max-w-screen-lg md:flex md:justify-between md:py-0 md:px-1 md:mx-auto">
            <p class="mb-2 flex gap-4 md:mb-0">
                <a href="#" class="flex items-center text-sm text-white mr-2"><i class='bx bxs-phone mr-1'></i>+00 1234 567</a>
                <a href="#" class="flex items-center text-sm text-white"><i class='bx bxs-envelope mr-1'></i>youremail@email.com</a>
            </p>
            <p class="mb-0 flex gap-4 text-lg text-white">
                <a href="#" class="flex items-center justify-center p-2">
                    <i class="bx bxl-facebook"></i>
                </a>
                <a href="#" class="flex items-center justify-center p-2">
                    <i class="bx bxl-twitter"></i>
                </a>
                <a href="#" class="flex items-center justify-center p-2">
                    <i class="bx bxl-instagram"></i>
                </a>
                <a href="/admin" class="flex items-center justify-center p-2">
                    <i class="bx bxl-dribbble"></i>
                </a>
            </p>
        </div>
        <div></div>
    </div>
    <?php include_once __DIR__ . '/navbar_web.php' ?>