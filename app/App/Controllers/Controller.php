<?php

namespace App\Controllers;

class Controller
{

    public function __construct()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        codigo_visita();
    }

    public function view($route, $data = [])
    {
        // extract($data); //extrae los datos del array y los convierte en variables
        $route = str_replace(".", "/", $route);
        if (file_exists("../app/resources/views/{$route}.php")) {
            ob_start();
            include_once "../app/resources/views/{$route}.php";
            $content = ob_get_clean();
            return $content;
        } else {
            return "404 el archivo no existe";
        }
    }

    public function redirect($response, $route)
    {
        return $response
            ->withHeader('Location', $route)
            ->withStatus(302);
    }

    public function render($response, $route, $data = [])
    {

        $payload = $this->view($route, $data);
        $payload = empty($payload) ? "payload vacio, verificar la ruta" : $payload;
        $response->getBody()->write($payload);
        return $response
            ->withHeader('Content-Type', 'text/html')
            ->withStatus(200);
        return $response;
    }

    public function respondWithError($response, $message)
    {
        return $this->respondWithJson($response, ["status" => false, "message" => $message]);
    }

    public function respondWithSuccess($response, $message)
    {
        return $this->respondWithJson($response, ["status" => true, "message" => $message]);
    }

    public function respondWithJson($response, $data)
    {
        $payload = json_encode($data);
        $response->getBody()->write($payload);
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function sanitize($data)
    {
        if (empty($data)) {
            return $data;
        }

        foreach ($data as $key => $value) {
            if (is_array($value)) {
                $data[$key] = $this->sanitize($value);
                continue;
            }

            // Check if the value is a URL (starts with "http://" or "https://") or if it contains URLs within the text.
            if (preg_match('/^(http|https):\/\/\S+$/i', $value) || preg_match('/(http|https):\/\/\S+/i', $value)) {
                $data[$key] = $value; // Keep the original URL(s) without cleaning
            } else {
                // Implement a function (e.g., extractAndCleanURLs) to find and clean URLs within the text.
                $cleanedValue = $this->extractAndCleanURLs($value);
                $data[$key] = $cleanedValue; // Assign the cleaned value to $data[$key]
            }
        }
        return $data;
    }

    private function extractAndCleanURLs($text)
    {
        // Use preg_replace_callback to replace URLs in the text with cleaned versions.
        $cleanedText = preg_replace_callback('/(http|https):\/\/\S+/i', function ($match) {
            // Implement your cleaning logic here, e.g., using strClean.
            return strClean($match[0]);
        }, $text);

        // Clean the rest of the text using strClean.
        $cleanedText = strClean($cleanedText);

        return $cleanedText;
    }

    public function get_method($cadena)
    {
        $methodName = explode('::', $cadena);
        return end($methodName);
    }

    public function className($cadena)
    {
        $cadena = get_class($cadena);
        $class = explode('\\', $cadena);
        return end($class);
    }
}
