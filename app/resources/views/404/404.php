<?php headerApp('Template/header_404', $data); ?>
<!-- Error -->
<div class="container-xxl container-p-y">
    <div class="misc-wrapper">
        <h2 class="mb-2 mx-2">Pagina no Encontrada :(</h2>
        <p class="mb-4 mx-2">Oops! 😖 La URL solicitada no se encontró en este servidor.</p>
        <a href="javascript:history.back()" class="btn btn-primary">Back to home</a>
        <div class="mt-3">
            <img src="/img/page-misc-error-dark.png" alt="page-misc-error-light" width="500" class="img-fluid" data-app-dark-img="illustrations/page-misc-error-dark.png" data-app-light-img="illustrations/page-misc-error-light.png">
        </div>
    </div>
</div>
<!-- /Error -->
<?php footerApp('Template/footer_404', $data); ?>