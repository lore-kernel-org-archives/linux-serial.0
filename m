From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 06/10] serial: pxa: Add fifo-size and
 {big,native}-endian properties
Date: Wed, 19 Nov 2014 14:49:11 +0000
Message-ID: <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
	<1415825647-6024-7-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46198 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbaKSOtP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2014 09:49:15 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so2100616wiw.10
        for <linux-serial@vger.kernel.org>; Wed, 19 Nov 2014 06:49:14 -0800 (PST)
In-Reply-To: <1415825647-6024-7-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Wed, 12 Nov 2014 12:54:03 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> With a few tweaks, the PXA serial driver can handle other 16550A clones.
> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> and {native,big}-endian properties similar to regmap to support SoCs that
> have BE or "automagic endian" registers.

Hold the phone, if these are 16550A clone ports, then why is the pxa
driver being adapted to drive them? I would expect the of_serial.c
driver to be used. It's already got support for multiple variants of the
16550.

g.

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..21406dc 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> -	return readl(up->port.membase + offset);
> +	if (up->port.iotype == UPIO_MEM32BE)
> +		return ioread32be(up->port.membase + offset);
> +	else
> +		return readl(up->port.membase + offset);
>  }
>  
>  static inline void serial_out(struct uart_pxa_port *up, int offset, int value)
>  {
>  	offset <<= 2;
> -	writel(value, up->port.membase + offset);
> +	if (up->port.iotype == UPIO_MEM32BE)
> +		iowrite32be(value, up->port.membase + offset);
> +	else
> +		writel(value, up->port.membase + offset);
>  }
>  
>  static void serial_pxa_enable_ms(struct uart_port *port)
> @@ -833,6 +839,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	int ret;
> +	u32 val;
>  
>  	if (!np)
>  		return 1;
> @@ -843,6 +850,13 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
>  		return ret;
>  	}
>  	sport->port.line = ret;
> +
> +	if (of_property_read_u32(np, "fifo-size", &val) == 0)
> +		sport->port.fifosize = val;
> +
> +	sport->port.iotype =
> +		of_device_is_big_endian(np) ? UPIO_MEM32BE : UPIO_MEM32;
> +
>  	return 0;
>  }
>  
> -- 
> 2.1.1
> 

