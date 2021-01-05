Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BCEC433DB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424DC225AC
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbhAEN1f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbhAEN1d (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 08:27:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2877229C5;
        Tue,  5 Jan 2021 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609853212;
        bh=W+IJs7urgK/jizFjM9m8hHegfA4Pv/rQbKGR6L2Iuno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQmDp6iVBmWk+GZDr9TgzIdxQTc4EmgnSI7qSGotEP2IAau0DBtl1a2Jh8t+h3TXp
         rbGKdapTRqphhfRejBGu7I6MOi8w+uBuQVmOAAZUySYq6da06DkOVm1HbLCFqv+KsK
         GSJ5AAsIjUadZWbXEreNOxGLYI2avr2ZVYxwsDm4=
Date:   Tue, 5 Jan 2021 14:28:16 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,1/2] Serial: silabs si4455 serial driver
Message-ID: <X/RpcButq6PhqdIs@kroah.com>
References: <20210105102921.GA10736@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105102921.GA10736@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 05, 2021 at 10:29:25AM +0000, József Horváth wrote:
> This is a serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> The goal of this driver is to removing wires
>  between central(linux) device and remote serial devices/sensors,
>  but keeping the original user software.
>  It represents regular serial interface for the user space.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Guide: https://github.com/dministro/linux-serial-si4455
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>
> ---
> 
> changes v1:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: error checking and order
>  - fixed: drivers: serial: si4455: remove unnecessary compatibility
>    strings from si4455_dt_ids
> 
> changes v2:
>  - fixed: drivers: serial: si4455: coding style
> 
> changes v3:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: replace device configuration procedure
>    (SI4455_IOC_SEZC ioctl call) with request_firmware(...).
>    The firmware name comes from dt (silabs,ez-config)
>  - fixed: drivers: serial: si4455: replace transmit/receive channel
>    select (SI4455_IOC_STXC/SI4455_IOC_SRXC ioctl calls)
>    with sysfs entries (tx_channel, rx_channel).
>    Initial values comes from dt (silabs,tx-channel and silabs,rx-channel)
>  - fixed: drivers: serial: si4455: replace package size setting
>    (SI4455_IOC_SSIZ ioctl call) with sysfs entry (package_size).
>    Initial value comes from dt (silabs,package-size)
>  - fixed: drivers: serial: si4455: replace getting last rssi
>    (SI4455_IOC_GRSSI ioctl call) with sysfs entry (current_rssi)
>  - fixed: drivers: serial: si4455: remove si4455_api.h
>    and custom ioctl definitions
> 
> changes v5:
>  - fixed: drivers: serial: si4455: coding style
>  - fixed: drivers: serial: si4455: remove struct si4455_one,
>    members moved to struct si4455_port
>  - fixed: drivers: serial: si4455: fix line endings in dev_err and
>    dev_dbg messages
>  - fixed: drivers: serial: si4455: remove unnecessary else { ... }
>  - fixed: drivers: serial: si4455: refactor si4455_do_work(...),
>    xmit circular buffer handling and start tx moved to
>    si4455_start_tx_xmit(...)
>  - fixed: drivers: serial: si4455: refactor si4455_configure
>  - fixed: drivers: serial: si4455: refactor interrupt handling,
>    remove unnecessary wrapper
>  - fixed: drivers: serial: si4455: modem line(si4455_get_mctrl)
>    and tx buffer status(si4455_tx_empty) conditions and signaling
>  - fixed: drivers: serial: si4455: remove unsafe int to pointer conversion
> 
> changes v6:
>  - fixed: drivers: serial: si4455: illegal characters in
>    MODULE_AUTHOR("...") Reported-by: kernel test robot <lkp@intel.com>
> 
> changes v7:
>  - added: drivers: serial: si4455: variable packet length support
>  - added: drivers: serial: si4455: extended error handling
>  - added: dt: bindings: silabs,si4455: silabs,tx-timeout property definition
> ---
>  MAINTAINERS                 |    6 +
>  drivers/tty/serial/Kconfig  |    8 +
>  drivers/tty/serial/Makefile |    1 +
>  drivers/tty/serial/si4455.c | 1721 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1736 insertions(+)
>  create mode 100644 drivers/tty/serial/si4455.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a008b70f3c16..ca6e32693a74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15952,6 +15952,12 @@ M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
>  S:	Supported
>  F:	drivers/staging/wfx/
>  
> +SILICON LABS SI4455 SERIAL DRIVER
> +M:	Jozsef Horvath <info@ministro.hu>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> +F:	drivers/tty/serial/si4455.c
> +
>  SILICON MOTION SM712 FRAME BUFFER DRIVER
>  M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>  M:	Teddy Wang <teddy.wang@siliconmotion.com>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 28f22e58639c..560aa311cd03 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1583,6 +1583,14 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
>  	  receives all kernel messages and warnings and which allows logins in
>  	  single user mode).
>  
> +config SERIAL_SI4455
> +	tristate "Si4455 support"
> +	depends on SPI
> +	select SERIAL_CORE
> +	help
> +	  This driver is for Silicon Labs's Si4455 Sub-GHz transciver.
> +	  Say 'Y' here if you wish to use it as serial port.
> +

