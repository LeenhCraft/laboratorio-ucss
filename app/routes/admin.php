<?php

// use Slim\App;
use Slim\Routing\RouteCollectorProxy;

// Controllers
use App\Controllers\Admin\CentinelaController;
use App\Controllers\Admin\ConsultasController;
use App\Controllers\Admin\DashboardController;
use App\Controllers\Admin\DataBaseController;
use App\Controllers\Admin\DesparasitacionesController;
use App\Controllers\Admin\EstadoconsultaController;
use App\Controllers\Admin\HistoriaclinicaController;
use App\Controllers\Admin\LoginAdminController;
use App\Controllers\Admin\MascotasController;
use App\Controllers\Admin\MenusController;
use App\Controllers\Admin\PermisosController;
use App\Controllers\Admin\PersonasController;
use App\Controllers\Admin\PropietariosController;
use App\Controllers\Admin\RazasController;
use App\Controllers\Admin\ReportesController;
use App\Controllers\Admin\ReservarcitasController;
use App\Controllers\Admin\RolesController;
use App\Controllers\Admin\ServiciosController;
use App\Controllers\Admin\SubmenusController;
use App\Controllers\Admin\UsuariosController;
use App\Controllers\Admin\VacunacionesController;
use App\Controllers\Admin\VentasController;
use App\Controllers\Crud\CrudController;
use App\Controllers\LogoutController;
use App\Middleware\AdminMiddleware;

// Middlewares
use App\Middleware\LoginAdminMiddleware;
use App\Middleware\PermissionMiddleware;
use App\Middleware\RemoveCsrfMiddleware;
use Dotenv\Repository\RepositoryBuilder;

$app->get('/admin/login', LoginAdminController::class . ':index')->add(new AdminMiddleware)->add(new RemoveCsrfMiddleware());
$app->post('/admin/login', LoginAdminController::class . ':sessionUser');

$app->group('/admin', function (RouteCollectorProxy $group) {
    $group->get("", DashboardController::class . ':index')->add(new RemoveCsrfMiddleware());
    $group->get("/logout", LogoutController::class . ':admin')->add(new RemoveCsrfMiddleware());

    $group->group('/menus', function (RouteCollectorProxy $group) {
        $group->get('', MenusController::class . ':index')->add(new RemoveCsrfMiddleware());
        $group->post('', MenusController::class . ':list');
        $group->post('/save', MenusController::class . ':store');
        $group->post('/update', MenusController::class . ':update');
        $group->post('/search', MenusController::class . ':search');
        $group->post('/delete', MenusController::class . ':delete');
    });

    $group->group('/submenus', function (RouteCollectorProxy $group) {
        $group->get('', SubmenusController::class . ':index')->add(new RemoveCsrfMiddleware());
        $group->post('', SubmenusController::class . ':list');
        $group->post('/save', SubmenusController::class . ':store');
        $group->post('/update', SubmenusController::class . ':update');
        $group->post('/menus', SubmenusController::class . ':menus');
        $group->post('/search', SubmenusController::class . ':search');
        $group->post('/delete', SubmenusController::class . ':delete');
    });

    $group->group('/personas', function (RouteCollectorProxy $group) {
        $group->get('', PersonasController::class . ':index')->add(new RemoveCsrfMiddleware());

        $group->post('', PersonasController::class . ':list');
        $group->post('/save', PersonasController::class . ':store');
        $group->post('/search', PersonasController::class . ':search');
        $group->post('/update', PersonasController::class . ':update');
        $group->post('/delete', PersonasController::class . ':delete');
    })->add(PermissionMiddleware::class);

    $group->group('/usuarios', function (RouteCollectorProxy $group) {
        $group->get('', UsuariosController::class . ':index')->add(new RemoveCsrfMiddleware());
        $group->post('/roles', UsuariosController::class . ':roles');
        $group->post('/person', UsuariosController::class . ':person');

        $group->post('', UsuariosController::class . ':list');
        $group->post('/save', UsuariosController::class . ':store');
        $group->post('/search', UsuariosController::class . ':search');
        $group->post('/update', UsuariosController::class . ':update');
        $group->post('/delete', UsuariosController::class . ':delete');
    })->add(PermissionMiddleware::class);

    $group->group('/roles', function (RouteCollectorProxy $group) {
        $group->get('', RolesController::class . ':index')->add(new RemoveCsrfMiddleware());

        $group->post('', RolesController::class . ':list');
        $group->post('/save', RolesController::class . ':store');
        $group->post('/search', RolesController::class . ':search');
        $group->post('/update', RolesController::class . ':update');
        $group->post('/delete', RolesController::class . ':delete');
    })->add(PermissionMiddleware::class);

    $group->group('/permisos', function (RouteCollectorProxy $group) {
        $group->get('', PermisosController::class . ':index')->add(new RemoveCsrfMiddleware());
        $group->post('', PermisosController::class . ':list');
        $group->post('/save', PermisosController::class . ':store');
        $group->post('/delete', PermisosController::class . ':delete');
        $group->post('/active', PermisosController::class . ':active');
        $group->post('/roles', PermisosController::class . ':roles');
        $group->post('/menus', PermisosController::class . ':menus');
        $group->post('/submenus', PermisosController::class . ':submenus');
    });

    $group->group('/database', function (RouteCollectorProxy $group) {
        $group->get('', DataBaseController::class . ':index')->add(new RemoveCsrfMiddleware());
        $group->post('', DataBaseController::class . ':list');
        $group->post('/save', DataBaseController::class . ':store');
        $group->post('/update', DataBaseController::class . ':update');
        $group->post('/search', DataBaseController::class . ':search');
        $group->post('/delete', DataBaseController::class . ':delete');
        $group->post('/execute', DataBaseController::class . ':execute');
    })->add(PermissionMiddleware::class);

    $group->group("/centinela", function (RouteCollectorProxy $group) {
        $group->get("", CentinelaController::class . ":index")->add(new RemoveCsrfMiddleware());

        $group->post("", CentinelaController::class . ":list");
        $group->post("/save", CentinelaController::class . ":store");
        $group->post("/search", CentinelaController::class . ":search");
        $group->post("/update", CentinelaController::class . ":update");
        $group->post("/delete", CentinelaController::class . ":delete");
    })->add(PermissionMiddleware::class);

    $group->group("/crud", function (RouteCollectorProxy $group) {
        $group->get("", CrudController::class . ":index")->add(new RemoveCsrfMiddleware());

        $group->post("", CrudController::class . ":list");
        $group->post("/save", CrudController::class . ":store");
        $group->post("/search", CrudController::class . ":search");
        $group->post("/update", CrudController::class . ":update");
        $group->post("/delete", CrudController::class . ":delete");
        $group->post("/libros", CrudController::class . ":libros");
    })->add(PermissionMiddleware::class);
})->add(new LoginAdminMiddleware());
