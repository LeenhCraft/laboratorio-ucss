<?php

namespace App\Controllers;

class LogoutController extends Controller
{
    public function index($request, $response, $args)
    {
        session_unset();
        session_destroy();
        return $response
            ->withHeader('Location', base_url())
            ->withStatus(302);
    }

    public function admin($request, $response, $args)
    {
        // session_unset();
        // session_destroy();

        unset($_SESSION['app_id']);
        unset($_SESSION['app_r']);
        unset($_SESSION['app_session']);
        return $response
            ->withHeader('Location', base_url() . 'admin/login')
            ->withStatus(302);
    }

    public function web($request, $response, $args)
    {
        // eliminar lnh y pe de session
        unset($_SESSION['lnh']);
        unset($_SESSION['pe']);
        return $response
            ->withHeader('Location', base_url())
            ->withStatus(302);
    }
}
