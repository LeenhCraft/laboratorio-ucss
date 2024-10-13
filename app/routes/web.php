<?php

// use Slim\App;

use App\Controllers\Admin\LoginAdminController;
use App\Controllers\Admin\MascotasController;
use Slim\Routing\RouteCollectorProxy;

// Controllers
use App\Controllers\HomeController;
use App\Controllers\Login\ForgotPasswordController;
use App\Controllers\Login\LoginController;
use App\Controllers\Login\RegisterController;
use App\Controllers\Login\verifyController;
use App\Controllers\LogoutController;
use App\Controllers\User\AccountController;
use App\Controllers\WebController;
use App\Middleware\AdminMiddleware;
// Middlewares
use App\Middleware\LoginMiddleware;
use App\Middleware\RegisterMiddleware;

// $app->get('/', WebController::class . ':index');
$app->get('/', LoginAdminController::class . ':index')->add(new AdminMiddleware());
$app->get('/login', LoginController::class . ':index')->add(new LoginMiddleware());
$app->post('/login', LoginController::class . ':login');
// $app->get('/register', RegisterController::class . ':index')->add(new LoginMiddleware());
// $app->post('/register', RegisterController::class . ':save');
// $app->get('/verify-email/{url}', verifyController::class . ':index');
// $app->post('/email/verification-notification', verifyController::class . ':notification');
// $app->get('/forgot-password', ForgotPasswordController::class . ':index');
// $app->post('/forgot-password', ForgotPasswordController::class . ':forgot');
// $app->get('/reset-password/{token}', ForgotPasswordController::class . ':reset');
// $app->post('/reset-password', ForgotPasswordController::class . ':updatePassword');

// $app->get('/logout', LogoutController::class . ':web');

// $app->get('/dni[/{dni}]', HomeController::class . ':dni');

// // $app->get('/email', RegisterController::class . ':sendEmail');

// $app->group('/me', function (RouteCollectorProxy $group) {
//     $group->get("", AccountController::class . ':index');
//     $group->post("", AccountController::class . ':updateAccount');
//     $group->get('/forgot-password', AccountController::class . ':formForgotPassword');
//     $group->post('/forgot-password', AccountController::class . ':changePassword');
//     $group->get('/vacunas', AccountController::class . ':listarVacunas');
//     $group->get('/desparasitaciones', AccountController::class . ':listarDesparasitaciones');
    
//     $group->group('/mascotas', function (RouteCollectorProxy $group) {
//         $group->post('/list', AccountController::class . ':listMascota');
//         $group->post('/save', AccountController::class . ':storeMascota');
//         $group->post('/search', AccountController::class . ':searchMascota');
//         $group->post('/delete', AccountController::class . ':deleteMascota');

//         $group->get('/especies', MascotasController::class . ':listarEspecies');
//         $group->get('/razas', MascotasController::class . ':listarRazas');
//         $group->get('/generos', MascotasController::class . ':listarGeneros');
//     });
//     $group->group('/citas', function (RouteCollectorProxy $group) {
//         $group->post('/list', AccountController::class . ':listCitas');
//         $group->post('/save', AccountController::class . ':storeCitas');
//         $group->post('/cancelar', AccountController::class . ':cancelarReservaCita');
//     });
// })->add(new RegisterMiddleware());
