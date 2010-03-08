From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Sun, 7 Mar 2010 21:30:13 -0700
Message-ID: <fa686aa41003072030xc63dcfemd4a43140a9e05310@mail.gmail.com>
References: <20100304152524.56055828@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52547 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0CHEhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Mar 2010 23:37:34 -0500
Received: by gyh3 with SMTP id 3so671630gyh.19
        for <linux-serial@vger.kernel.org>; Sun, 07 Mar 2010 20:37:33 -0800 (PST)
In-Reply-To: <20100304152524.56055828@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, linux-serial@vger.kernel.org

Hi Feng,

I'm really concerned with this driver.  I think it needs a lot more
work before it is ready for prime-time.  Again, you might want to
consider asking Greg to add it to the staging tree while you clean
stuff up and coordinate with the max3100 driver author.

Comments below.

On Thu, Mar 4, 2010 at 12:25 AM, Feng Tang <feng.tang@intel.com> wrote:
> Hi All,
>
> Here is a driver for Maxim 3110 SPI-UART device, please help to revie=
w.
>
> It has been validated with Designware SPI controller (drivers/spi: dw=
_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read,=
 and
> provides a console.
>
> change log:
> =A0since v5:
> =A0 =A0 =A0 =A0* Make the spi data buffer DMA safe, thanks to Mssakaz=
u Mokuno,
> =A0 =A0 =A0 =A0 =A0David Brownell and Grant Likely for pointing the b=
ug out
> =A0since v4:
> =A0 =A0 =A0 =A0* Add explanation why not using DMA
> =A0 =A0 =A0 =A0* Fix a bug in max3110_read_multi()
> =A0since v3:
> =A0 =A0 =A0 =A0* Remove the Designware controller related stuff
> =A0 =A0 =A0 =A0* Remove some initialization code which should be done=
 in the platform
> =A0 =A0 =A0 =A0 =A0setup code
> =A0 =A0 =A0 =A0* Add a missing change for drivers/serial/Makefile
> =A0since v2:
> =A0 =A0 =A0 =A0* Address comments from Andrew Morton
> =A0 =A0 =A0 =A0* Use test/set_bit to avoid race condition for SMP/pre=
empt case
> =A0 =A0 =A0 =A0* Fix bug related with endian order
> =A0since v1:
> =A0 =A0 =A0 =A0* Address comments from Alan Cox
> =A0 =A0 =A0 =A0* Use a "use_irq" module parameter to runtime check wh=
ether
> =A0 =A0 =A0 =A0 =A0to use IRQ mode
> =A0 =A0 =A0 =A0* Add the suspend/resume implementation
>
> Thanks!
> Feng
>
>
> From 6ff1d75c34d9465d4ffce076350473bfaf5404a5 Mon Sep 17 00:00:00 200=
1
> From: Feng Tang <feng.tang@intel.com>
> Date: Fri, 26 Feb 2010 11:37:29 +0800
> Subject: [PATCH] serial: spi: add spi-uart driver for Maxim 3110
>
> This is the driver for Max3110 SPI-UART device, which connect
> to host with SPI interface. It supports baud rates from 300 to
> 230400, and supports both polling and IRQ mode, as well as
> providing a console for system use
>
> Its datasheet could be found here:
> http://datasheets.maxim-ic.com/en/ds/MAX3110E-MAX3111E.pdf
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Greg KH <greg@kroah.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---
> =A0drivers/serial/Kconfig =A0 =A0 =A0| =A0 =A08 +
> =A0drivers/serial/Makefile =A0 =A0 | =A0 =A01 +
> =A0drivers/serial/max3110.c =A0 =A0| =A0892 +++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/serial/max3110.h =A0 =A0| =A0 61 +++

Why the separate .h file?  If it isn't used by multiple .c files, then
it belongs in the .c file itself.

> =A0include/linux/serial_core.h | =A0 =A03 +
> =A05 files changed, 965 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/serial/max3110.c
> =A0create mode 100644 drivers/serial/max3110.h
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ff47db..94aa282 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -688,6 +688,14 @@ config SERIAL_SA1100_CONSOLE
> =A0 =A0 =A0 =A0 =A0your boot loader (lilo or loadlin) about how to pa=
ss options to the
> =A0 =A0 =A0 =A0 =A0kernel at boot time.)
>
> +config SERIAL_MAX3110
> + =A0 =A0 =A0 tristate "SPI UART driver for Max3110"
> + =A0 =A0 =A0 depends on SPI_MASTER
> + =A0 =A0 =A0 select SERIAL_CORE
> + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This is the UART protocol driver for MAX3110 device
> +
> =A0config SERIAL_BFIN
> =A0 =A0 =A0 =A0tristate "Blackfin serial port support"
> =A0 =A0 =A0 =A0depends on BLACKFIN
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 5548fe7..b93d8a0 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_SERIAL_S3C24A0) +=3D s3c24a0.o
> =A0obj-$(CONFIG_SERIAL_S3C6400) +=3D s3c6400.o
> =A0obj-$(CONFIG_SERIAL_S5PC100) +=3D s3c6400.o
> =A0obj-$(CONFIG_SERIAL_MAX3100) +=3D max3100.o
> +obj-$(CONFIG_SERIAL_MAX3110) +=3D max3110.o

