From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/5] gpio: add support for Technologic Systems TS-5500 GPIOs
Date: Wed, 4 May 2011 18:29:12 +0200
Message-ID: <201105041829.12801.arnd@arndb.de>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50953 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1EDQ3R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 May 2011 12:29:17 -0400
In-Reply-To: <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

On Saturday 30 April 2011, Vivien Didelot wrote:
> +       ts5xxx_sbcinfo_set(&sbcinfo);
> +       if (5500 != sbcinfo.board_id) {
> +               printk(MODULE_NAME ": Incompatible TS Board.\n");
> +               return -ENODEV;
> +       }

The above should not be necessary:

> +static int __init ts5500_gpio_init(void)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(&ts5500_gpio_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret = platform_device_register(&gpio_device);
> +       if (ret) {
> +               printk(MODULE_NAME ": Failed to register platform device\n");
> +               platform_driver_unregister(&ts5500_gpio_driver);
> +               return ret;
> +       }
> +
> +       printk(MODULE_NAME ": GPIO/DIO driver loaded.\n");
> +       return 0;
> +}
> +module_init(ts5500_gpio_init);

Doing it this way requires you know that you have to load the driver,
which is not good if you want to have the same kernel running on 
different machines.

Better move the device registration into your platform code, in the
place where you know what device you have. The add a MODULE_DEVICE_TABLE()
entry to the module so the driver gets automatically loaded (if it's
a module), and match the platform device to the driver you register
from the module_init function.

Same for the other devices where you follow the same pattern.

Another way to do the same in a more modern fashion would be
to provide a flattened device tree that describes all your devices
and pass that into the kernel. Take a look at the CE4100 and OLPC
platforms to see how that is done.

	Arnd
