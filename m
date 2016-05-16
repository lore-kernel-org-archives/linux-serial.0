From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] tty/serial: to support 8250 earlycon can be enabled
 independently
Date: Mon, 16 May 2016 08:40:12 -0700
Message-ID: <5739E9DC.3060805@hurleysoftware.com>
References: <1463398558-6636-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463398558-6636-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

On 05/16/2016 04:35 AM, Zhen Lei wrote:
> Sometimes, we may only use SSH to login, and build 8250 uart driver as a
> ko(insmod if needed). But the earlycon may still be necessary, because
> the kernel boot process may take a long time. It's not good to display
> nothing but ask people to wait patiently.

I'm confused; you want the possibility of earlycon but _not_ a normal
serial console?

This configuration is unsafe because nothing prevents the 8250 driver
and 8250 earlycon from concurrently accessing the hardware.


> In addition, the 8250.ko can not be worked if we have not opened any
> other serial drivers, because SERIAL_CORE would not be selected.

I don't understand what this means.

Regards,
Peter Hurley


> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/tty/serial/8250/Kconfig  | 9 +++++++--
>  drivers/tty/serial/8250/Makefile | 1 -
>  drivers/tty/serial/Makefile      | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 4d7cb9c..2992f0a 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -3,6 +3,12 @@
>  # you somehow have an implicit or explicit dependency on SERIAL_8250.
>  #
> 
> +config SERIAL_8250_EARLYCON
> +	bool "Early console using 8250"
> +	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +
>  config SERIAL_8250
>  	tristate "8250/16550 and compatible serial support"
>  	select SERIAL_CORE
> @@ -60,8 +66,7 @@ config SERIAL_8250_PNP
>  config SERIAL_8250_CONSOLE
>  	bool "Console on 8250/16550 and compatible serial port"
>  	depends on SERIAL_8250=y
> -	select SERIAL_CORE_CONSOLE
> -	select SERIAL_EARLYCON
> +	select SERIAL_8250_EARLYCON
>  	---help---
>  	  If you say Y here, it will be possible to use a serial port as the
>  	  system console (the system console is the device which receives all
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index c9a2d6e..1f24c74 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
>  obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
>  obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
>  obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
> -obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 8c261ad..cd84181 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
> 
>  # Now bring in any enabled 8250/16450/16550 type drivers.
>  obj-$(CONFIG_SERIAL_8250) += 8250/
> +obj-$(CONFIG_SERIAL_8250_EARLYCON) += 8250/8250_early.o
> 
>  obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
>  obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
> --
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
