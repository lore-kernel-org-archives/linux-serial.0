From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: meson: Add earlycon support
Date: Sun, 7 Feb 2016 20:22:47 -0800
Message-ID: <56B81817.1000606@hurleysoftware.com>
References: <1454895533-7219-1-git-send-email-nicolassaenzj@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1454895533-7219-1-git-send-email-nicolassaenzj@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, corbet@lwn.net
List-Id: linux-serial@vger.kernel.org

Hi Nicolas,

On 02/07/2016 05:38 PM, Nicolas Saenz Julienne wrote:
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> ---
>  Documentation/kernel-parameters.txt |  6 ++++++
>  drivers/tty/serial/meson_uart.c     | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 551ecf0..1661af4 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1025,6 +1025,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			the driver will use only 32-bit accessors to read/write
>  			the device registers.
>  
> +		meson,<addr>
> +			Start an early, polled-mode console on an meson serial
> +			port at the specified address. The serial port
> +			must already be setup and configured. Options are not
> +			yet supported.
> +
>  		msm_serial,<addr>
>  			Start an early, polled-mode console on an msm serial
>  			port at the specified address. The serial port
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index b12a37b..f6ff2fa 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -548,6 +548,28 @@ static int __init meson_serial_console_init(void)
>  }
>  console_initcall(meson_serial_console_init);
>  
> +static void meson_early_console_write(struct console *con, const char *s,
> +				      unsigned n)
                                      ^^^^^^^^
I don't really care, but it's customary to use 'unsigned int'.


> +{
> +	struct earlycon_device *dev = con->data;
> +
> +	uart_console_write(&dev->port, s, n, meson_console_putchar);
> +}
> +
> +static int __init meson_early_console_setup(struct earlycon_device *device,
> +					    const char *opt)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = meson_early_console_write;
> +	return 0;
> +}
> +
> +EARLYCON_DECLARE(meson, meson_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
> +		    meson_early_console_setup);
> +

With today's linux-next (or Greg's tty-next tree), it is no longer necessary to
declare separate earlycon's when you want both; OF_EARLYCON_DECLARE() declares
both a devicetree-enabled earlycon and automatically provides for a command line
earlycon of the same name.

Regards,
Peter Hurley

>  #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>  #else
>  #define MESON_SERIAL_CONSOLE	NULL
> 

