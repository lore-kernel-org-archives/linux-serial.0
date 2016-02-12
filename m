From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 8/9] serial: 8250: add acpi_match
Date: Fri, 12 Feb 2016 10:56:33 -0800
Message-ID: <20160212185633.GC10095@kroah.com>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-9-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455299022-11641-9-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Mark Salter <msalter@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 12, 2016 at 08:43:39PM +0300, Aleksey Makarov wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> Add an implementation of acpi_match() to the 8250 driver.
> It allows console to check if it matches the console specified by
> ACPI SPCR table.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/tty/serial/8250/8250_core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 7775221..059338a 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -40,6 +40,7 @@
>  #ifdef CONFIG_SPARC
>  #include <linux/sunserialcore.h>
>  #endif
> +#include <linux/acpi.h>
>  
>  #include <asm/irq.h>
>  
> @@ -669,12 +670,34 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>  	return -ENODEV;
>  }
>  
> +static int __init univ8250_console_acpi_match(struct console *co,
> +					      struct acpi_table_spcr *spcr)
> +{
> +	int index = co->index >= 0 ? co->index : 0;
> +	struct uart_port *port = &serial8250_ports[index].port;
> +
> +	if (spcr->interface_type != ACPI_DBG2_16550_SUBSET &&
> +	    spcr->interface_type != ACPI_DBG2_16550_COMPATIBLE)
> +		return -ENODEV;
> +
> +	if (spcr->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> +	    spcr->serial_port.address == (u64)port->mapbase)
> +		return 0;
> +
> +	if (spcr->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
> +	    spcr->serial_port.address == (u64)port->iobase)
> +		return 0;
> +
> +	return -ENODEV;
> +}

Ick, I don't like this, you are doing almost the same thing that
univ8250_console_match does, yet you have to know the internals of the
acpi_table_spcr structure, which is insane (again, do you want to do
this for every firmware type?)

Isn't this something that resources are supposed to handle for us?  What
happened to getting this type of information from the firmware in a
non-firmware-specific way to pass to the drivers?  Please work on that
instead, then you don't have to modify each and every single driver you
want to work with your system, they will all "just work" automagically.

Please redo this series, as it is, I don't like it at all.

thanks,

greg k-h