No module name?

>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index caf167f0c10a..f01ff43db1d6 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
>  obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
>  obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
>  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
> +obj-$(CONFIG_SERIAL_SI4455)	+= si4455.o
>  obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
>  
>  # GPIOLIB helpers for modem control lines
> diff --git a/drivers/tty/serial/si4455.c b/drivers/tty/serial/si4455.c
> new file mode 100644
> index 000000000000..615c783b7aa2
> --- /dev/null
> +++ b/drivers/tty/serial/si4455.c
> @@ -0,0 +1,1721 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 József Horváth <info@ministro.hu>
> + *
> + */
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/spi/spi.h>
> +#include <linux/uaccess.h>
> +#include <linux/string.h>
> +#include <linux/firmware.h>
> +#include <linux/timer.h>
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +#endif

No need for #ifdef for .h files.

> +
> +#define PORT_SI4455						1096
> +#define SI4455_NAME						"Si4455"
> +#define SI4455_MAJOR						432
> +#define SI4455_MINOR						567

Where are these major/minor numbers being used and where did they come
from?  Why do you need them?

> +struct si4455_port {
> +	struct uart_port port;
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dbgfs_dir;
> +#endif

Do not put #ifdefs in .c code, you never need to check for this type of
thing.

> +static struct uart_driver si4455_uart = {
> +	.owner			= THIS_MODULE,
> +	.driver_name		= SI4455_NAME,
> +#ifdef CONFIG_DEVFS_FS
> +	.dev_name		= "ttySI%d",

Looks like you are porting this from a _VERY_ old kernel.  That config
option went away 15+ years ago.  Are you sure this works?


> +#else
> +	.dev_name		= "ttySI",

Where did you get that name from?


> +static int si4455_begin_tx(struct uart_port *port, u32 channel, int length,
> +			   u8 *data)
> +{
> +	int ret = 0;
> +	struct si4455_int_status int_status = { 0 };
> +	struct si4455_fifo_info fifo_info = { 0 };
> +
> +	dev_dbg(port->dev, "%s(%u, %u)\n", __func__, channel, length);

No need for these types of debugging lines, just use ftrace.

Please remove them, you have them in a few places (same for the end of
functions.)

> +static void si4455_null_void(struct uart_port *port)
> +{
> +	/* Do nothing */

Why do you need this???

> +#ifdef CONFIG_DEBUG_FS

Again, no #ifdef needed.

> +static int si4455_debugfs_init(struct device *dev)
> +{
> +	struct si4455_port *s = dev_get_drvdata(dev);
> +	struct dentry *dbgfs_si_dir;
> +	struct dentry *dbgfs_partinfo_dir;
> +	struct dentry *dbgfs_entry;
> +
> +	s->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR(s->dbgfs_dir))
> +		return PTR_ERR(s->dbgfs_dir);

No  need to check any debugfs return value, just use it and move on.

> +
> +	dbgfs_si_dir = debugfs_create_dir("si4455", s->dbgfs_dir);
> +	if (IS_ERR(dbgfs_si_dir))
> +		return PTR_ERR(dbgfs_si_dir);
> +
> +	dbgfs_entry = debugfs_create_u32("cts_error_count", 0444,
> +					 dbgfs_si_dir, &s->cts_error_count);
> +	if (IS_ERR(dbgfs_entry))
> +		return PTR_ERR(dbgfs_entry);

Same for all of these, no need to check anything.

> +
> +	dbgfs_entry = debugfs_create_u32("tx_error_count", 0444,
> +					 dbgfs_si_dir, &s->tx_error_count);
> +	if (IS_ERR(dbgfs_entry))
> +		return PTR_ERR(dbgfs_entry);
> +
> +	dbgfs_partinfo_dir = debugfs_create_dir("partinfo", dbgfs_si_dir);
> +	if (IS_ERR(dbgfs_partinfo_dir))
> +		return PTR_ERR(dbgfs_partinfo_dir);
> +
> +	dbgfs_entry = debugfs_create_u8("chip_rev", 0444,
> +					dbgfs_partinfo_dir,
> +					&s->part_info.chip_rev);

Wait, did you even build this code?  Does it work?  It shouldn't, these
debugfs calls have changed...

I'm stopping reviewing here.

thanks,

greg k-h
