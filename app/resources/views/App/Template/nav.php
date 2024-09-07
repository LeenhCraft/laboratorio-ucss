<?php
$ctrl = $data['url'];
$expand = $active = '';
?>
<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo">
        <a href="/admin" class="app-brand-link">
            <span class=" demo menu-text fw-bolder ms-2 app-header__logo"><?php echo $_ENV['APP_NAME']; ?></span>
        </a>
    </div>

    <div class="menu-inner-shadow"></div>

    <ul class="menu-inner py-1">
        <?php
        $menus = menus();
        if (!empty($menus)) :
            foreach ($menus as $row) :
                if ($row['men_url_si'] == 1) :
                    $active = ($row['men_url'] == $ctrl) ? 'active' : '';
                    $menburl = ($row['men_url'] != '#') ? $row['men_url'] : '#';
        ?>
                    <li class="menu-item <?php echo $active; ?>">
                        <a href="<?php echo $menburl; ?>" class="menu-link">
                            <i class="menu-icon tf-icons bx <?php echo $row['men_icono']; ?>"></i>
                            <div data-i18n="Analytics"><?php echo $row['men_nombre']; ?></div>
                        </a>
                    </li>
                <?php
                else :
                    $submenus = submenus($row['idmenu']);
                    $expand = (pertenece($ctrl, $row['idmenu'])) ? 'open' : '';
                ?>
                    <li class="menu-item <?php echo $expand; ?>">
                        <a href="javascript:void(0);" class="menu-link menu-toggle">
                            <i class="menu-icon tf-icons bx <?php echo $row['men_icono']; ?>"></i>
                            <div data-i18n="Layouts" class="text-capitalize"><?php echo $row['men_nombre']; ?></div>
                        </a>

                        <ul class="menu-sub">
                            <?php
                            foreach ($submenus as $key) :
                                $active = ($key['sub_url'] == $ctrl) ? 'active' : '';
                                $suburl = ($key['sub_url'] != '#') ? $key['sub_url'] : '#';
                                $target = ($key['sub_externo'] == 1) ? 'target="_blank"' : '';
                            ?>
                                <li class="menu-item <?php echo $active; ?>">
                                    <a href="<?php echo $suburl; ?>" <?= $target ?> class="menu-link">
                                        <div data-i18n="<?php echo $key['sub_nombre']; ?>" class="d-flex justify-content-between align-items-center">
                                            <i class="menu-icon tf-icons bx <?php echo $key['sub_icono']; ?>"></i>
                                            <span>
                                                <?php echo $key['sub_nombre']; ?>
                                            </span>
                                        </div>
                                    </a>
                                </li>
                            <?php
                            endforeach;
                            ?>
                        </ul>
                    </li>
            <?php
                endif;
            endforeach;
        else :
            ?>
            <li class="menu-item">
                <a href="index.html" class="menu-link">
                    <i class="menu-icon tf-icons bx bx-home-circle"></i>
                    <div data-i18n="Analytics">Sin menus</div>
                </a>
            </li>
        <?php
        endif;
        ?>
    </ul>
</aside>