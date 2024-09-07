<?php

namespace App\Controllers;

use App\Models\WebModel;

class WebController extends Controller
{
    public function index($request, $response, $args)
    {
        return $this->render($response, "Web.web", [
            "cant" => 10,
            "title" => "Web",
        ]);
    }
}
