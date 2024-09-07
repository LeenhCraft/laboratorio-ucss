<script src="/js/app/plugins/jquery.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.min.js"></script>
<script src="/js/app/plugins/sweetalert2.all.min.js"></script>
<script src="/js/app/plugins/select2.min.js"></script>
<script>
    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        showCloseButton: true,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener("mouseenter", Swal.stopTimer);
            toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
    });
    var divLoading = $("#divLoading");
    const base_url = "<?php echo base_url(); ?>";
    document.getElementById('toggle-nav').addEventListener('click', function() {
        var nav = document.getElementById('ftco-nav');
        var ul = document.getElementById('menu-items');
        if (ul.classList.contains('max-h-0')) {
            ul.classList.remove('max-h-0', 'opacity-0');
            ul.classList.add('max-h-screen', 'opacity-100');
        } else {
            ul.classList.remove('max-h-screen', 'opacity-100');
            ul.classList.add('max-h-0', 'opacity-0');
        }
    });

    function addCeros(int, cantidadCeros = 4) {
        const intString = int.toString(); // Convertir el número a cadena
        const length = intString.length; // Obtener la longitud de la cadena

        if (length < cantidadCeros) {
            // Agregar ceros a la izquierda si la longitud es menor que la cantidad especificada
            const ceros = '0'.repeat(cantidadCeros - length);
            return ceros + intString;
        } else {
            // Devolver el número como cadena si la longitud es mayor o igual
            return intString;
        }
    }

    function limitChars(event) {
        var $input = $(event.target);
        var charLimit = $input.data("char-limit");
        if (charLimit && $input.val().length > charLimit) {
            $input.val($input.val().substring(0, charLimit));
        }
    }
</script>
<?php
if (isset($data['js']) && !empty($data['js'])) {
    for ($i = 0; $i < count($data['js']); $i++) {
        echo '<script src="' . base_url() . $data['js'][$i] . '"></script>';
    }
}
?>
</body>

</html>