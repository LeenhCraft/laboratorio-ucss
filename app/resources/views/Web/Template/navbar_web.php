<nav class="bg-white py-4 px-8 md:py-6">
    <div class="flex flex-wrap gap-y-4 justify-between md:max-w-custom-nav md:mx-auto">
        <a href="/">
            <img src="/img/logo.png" alt="logo" class="w-20">
        </a>
        <button id="toggle-nav" type="button" class="text-lg font-bold flex items-center justify-center gap-2 uppercase lg:hidden">
            <i class='bx bx-menu bx-md'></i>
            <span>Menú</span>
        </button>

        <div id="ftco-nav" class="flex items-center w-full overflow-hidden md:w-auto">
            <ul id="menu-items" class="uppercase transition-all duration-500 ease-in-out max-h-0 opacity-0 w-full md:flex md:ml-auto md:max-h-full md:opacity-100">
                <li>
                    <a href="/" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">inicio</a>
                </li>
                <li>
                    <a href="#" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">nosotros</a>
                </li>
                <li>
                    <a href="#" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">servicios</a>
                </li>
                <li>
                    <a href="#" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">galería</a>
                </li>
                <li>
                    <a href="/admin" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">Dashboard</a>
                </li>
                <?php
                if (isset($_SESSION['lnh'])) {
                ?>
                    <li>
                        <a href="/me" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">Mi cuenta</a>
                    </li>
                    <li>
                        <a href="/logout" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">Cerrar sesión</a>
                    </li>
                <?php
                } else {
                ?>
                    <li>
                        <a href="/login" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300"> inicia sesión</a>
                    </li>
                    <li>
                        <a href="/register" class="block text-base font-bold py-4 border-b border-gray-200 md:px-4 md:py-8 md:border-b-0 md:hover:text-green-500 md:transition-all md:duration-300 ">registrarse</a>
                    </li>
                <?php
                }
                ?>
            </ul>
        </div>

    </div>
</nav>