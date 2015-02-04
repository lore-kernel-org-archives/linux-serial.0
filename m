From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH_V2 25/34] serial: 8250_jz47xx: support for Ingenic
 jz47xx UARTs
Date: Wed, 04 Feb 2015 22:02:57 +0100
Message-ID: <1423083777.27378.8.camel@x220>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
	 <1423063323-19419-26-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-26-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: linux-mips@linux-mips.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-02-04 at 15:21 +0000, Zubair Lutfullah Kakakhel wrote:
> From: Paul Burton <paul.burton@imgtec.com>
> 
> Introduce a driver suitable for use with the UARTs present in
> Ingenic jz47xx series SoCs. These are described as being ns16550
> compatible but aren't quite - they require the setting of an extra bit
> in the FCR register to enable the UART module. The serial_out
> implementation is the same as that in arch/mips/jz4740/serial.c - which
> will shortly be removed.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-serial@vger.kernel.org
> 
> ---
> V2 changes
> Removed FSF address
> Added select SERIAL_CORE_CONSOLE to fix a build error
> ---
>  drivers/tty/serial/8250/8250_jz47xx.c | 225 ++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig       |   9 ++
>  drivers/tty/serial/8250/Makefile      |   1 +
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
> 
>[...]
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 0fcbcd2..ebb298e 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -322,3 +322,12 @@ config SERIAL_8250_MT6577
>  	help
>  	  If you have a Mediatek based board and want to use the
>  	  serial port, say Y to this option. If unsure, say N.
> +
> +config SERIAL_8250_JZ47XX
> +	tristate "Support for Ingenic jz47xx series serial ports"
> +	depends on SERIAL_8250
> +	select SERIAL_EARLYCON
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  If you have a system using an Ingenic jz47xx series SoC and wish to
> +	  make use of its UARTs, say Y to this option. If unsure, say N.

Nit: should people never say M?


Paul Bolle
