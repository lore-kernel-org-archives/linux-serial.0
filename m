From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Sat, 07 Jan 2017 13:00:50 +0200
Message-ID: <1483786850.9552.249.camel@linux.intel.com>
References: <20170106162635.19677-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
> 
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He
> didn't
> think using serio was a good fit, and serio has a number of
> peculiarities
> in regards to sysfs and it's driver model. I don't think we want to
> inherit
> those for serial slave devices.
> 
> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the
> tty
> core code.
> 
> I have hacked up versions of the BT ldisc and TI ST drivers moved over
> to
> use the serdev bus. I have BT working on the HiKey board which has TI
> BT.
> With the serdev bus support, it eliminates the need for the TI
> userspace
> UIM daemon.
> 
> This series and the mentioned drivers can be found here[1].

For patches 1-4:
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Regarding to naming. Why can't we just name bus "serial"? If you are
worrying about folder name under drivers/tty, I can propose at lease
couple of options serialdev, serialbus.

> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> serial-bus-v2
> 
> Alan Cox (1):
>   tty_port: allow a port to be opened with a tty that has no file
> handle
> 
> Rob Herring (8):
>   tty: move the non-file related parts of tty_release to new
>     tty_release_struct
>   tty_port: make tty_port_register_device wrap
>     tty_port_register_device_attr
>   tty: constify tty_ldisc_receive_buf buffer pointer
>   tty_port: Add port client functions
>   dt/bindings: Add a serial/UART attached device binding
>   serdev: Introduce new bus for serial attached devices
>   serdev: add a tty port controller driver
>   tty_port: register tty ports with serdev bus
> 
>  .../devicetree/bindings/serial/slave-device.txt    |  34 ++
>  MAINTAINERS                                        |   8 +
>  drivers/char/Kconfig                               |   1 +
>  drivers/tty/Makefile                               |   1 +
>  drivers/tty/serdev/Kconfig                         |  16 +
>  drivers/tty/serdev/Makefile                        |   5 +
>  drivers/tty/serdev/core.c                          | 388
> +++++++++++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c                | 244
> +++++++++++++
>  drivers/tty/tty_buffer.c                           |  19 +-
>  drivers/tty/tty_io.c                               |  44 ++-
>  drivers/tty/tty_port.c                             |  60 +++-
>  include/linux/serdev.h                             | 227 ++++++++++++
>  include/linux/tty.h                                |  12 +-
>  13 files changed, 1017 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/slave-
> device.txt
>  create mode 100644 drivers/tty/serdev/Kconfig
>  create mode 100644 drivers/tty/serdev/Makefile
>  create mode 100644 drivers/tty/serdev/core.c
>  create mode 100644 drivers/tty/serdev/serdev-ttyport.c
>  create mode 100644 include/linux/serdev.h

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
