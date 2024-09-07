<?php

/**
 * Esta función verifica los permisos recursivos y la existencia recursiva de carpetas principales
 * antes de crear un archivo/folder. Para evitar la generación de errores/advertencias.
 *
 * @param string $rutaArchivo
 *   La ruta completa del archivo.
 * @param string $texto
 *   El texto que se va a escribir en el archivo.
 * @return bool
 *   true si se ha creado o el archivo existe y es escribible.
 *   false si el archivo no existe y no se puede crear.
 */
function createWritableFolder($folder)
{
    if (file_exists($folder)) {
        // La carpeta existe.
        return is_writable($folder);
    }

    $folderParent = dirname($folder);
    if ($folderParent != '.' && $folderParent != '/') {
        if (!createWritableFolder(dirname($folder))) {
            return false;
        }
    }

    if (is_writable($folderParent)) {
        if (mkdir($folder, 0777, true)) {
            return true;
        }
    }
    return false;
}

/**
 * Esta función verifica los permisos recursivos y la existencia recursiva de carpetas principales
 * antes de crear un archivo/folder. Para evitar la generación de errores/advertencias.
 *
 * @param string $file
 *   La ruta completa del archivo.
 * @return bool
 *   true si se ha creado o el archivo existe y es escribible.
 *   false si el archivo no existe y no se puede crear.
 */
function createWritableFile($file)
{
    if (file_exists($file)) {
        return is_writable($file);
    }

    if (createWritableFolder(dirname($file)) && ($handle = fopen($file, 'a+'))) {
        fclose($handle);
        return true;
    }
    return false;
}

/**
 * Esta función verifica los permisos recursivos y la existencia recursiva de carpetas principales
 * antes de crear un archivo/folder. Para evitar la generación de errores/advertencias.
 *
 * @param string $rutaArchivo
 *   La ruta completa del archivo.
 * @param string $texto
 *   El texto que se va a escribir en el archivo.
 * @return bool
 *   true si se ha creado o el archivo existe y es escribible.
 *   false si el archivo no existe y no se puede crear.
 */
function escribirEnArchivo($rutaArchivo, string $texto, $sobrescribir = 0)
{
    if (createWritableFile($rutaArchivo)) {
        // Determinar el modo de apertura del archivo
        $modoApertura = ($sobrescribir == 1) ? 'w' : 'a+';
        $manejador = fopen($rutaArchivo, $modoApertura);
        if ($manejador) {
            if (fwrite($manejador, $texto) !== false) {
                fclose($manejador);
                return true;
            }
            fclose($manejador);
        }
    }
    return false;
}
