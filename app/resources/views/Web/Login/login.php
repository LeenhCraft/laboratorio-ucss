<?php headerWeb('Web.Template.header_web', $data); ?>
<style>
    .-z-1 {
        z-index: -1;
    }

    .origin-0 {
        transform-origin: 0%;
    }

    input:focus~label,
    input:not(:placeholder-shown)~label,
    textarea:focus~label,
    textarea:not(:placeholder-shown)~label,
    select:focus~label,
    select:not([value='']):valid~label {
        /* @apply transform; scale-75; -translate-y-6; */
        --tw-translate-x: 0;
        --tw-translate-y: 0;
        --tw-rotate: 0;
        --tw-skew-x: 0;
        --tw-skew-y: 0;
        transform: translateX(var(--tw-translate-x)) translateY(var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
        --tw-scale-x: 0.75;
        --tw-scale-y: 0.75;
        --tw-translate-y: -1.5rem;
    }

    input:focus~label,
    select:focus~label {
        /* @apply text-black; left-0; */
        --tw-text-opacity: 1;
        color: rgba(0, 0, 0, var(--tw-text-opacity));
        left: 0px;
    }
</style>
<section class="min-h-screen bg-gray-100 p-4">
    <div class="mx-auto max-w-md px-6 py-12 bg-white border-0 shadow-lg sm:rounded-3xl">
        <h1 class="text-2xl font-bold mb-8">Ingresar a mi cuenta</h1>
        <form id="formLogin">
            <div class="relative z-0 w-full mb-5">
                <input type="text" name="usu_cuenta" placeholder=" " class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200" />
                <label for="usu_cuenta" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Usuario</label>
                <span class="text-sm text-red-600 hidden" id="error">Ingrese su usuario.</span>
            </div>

            <div class="relative z-0 w-full mb-5">
                <input type="password" name="usu_password" placeholder=" " class="pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black border-gray-200" />
                <label for="usu_password" class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500">Contraseña</label>
                <span class="text-sm text-red-600 hidden" id="error">Se necesita una contraseña</span>
            </div>

            <button id="button" type="submit" class="w-full px-6 py-3 mt-3 text-lg text-white transition-all duration-150 ease-linear rounded-lg shadow outline-none bg-secondary-500 hover:bg-secondary-600 hover:shadow-lg focus:outline-none">
                Ingresar
            </button>
        </form>
    </div>
</section>
<?php footerWeb('Web.Template.footer_web', $data); ?>