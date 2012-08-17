From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 1/1] [RFC] uartclk from serial_core exposed to sysfs
Date: Fri, 17 Aug 2012 08:06:03 -0700
Message-ID: <20120817150603.GA13684@kroah.com>
References: <1344929718-22736-1-git-send-email-tmshlvck@gmail.com>
 <1345214637-4189-1-git-send-email-tmshlvck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51410 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab2HQPGL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Aug 2012 11:06:11 -0400
Received: by pbbrr13 with SMTP id rr13so3451807pbb.19
        for <linux-serial@vger.kernel.org>; Fri, 17 Aug 2012 08:06:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345214637-4189-1-git-send-email-tmshlvck@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, marek.vasut@gmail.com

On Fri, Aug 17, 2012 at 04:43:57PM +0200, Tomas Hlavacek wrote:
> Added file /sys/devices/.../tty/ttySX/uartclk to allow reading
> uartclk value in struct uart_port in serial_core via sysfs.

Whenever you add/remove/modify a sysfs file, you also need to add an
update to Documentation/ABI/ as well.

Please add this to the patch and resend.

> It simplifies initialization verification of no-name cards that
> have non-standard oscillator speed while having no distinguishing
> PCI IDs to allow autodetection.
> 
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c |   32 ++++++++++++++++++++++++++++++++
>  drivers/tty/tty_io.c             |   17 +++++++++++++++++
>  include/linux/tty.h              |    2 ++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a21dc8e..454e9d3 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2293,6 +2293,24 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
>  	return p->tty_driver;
>  }
>  
> +static ssize_t uart_get_attr_uartclk(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +
> +	struct tty_port *port = dev_get_drvdata(dev);
> +	struct uart_state *state = container_of(port, struct uart_state, port);
> +
> +	mutex_lock(&state->port.mutex);
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", state->uart_port->uartclk);
> +	mutex_unlock(&state->port.mutex);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR(uartclk, S_IRUSR | S_IRGRP, uart_get_attr_uartclk,
> +		NULL);
> +
>  /**
>   *	uart_add_one_port - attach a driver-defined port structure
>   *	@drv: pointer to the uart low level driver structure for this port
> @@ -2355,6 +2373,14 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	}
>  
>  	/*
> +	 * Expose uartclk in sysfs. Use driverdata of the tty device for
> +	 * referencing the UART port.
> +	 */
> +	dev_set_drvdata(tty_dev, port);
> +	if (device_create_file(tty_dev, &dev_attr_uartclk) < 0)
> +		dev_err(tty_dev, "Failed to add uartclk attr\n");

I think you just raced with userspace in creating the file after the
device was announced to userspace.  Are you sure it's ok?

If not (hint, I don't think so), please make it a default attribute of
the device, which will then cause the file to be created before it is
announced to userspace.  It will also be less code as you don't have to
clean it up by hand :)

> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3049,6 +3049,23 @@ void tty_unregister_device(struct tty_driver *driver, unsigned index)
>  }
>  EXPORT_SYMBOL(tty_unregister_device);
>  
> +/*
> + *	tty_lookup_device - lookup a tty device
> + *	@driver: the tty driver that describes the tty device
> + *	@index: the index in the tty driver for this tty device
> + *
> + *	This function returns a struct device pointer when device has
> + *	been found and NULL otherwise.
> + *
> + *	Locking: ??
> + */
> +struct device *tty_lookup_device(struct tty_driver *driver, unsigned index)
> +{
> +	dev_t devt = MKDEV(driver->major, driver->minor_start) + index;
> +	return class_find_device(tty_class, NULL, &devt, dev_match_devt);
> +}
> +EXPORT_SYMBOL(tty_lookup_device);

EXPORT_SYMBOL_GPL as you are just wrapping a class_find_device() call?

thanks,

greg k-h
