From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 3/4] serial: sh-sci: make RX FIFO parameters tunable via sysfs
Date: Sun, 12 Feb 2017 18:04:52 +0200
Message-ID: <1794065.DucaPDu9pY@avalon>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1486118300-12633-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486118300-12633-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org, wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Friday 03 Feb 2017 11:38:19 Ulrich Hecht wrote:
> Allows tuning of the RX FIFO fill threshold and timeout. (The latter is
> only applicable to SCIFA and SCIFB).
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 87 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 4a165ed..f95a56c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1055,6 +1055,66 @@ static void rx_fifo_timer_fn(unsigned long arg)
>  	scif_set_rtrg(port, 1);
>  }
> 
> +static ssize_t rx_trigger_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct sci_port *sci = to_sci_port(port);
> +
> +	return sprintf(buf, "%d\n", sci->rx_trigger);
> +}
> +
> +static ssize_t rx_trigger_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t count)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct sci_port *sci = to_sci_port(port);
> +	long r;
> +
> +	if (kstrtol(buf, 0, &r) == -EINVAL)
> +		return -EINVAL;
> +	sci->rx_trigger = scif_set_rtrg(port, r);
> +	scif_set_rtrg(port, 1);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(rx_fifo_trigger, 0644, rx_trigger_show,
> rx_trigger_store); +
> +static ssize_t rx_fifo_timeout_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct sci_port *sci = to_sci_port(port);
> +
> +	return sprintf(buf, "%d\n", sci->rx_fifo_timeout);
> +}
> +
> +static ssize_t rx_fifo_timeout_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t count)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct sci_port *sci = to_sci_port(port);
> +	long r;
> +
> +	if (kstrtol(buf, 0, &r) == -EINVAL)
> +		return -EINVAL;
> +	sci->rx_fifo_timeout = r;
> +	scif_set_rtrg(port, 1);
> +	if (r > 0)
> +		setup_timer(&sci->rx_fifo_timer, rx_fifo_timer_fn,
> +			    (unsigned long)sci);

Where's the locking ?

> +	return count;
> +}
> +
> +static DEVICE_ATTR(rx_fifo_timeout, 0644, rx_fifo_timeout_show,
> rx_fifo_timeout_store); +
> +
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
>  static void sci_dma_tx_complete(void *arg)
>  {
> @@ -2886,6 +2946,15 @@ static int sci_remove(struct platform_device *dev)
> 
>  	sci_cleanup_single(port);
> 
> +	if (port->port.fifosize > 1) {
> +		sysfs_remove_file(&dev->dev.kobj,
> +				  &dev_attr_rx_fifo_trigger.attr);
> +	}
> +	if (port->port.type == PORT_SCIFA || port->port.type == PORT_SCIFB) {
> +		sysfs_remove_file(&dev->dev.kobj,
> +				  &dev_attr_rx_fifo_timeout.attr);
> +	}

No need for curly braces.

> +
>  	return 0;
>  }
> 
> @@ -3051,6 +3120,24 @@ static int sci_probe(struct platform_device *dev)
>  	if (ret)
>  		return ret;
> 
> +	if (sp->port.fifosize > 1) {
> +		ret = sysfs_create_file(&dev->dev.kobj,
> +				&dev_attr_rx_fifo_trigger.attr);

You should use device_create_file for device attributes. Even better would be 
to create an attribute group if possible.

> +		if (ret)
> +			return ret;
> +	}
> +	if (sp->port.type == PORT_SCIFA || sp->port.type ==  PORT_SCIFB) {
> +		ret = sysfs_create_file(&dev->dev.kobj,
> +				&dev_attr_rx_fifo_timeout.attr);
> +		if (ret) {
> +			if (sp->port.fifosize > 1) {
> +				sysfs_remove_file(&dev->dev.kobj,
> +					&dev_attr_rx_fifo_trigger.attr);
> +			}
> +			return ret;
> +		}
> +	}
> +
>  #ifdef CONFIG_SH_STANDARD_BIOS
>  	sh_bios_gdb_detach();
>  #endif

-- 
Regards,

Laurent Pinchart
