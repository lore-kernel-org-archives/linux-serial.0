From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10] serial: support for 16550A serial ports on LP-8x4x
Date: Fri, 4 Mar 2016 22:26:39 -0600
Message-ID: <20160305042639.GK13525@rob-hp-laptop>
References: <1456862903-12392-1-git-send-email-ynvich@gmail.com>
 <1456867544-19302-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456867544-19302-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Joachim Eastwood <manabian@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list:SERIAL DRIVERS
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 02, 2016 at 12:25:35AM +0300, Sergei Ianovich wrote:
> The patch adds support for 3 additional LP-8x4x built-in serial
> ports.
> 
> The device can also host up to 8 extension cards with 4 serial ports
> on each card for a total of 35 ports. However, I don't have
> the hardware to test extension cards, so they are not supported, yet.

That's a lot of serial ports...

[...]

> diff --git a/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt b/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt
> new file mode 100644
> index 0000000..d6acd22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/icpdas-lp8841-uart.txt
> @@ -0,0 +1,41 @@
> +* UART ports on ICP DAS LP-8841
> +
> +LP-8441, LP-8141 and LP-8041 are fully compatible.
> +
> +ICP DAS LP-8841 contains three additional serial ports interfaced via
> +Analog Devices ADM213EA chips in addition to 3 serial ports on PXA CPU.
> +
> +The chips themselves are standard, they would work with 8250_core if

Describe in h/w terms how they are different, not what Linux driver 
won't work.

> +properly connected. However, they are not connected normally. Al least

s/Al/At/

> +some of their config pins are wired to a different address region. So
> +the driver is board-specific.
> +
> +Required properties:
> +- compatible : should be "icpdas,uart-lp8841"
> +
> +- reg : should provide 16 byte man IO memory region and 1 byte region for

What is "man IO"?

> +	termios

termios is a Linux term.

> +
> +- interrupts : should provide interrupt

Perhaps you should include other properties standard for 8250 such as 
access size or shift. Possibly if the non-standard bits are already 
configured, the UART could be used for earlycon?

> +
> +Optional property:
> +- interrupt-parent : should provide a link to interrupt controller either
> +		     explicitly or implicitly from a parent node
> +
> +Examples (from pxa27x-lp8x4x.dts):
> +
> +		serial@9050 {
> +			compatible = "icpdas,uart-lp8841";
> +			reg = <0x9050 0x10
> +			       0x9030 0x02>;
> +			interrupts = <13>;
> +			status = "okay";
> +		};
> +
> +		serial@9060 {
> +			compatible = "icpdas,uart-lp8841";
> +			reg = <0x9060 0x10
> +			       0x9032 0x02>;
> +			interrupts = <14>;
> +			status = "okay";
> +		};

[...]

> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 3b5cf9c..68640c1 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -394,3 +394,17 @@ config SERIAL_8250_PXA
>  	help
>  	  If you have a machine based on an Intel XScale PXA2xx CPU you
>  	  can enable its onboard serial ports by enabling this option.
> +
> +	  If you choose M here, the module name will be 8250_pxa.
> +
> +config SERIAL_8250_LP8841
> +	tristate "Support 16550A ports on ICP DAS LP-8841"
> +	depends on SERIAL_8250 && MACH_PXA27X_DT
> +	select LP8841_IRQ

Generally, drivers don't select their interrupt controller.

> +	help
> +	  In addition to serial ports on PXA270 SoC, LP-8841 has 1 dual
> +	  RS232/RS485 port, 1 RS485 port and 1 RS232 port.
> +
> +	  Say N here, unless you plan to run this kernel on a LP-8841 system.
> +
> +	  If you choose M here, the module name will be 8250_lp8841.

> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index d1e2f2d..10b4bf0 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o

>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
> +obj-$(CONFIG_SERIAL_8250_LP8X4X)	+= 8250_lp8x4x.o

This should be dropped.

>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
>  obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
> @@ -30,5 +31,6 @@ obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
>  obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
>  obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
> +obj-$(CONFIG_SERIAL_8250_LP8841)	+= 8250_lp8841.o

This should be in alphabetical order. OF_PLATFORM is not for legacy 
reasons I think.

>  
>  CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
> -- 
> 2.7.0
> 
