<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            position: relative;
        }

        .logo {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 60px;
        }

        .header {
            text-align: center;
            font-weight: bold;
            margin: 20px 0;
            font-size: 16px;
        }

        .form-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .form-grid td {
            border: 1px solid #000;
            padding: 8px;
        }

        .label {
            width: 25%;
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .equipment-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .equipment-table th,
        .equipment-table td {
            border: 1px solid #000;
            padding: 8px;
            text-align: left;
        }

        .signature {
            text-align: center;
            margin-top: 50px;
        }

        .signature-line {
            width: 200px;
            border-top: 1px solid #000;
            margin: 0 auto;
            margin-bottom: 5px;
        }
    </style>
</head>

<body>
    <img src="logo.png" alt="UCSS Logo" class="logo">
    <div class="header">CONTROL DEL INGRESO AL TALLER- DOCENTE</div>

    <table class="form-grid">
        <tr>
            <td class="label">TÍTULO DE PRÁCTICA</td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class="label">N° PRÁCTICAS</td>
            <td></td>
            <td class="label">PROGRAMA DE ESTUDIO</td>
            <td></td>
        </tr>
        <tr>
            <td class="label">DOCENTE</td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class="label">ASIGNATURA</td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class="label">TURNO</td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class="label">HORA INICIO</td>
            <td></td>
            <td class="label">HORA TÉRMINO</td>
            <td></td>
        </tr>
    </table>

    <table class="equipment-table">
        <tr>
            <th width="10%">Cant.</th>
            <th width="40%">Equipo/Materiales</th>
            <th width="10%">Cant.</th>
            <th width="40%">Equipo/Materiales</th>
        </tr>
        <tr>
            <td height="30"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td height="30"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td height="30"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td height="30"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td height="30"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </table>

    <div class="signature">
        <div class="signature-line"></div>
        FIRMA DEL DOCENTE
    </div>
</body>

</html>