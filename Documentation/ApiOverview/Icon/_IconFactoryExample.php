<?php

declare(strict_types=1);

namespace MyVendor\MyExtension;

use TYPO3\CMS\Core\Imaging\Icon;
use TYPO3\CMS\Core\Imaging\IconFactory;

final class MyClass
{
    private IconFactory $iconFactory;

    public function __construct(IconFactory $iconFactory)
    {
        $this->iconFactory = $iconFactory;
    }

    public function doSomething()
    {
        $icon = $this->iconFactory->getIcon(
            'tx-myext-action-preview',
            Icon::SIZE_SMALL,
            'overlay-identifier'
        );

        // Do something with the icon, for example, assign it to the view
        // $this->view->assign('icon', $icon);
    }
}