From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 40/47] serial: remove cris/etrax uart drivers
Date: Thu, 15 Mar 2018 13:19:11 +0100
Message-ID: <20180315121911.GR17177@axis.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-41-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-41-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:53PM +0100, Arnd Bergmann wrote:
> The cris architecture is getting removed, so we don't need the
> uart driver any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  .../bindings/serial/axis,etraxfs-uart.txt          |   22 -
>  drivers/tty/serial/Kconfig                         |   11 -
>  drivers/tty/serial/Makefile                        |    2 -
>  drivers/tty/serial/crisv10.c                       | 4248 --------------------
>  drivers/tty/serial/crisv10.h                       |  133 -
>  drivers/tty/serial/etraxfs-uart.c                  |  960 -----
>  6 files changed, 5376 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
>  delete mode 100644 drivers/tty/serial/crisv10.c
>  delete mode 100644 drivers/tty/serial/crisv10.h
>  delete mode 100644 drivers/tty/serial/etraxfs-uart.c
> 
> diff --git a/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt b/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
> deleted file mode 100644
> index 048c3818c826..000000000000
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3682fd3e960c..f6e09326042d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1114,17 +1114,6 @@ config SERIAL_VT8500_CONSOLE
>  	depends on SERIAL_VT8500=y
>  	select SERIAL_CORE_CONSOLE
>  
> -config SERIAL_ETRAXFS
> -	bool "ETRAX FS serial port support"
> -	depends on ETRAX_ARCH_V32 && OF
> -	select SERIAL_CORE
> -	select SERIAL_MCTRL_GPIO if GPIOLIB
> -
> -config SERIAL_ETRAXFS_CONSOLE
> -	bool "ETRAX FS serial console support"
> -	depends on SERIAL_ETRAXFS
> -	select SERIAL_CORE_CONSOLE
> -
>  config SERIAL_NETX
>  	tristate "NetX serial port support"
>  	depends on ARCH_NETX
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 842d185d697e..c21835dc16b2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -51,8 +51,6 @@ obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
>  obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
>  obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
>  obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
> -obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
> -obj-$(CONFIG_SERIAL_ETRAXFS) += etraxfs-uart.o
>  obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
>  obj-$(CONFIG_SERIAL_SC16IS7XX_CORE) += sc16is7xx.o
>  obj-$(CONFIG_SERIAL_JSM) += jsm/
> diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
> deleted file mode 100644
> index c9458a033e3c..000000000000
> diff --git a/drivers/tty/serial/crisv10.h b/drivers/tty/serial/crisv10.h
> deleted file mode 100644
> index 79ba2bc95d3d..000000000000
> diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
> deleted file mode 100644
> index 24bf6bfb29b4..000000000000
> -- 
> 2.9.0

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
