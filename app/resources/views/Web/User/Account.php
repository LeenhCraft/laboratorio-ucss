<?php headerWeb('Web.Template.header_web', $data); ?>
<main class="profile-page">
    <section class="relative block" style="height:500px">
        <div class="absolute top-0 w-full h-full bg-center bg-cover" style="background-image:url('https://images.unsplash.com/photo-1499336315816-097655dcfbda?ixlib=rb-1.2.1&amp;ixid=eyJhcHBfaWQiOjEyMDd9&amp;auto=format&amp;fit=crop&amp;w=2710&amp;q=80')"><span id="blackOverlay" class="w-full h-full absolute opacity-50 bg-black"></span></div>
        <div class="top-auto bottom-0 left-0 right-0 w-full absolute pointer-events-none overflow-hidden" style="height:70px"><svg class="absolute bottom-0 overflow-hidden" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" version="1.1" viewBox="0 0 2560 100" x="0" y="0">
                <polygon class="text-blueGray-200 fill-current" points="2560 0 2560 100 0 100"></polygon>
            </svg></div>
    </section>
    <section class="relative py-16 bg-blue-200">
        <div class="container mx-auto px-4">
            <div class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-xl rounded-lg -mt-64">
                <div class="px-6">
                    <div class="flex flex-wrap justify-center">
                        <div class="w-full lg:w-3/12 px-4 lg:order-2 flex justify-center">
                            <div class="relative"><img alt="..." src="https://www.creative-tim.com/learning-lab/tailwind-starter-kit/img/team-2-800x800.jpg" class="shadow-xl rounded-full h-auto align-middle border-none absolute -m-16 -ml-20 lg:-ml-16" style="max-width:150px"></div>
                        </div>
                        <div class="w-full lg:w-4/12 px-4 lg:order-3 lg:text-right lg:self-center">
                            <div class="py-6 px-3 mt-32 sm:mt-0">
                                <button id="btnSalir" class="bg-pink-500 active:bg-pink-600 uppercase text-white font-bold shadow-md text-xs px-4 py-2 rounded outline-none focus:outline-none sm:mr-2 mb-1 ease-linear transition-all duration-150 hover:shadow-lg hover:-translate-y-0.5 hover:-translate-x-0.5 transform hover:scale-105" type="button">salir</button>
                            </div>
                        </div>
                        <div class="w-full lg:w-4/12 px-4 lg:order-1">
                            <div class="flex justify-center py-4 lg:pt-4 pt-8">
                                <div class="mr-4 p-3 text-center">
                                    <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">22</span>
                                    <span class="text-sm text-blueGray-400">Consultas</span>
                                </div>
                                <div class="mr-4 p-3 text-center">
                                    <span class="text-xl font-bold block uppercase tracking-wide text-blueGray-600">10</span>
                                    <span class="text-sm text-blueGray-400">Mascotas</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-12">
                        <h3 class="text-4xl font-semibold leading-normal mb-2 text-pink-500 capitalize">
                            <?php
                            if (isset($data["propietario"]["nombres"]))
                                echo $data["propietario"]["nombres"] . ' ' . $data["propietario"]["apellidos"];
                            ?>
                        </h3>
                        <div class="text-sm leading-normal mt-0 mb-2 text-blueGray-400 font-bold uppercase">
                            <span>
                                <?php
                                echo $data["user"]["usu_cuenta"];
                                ?>
                            </span>
                        </div>
                    </div>
                    <div class="mt-10 py-10 border-t border-pink-300 text-center">
                        <!-- tabs -->
                        <div class="items-stretch flex mb-4 text-start">
                            <ul class="flex flex-col flex-wrap list-none border-0 border-gray-200" role="tablist">
                                <li class="" role="presentation">
                                    <button type="button" class="transition-all duration-250 ease-in-out bg-pink-500 text-white w-full rounded-tl-md inline-block p-4 font-bold text-xs leading-tight uppercase" role="tab" data-bs-toggle="tab" data-bs-target="#navs-left-mascotas" aria-controls="navs-left-mascotas" aria-selected="true">
                                        Mascotas
                                    </button>
                                </li>
                                <li class="" role="presentation">
                                    <button type="button" class="transition-all duration-250 ease-in-out bg-gray-200 w-full inline-block p-4 text-gray-500 font-medium text-xs leading-tight uppercase" role="tab" data-bs-toggle="tab" data-bs-target="#navs-left-profile" aria-controls="navs-left-profile" aria-selected="false" tabindex="-1">
                                        Agendar cita
                                    </button>
                                </li>
                                <li class="" role="presentation">
                                    <button type="button" class="transition-all duration-250 ease-in-out bg-gray-200 w-full inline-block p-4 text-gray-500 font-medium text-xs leading-tight uppercase" role="tab" data-bs-toggle="tab" data-bs-target="#navs-left-historial" aria-controls="navs-left-historial" aria-selected="false" tabindex="-1">
                                        Hisrotial de citas
                                    </button>
                                </li>
                                <li class="" role="presentation">
                                    <button type="button" class="transition-all duration-250 ease-in-out bg-gray-200 w-full inline-block p-4 text-gray-500 font-medium text-xs leading-tight uppercase rounded-bl-md" role="tab" data-bs-toggle="tab" data-bs-target="#navs-left-vacunas" aria-controls="navs-left-vacunas" aria-selected="false" tabindex="-1">
                                        Vacunas
                                    </button>
                                </li>
                                <li class="" role="presentation">
                                    <button type="button" class="transition-all duration-250 ease-in-out bg-gray-200 w-full inline-block p-4 text-gray-500 font-medium text-xs leading-tight uppercase rounded-bl-md" role="tab" data-bs-toggle="tab" data-bs-target="#navs-left-desparacitacion" aria-controls="navs-left-desparacitacion" aria-selected="false" tabindex="-1">
                                        Desparacitacion
                                    </button>
                                </li>
                            </ul>
                            <div class="flex flex-wrap bg-white rounded-r-md px-6 w-full">
                                <div class="w-full" id="navs-left-mascotas" role="tabpanel">
                                    <form class="form border-b-2 border-pink-300 w-full">
                                        <div class="flex">
                                            <button id="openModalBtn" class="text-xs uppercase font-bold px-4 py-2 rounded outline-none focus:outline-none mb-4 ease-linear text-pink-500 border-2 border-pink-500 transition-all duration-150 shadow-md hover:bg-pink-500 hover:text-white hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu" type="button">
                                                <span class="mb-3">Agregar nueva mascota</span>
                                                <i class="fa fa-solid fa-paw text-xl"></i>
                                            </button>
                                        </div>
                                    </form>
                                    <div class="overflow-x-auto">
                                        <table id="tbl" class="w-full text-sm text-left text-gray-500">
                                            <thead class="text-xs text-gray-700 uppercase bg-white">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3">
                                                        Nombre
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Tipo
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Edad
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Acciones
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white">
                                                <tr class="border-b">
                                                    <td class="px-6 py-4 font-medium text-gray-900">
                                                        <div class="flex items-center whitespace-nowrap">
                                                            <img src="https://via.placeholder.com/50" alt="Imagen de Firulais" class="w-8 h-8 rounded-full mr-2">
                                                            Firulais
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <i class="fa fa-solid fa-dog text-pink-500 mr-2"></i>
                                                        Perro
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        5 años
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <button class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr class="border-b">
                                                    <td class="px-6 py-4 font-medium text-gray-900">
                                                        <div class="whitespace-nowrap flex items-center">
                                                            <img src="https://via.placeholder.com/50" alt="Imagen de Michi" class="w-8 h-8 rounded-full mr-2">
                                                            Michi
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <div class="flex items-center">
                                                            <i class="fa fa-solid fa-cat text-pink-500 mr-2"></i>
                                                            Gato
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        2 años
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <button class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="w-full hidden" id="navs-left-profile" role="tabpanel">
                                    <form id="agendarCita" class="max-w-md mx-auto">
                                        <div class="relative z-0 w-full mb-5 group">
                                            <label for="idmascota" class="block mb-2 text-sm font-medium text-gray-400">Seleccione su Mascota</label>
                                            <select id="idmascota" name="idmascota" class="bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                                            </select>
                                        </div>
                                        <div class="relative z-0 w-full max-w-lg mb-5 group">
                                            <textarea id="motivo" name="motivo" class="textarea-start block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-600 appearance-none focus:outline-none focus:ring-0 focus:text-pink-500 peer resize-none transition-all duration-300 max-h-48 overflow-x-hidden" placeholder=" "></textarea>
                                            <label for="motivo" class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto peer-focus:text-pink-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Motivo de la Consulta</label>
                                        </div>
                                        <div class="grid md:grid-cols-2 md:gap-6">
                                            <div class="relative z-0 w-full mb-5 group">
                                                <input type="date" name="fecha_consulta" id="fecha_consulta" class="textarea-start block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-600 appearance-none focus:outline-none focus:ring-0 focus:text-pink-500 peer resize-none transition-all duration-300" placeholder=" " value="<?php echo date("Y-m-d") ?>">
                                                <label for="fecha_consulta" class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto peer-focus:text-pink-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Fecha Consulta</label>
                                            </div>
                                            <div class="relative z-0 w-full mb-5 group">
                                                <input type="time" name="hora_consulta" id="hora_consulta" class="textarea-start block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-600 appearance-none focus:outline-none focus:ring-0 focus:text-pink-500 peer resize-none transition-all duration-300" placeholder=" " value="<?php echo date('h:i:s'); ?>">
                                                <label for="hora_consulta" class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 rtl:peer-focus:left-auto peer-focus:text-pink-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Hora Consulta</label>
                                            </div>
                                        </div>
                                        <button class="text-xs uppercase font-bold px-4 py-2 rounded outline-none focus:outline-none mb-4 ease-linear text-pink-500 border-2 border-pink-500 transition-all duration-150 shadow-md hover:bg-pink-500 hover:text-white hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu" type="submit">
                                            <span class="mb-3">Agendar Cita</span>
                                            <i class="fa fa-solid fa-paw text-xl" aria-hidden="true"></i>
                                        </button>
                                    </form>
                                </div>
                                <div class="w-full hidden" id="navs-left-historial" role="tabpanel">
                                    <div class="overflow-x-auto">
                                        <table id="tablaHistorialCitas" class="w-full text-sm text-left text-gray-500">
                                            <thead class="text-xs text-gray-700 uppercase bg-white">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3">
                                                        Fecha
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Mascota
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Motivo
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Estado
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Acciones
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white">
                                                <tr class="border-b">
                                                    <td class="px-6 py-4 font-medium text-gray-900">
                                                        24/06/2024
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        Mattwes
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        Desparacitacion
                                                    </td>
                                                    <td class="px-6 py-4">
                                                        <button class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
                                                            Editar
                                                        </button>
                                                        <button class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm p-2 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
                                                            Cancelar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="w-full hidden" id="navs-left-vacunas" role="tabpanel">
                                    <div class="overflow-x-auto">
                                        <table id="tablaVacunas" class="w-full text-sm text-left text-gray-500">
                                            <thead class="text-xs text-gray-700 uppercase bg-white">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3">
                                                        Fecha vacuna
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        proxima vacuna
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Mascota
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Vacuna
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="w-full hidden" id="navs-left-desparacitacion" role="tabpanel">
                                    <div class="overflow-x-auto">
                                        <table id="tablaDesparacitaciones" class="w-full text-sm text-left text-gray-500">
                                            <thead class="text-xs text-gray-700 uppercase bg-white">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3">
                                                        Fecha vacuna
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        proxima vacuna
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Mascota
                                                    </th>
                                                    <th scope="col" class="px-6 py-3">
                                                        Vacuna
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<style>
    /* Elimina posibles estilos predeterminados */
    input:focus {
        outline: none;
        /* Elimina el outline predeterminado */
    }
