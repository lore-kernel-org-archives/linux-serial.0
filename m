From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
Date: Tue, 5 Jun 2018 16:42:18 +0300
Message-ID: <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-19-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-19-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> serdev driver can only be used by serdev controllers that are compatible
> with ttyport.

> +config SERIAL_DEV_CTRL_TTYDEV
> +       tristate "TTY port dynamically loaded by the Serial Device Bus"
> +       help
> +         Say Y here if you want to create a bridge driver between the Serial
> +         device bus and the TTY chardevice. This driver can be dynamically
> +         loaded/unloaded by the Serial Device Bus.
> +
> +         If unsure, say Y.
> +       depends on SERIAL_DEV_CTRL_TTYPORT

> +       default m

Hmm... Can't we survive w/o this by default?

> +static int __init ttydev_serdev_init(void)
> +{
> +       return serdev_device_driver_register(&ttydev_serdev_driver);
> +}
> +module_init(ttydev_serdev_init);
> +
> +static void __exit ttydev_serdev_exit(void)
> +{
> +       return serdev_device_driver_unregister(&ttydev_serdev_driver);
> +}
> +module_exit(ttydev_serdev_exit);

Isn't above is just a macro in serdev.h?
I.e. module_serdev_device_driver().

-- 
With Best Regards,
Andy Shevchenko