NAK.  I've looked at the max3100 driver, and the max3110 data sheet
specifically states that it is max3100 compatible.  I'm opposed to the
merging of this driver until you've at least made an attempt at
working with the max3100 driver author to produce a single driver.

> =A0obj-$(CONFIG_SERIAL_IP22_ZILOG) +=3D ip22zilog.o
> =A0obj-$(CONFIG_SERIAL_MUX) +=3D mux.o
> =A0obj-$(CONFIG_SERIAL_68328) +=3D 68328serial.o
> diff --git a/drivers/serial/max3110.c b/drivers/serial/max3110.c
> new file mode 100644
> index 0000000..9b39914
> --- /dev/null
> +++ b/drivers/serial/max3110.c
> @@ -0,0 +1,892 @@
> +/*
> + * max3110.c - spi uart protocol driver for Maxim 3110
> + *
> + * Copyright (c) 2009, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public L=
icense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program; if not, write to the Free Software Foundation, Inc.=
,
> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * Note:
> + * 1. From Max3110 spec, the Rx FIFO has 8 words, while the Tx FIFO =
only has
> + * =A0 =A01 word. If SPI master controller doesn't support sclk freq=
uency change,
> + * =A0 =A0then the char need be sent out one by one with some delay
> + *
> + * 2. Currently only RX availabe interrrupt is used
> + */
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +#include <linux/spi/spi.h>
> +
> +#include "max3110.h"
> +
> +#define PR_FMT "max3110: "
> +
> +struct uart_max3110 {
> + =A0 =A0 =A0 struct uart_port port;
> + =A0 =A0 =A0 struct spi_device *spi;
> + =A0 =A0 =A0 char *name;
> +
> + =A0 =A0 =A0 wait_queue_head_t wq;
> + =A0 =A0 =A0 struct task_struct *main_thread;
> + =A0 =A0 =A0 struct task_struct *read_thread;
> + =A0 =A0 =A0 spinlock_t lock;
> +
> + =A0 =A0 =A0 u32 baud;
> + =A0 =A0 =A0 u16 cur_conf;
> + =A0 =A0 =A0 u8 clock;
> + =A0 =A0 =A0 u8 parity, word_7bits;
> + =A0 =A0 =A0 u16 irq;
> +
> + =A0 =A0 =A0 /* bit map for UART status */
> + =A0 =A0 =A0 unsigned long flags;
> +#define M3110_CON_TX_NEED =A0 =A0 =A00
> +#define M3110_UART_TX_NEED =A0 =A0 1
> +#define M3110_IRQ_PENDING =A0 =A0 =A02
> + =A0 =A0 =A0 unsigned long mthread_up;
> +
> + =A0 =A0 =A0 /* console buffer */
> + =A0 =A0 =A0 struct circ_buf con_xmit;
> +};
> +
> +static struct uart_max3110 *pmax;

Don't do this.  To start, it limits the driver to only ever being able
to handle a single instance of the device.  Some drivers use a fixed
size table instead, but that isn't any better either.

Instead of relying on a global variable, store the struct uart_max3110
pointer inside the spi_device.dev.p private data pointer.

=46or the console portion use the struct console.data pointer.

> +
> +static int use_irq =3D 1;
> +module_param(use_irq, int, 0444);
> +MODULE_PARM_DESC(use_irq, "Whether using Max3110's IRQ capability");

Why is this a module param?  Shouldn't this be determined on whether
or not the drivers pdata structure is populated with an irq number?

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