</style>
<!-- Modal -->
<div id="modal" class="fixed inset-0 z-50 hidden overflow-y-auto overflow-x-hidden backdrop-blur-sm bg-gray-900/75 p-4 md:p-8 transition-opacity duration-300 opacity-0">
    <div id="modal-content" class="relative max-w-xl mx-auto transition-transform transform scale-0 opacity-0 duration-300">
        <!-- Modal content -->
        <form id="newMascota">
            <div class="bg-white rounded-lg shadow-lg">
                <!-- Modal header -->
                <div class="flex items-center justify-between px-6 py-4 border-b">
                    <h3 class="text-lg font-medium text-gray-800">Agregar Mascota</h3>
                    <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center" data-modal-toggle="modal">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                </div>

                <!-- Modal body -->
                <div class="px-6 py-4">
                    <div class="grid grid-cols-1 gap-6">
                        <input type="hidden" name="idmascota" id="idmascota">
                        <div>
                            <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900">Nombre</label>
                            <input type="text" id="nombre" name="nombre" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5" placeholder="Ej. Firulais" required>
                        </div>
                        <div>
                            <label for="idespecie" class="block mb-2 text-sm font-medium text-gray-900">Especie</label>
                            <select name="idespecie" id="idespecie" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5"></select>
                        </div>
                        <div>
                            <label for="idgenero" class="block mb-2 text-sm font-medium text-gray-900">Género</label>
                            <select id="idgenero" name="idgenero" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5">
                            </select>
                        </div>
                        <div>
                            <label for="idraza" class="block mb-2 text-sm font-medium text-gray-900">Raza</label>
                            <select name="idraza" id="idraza" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5"></select>
                        </div>
                        <div>
                            <label for="color" class="block mb-2 text-sm font-medium text-gray-900">Color</label>
                            <input type="text" id="color" name="color" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5" placeholder="Ej. Dorado">
                        </div>
                        <div>
                            <label for="fecha_nacimiento" class="block mb-2 text-sm font-medium text-gray-900">Fecha de Nacimiento</label>
                            <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" class="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-pink-500 focus:border-pink-500 block w-full p-2.5">
                        </div>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="px-6 py-4 border-t flex justify-end">
                    <button type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 mr-2" data-modal-toggle="modal">Cancelar</button>
                    <button type="submit" class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">Agregar Mascota</button>
                </div>
            </div>
        </form>
    </div>
</div>

<?php footerWeb('Web.Template.footer_web', $data); ?>