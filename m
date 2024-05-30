Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253CB13211A;
	Thu, 30 May 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073097; cv=none; b=tkwchYTyj8vO8loxxdI7FePHWLYeNXFpOjSaJA4gkrq3Q6qYfK7EkNxiVqtEK5LcqUy1EPvpYB0giAitK1RoSDyNh5vx3NGm48updL3ZOQPgENQ+7tlXVHHGvu1tlIto1hdZ4kumO+DkWFDjLOCTYODkyC4WuPxiU7GowRjfFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073097; c=relaxed/simple;
	bh=BE5vKjWoF5clRJtqrDhKP5DaIp8mpQT6m134/dlB5jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLgTKmEf/V9I67txFQoqLszovak8WfLjVXaHS2YMhho7cN9hh+hhYO3eZimDxuR1v6Nn3kjmORC3imd/Vc3Gtj1vimlFHyM1En1P3lqxrLouDz1IamfRTkmNWmNxxqPn0VBtAjujtj46Kd/ZlxDC5O3lfgXrYqZyWuGFG+0nQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioZafEyQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioZafEyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569AFC2BBFC;
	Thu, 30 May 2024 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717073096;
	bh=BE5vKjWoF5clRJtqrDhKP5DaIp8mpQT6m134/dlB5jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioZafEyQtEczCqRpQo7xFcf/W2XF5tkER2qdhpO6JVZpf6j6P0711matV43Ya70gZ
	 ii3noAJn8+slkpAUbPSJ6+bC2bf8NVi+YUhh69hDtKPZXIbTvjAiPIB5Y1rMBsor3z
	 Dw5U8mxIVDzJn6bxhHdCCDPTplUhcJDG60LAtP2g=
Date: Thu, 30 May 2024 14:45:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: CrescentCY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Passing attr_group to universal driver
Message-ID: <2024053013-clapping-germless-d50d@gregkh>
References: <20240530094457.1974-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530094457.1974-1-crescentcy.hsieh@moxa.com>

On Thu, May 30, 2024 at 05:44:57PM +0800, CrescentCY Hsieh wrote:
> Many low-level drivers in Linux kernel register their serial ports with
> the help of universal driver (8250_core, 8250_port).
> 
> There is an attribute group called `serial8250_dev_attr_group` within
> `8250_port.c` to handle the `rx_trig_bytes` attribute:
> https://lore.kernel.org/all/20140716011931.31474.68825.stgit@yuno-kbuild.novalocal/
> 
> However, if a low-level driver has some HW specifications that need to
> be set or retrieved using an attr_group, the universal driver
> (8250_port) would overwrite the low-level driver's attr_group.
> 
> This patch allows the low-level driver's attr_group to be passed to the
> universal driver (8250_port) and combines the two attr_groups. This
> ensures that the corresponding system file will only be created if the
> device is registered by such a low-level driver.

Great!  But is this needed now by any in-kernel drivers, or is this only
needed by things that are not in our tree?

If in our tree, what driver(s) does this fix up?  If none, then for
obvious reasons, we can't take this change.

> 
> Signed-off-by: CrescentCY Hsieh <crescentcy.hsieh@moxa.com>
> ---
>  drivers/tty/serial/8250/8250_core.c |  9 +++++++++
>  drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++++++++--
>  include/linux/serial_core.h         |  1 +
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 43824a174a51..01d04f9d5192 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1130,6 +1130,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  			uart->port.pm = up->port.pm;
>  		if (up->port.handle_break)
>  			uart->port.handle_break = up->port.handle_break;
> +		if (up->port.attr_group)
> +			uart->port.attr_group = up->port.attr_group;
>  		if (up->dl_read)
>  			uart->dl_read = up->dl_read;
>  		if (up->dl_write)
> @@ -1210,6 +1212,13 @@ void serial8250_unregister_port(int line)
>  		uart->port.type = PORT_UNKNOWN;
>  		uart->port.dev = &serial8250_isa_devs->dev;
>  		uart->port.port_id = line;
> +
> +		if (uart->port.attr_group_allocated) {
> +			kfree(uart->port.attr_group->attrs);
> +			kfree(uart->port.attr_group);
> +			uart->port.attr_group_allocated = false;

Why is this needed to be set to false now, how can it matter anymore?

> +		}
> +		uart->port.attr_group = NULL;
>  		uart->capabilities = 0;
>  		serial8250_init_port(uart);
>  		serial8250_apply_quirks(uart);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 893bc493f662..ddfa8b59e562 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3135,9 +3135,31 @@ static struct attribute_group serial8250_dev_attr_group = {
>  static void register_dev_spec_attr_grp(struct uart_8250_port *up)
>  {
>  	const struct serial8250_config *conf_type = &uart_config[up->port.type];
> +	struct attribute **upp_attrs = NULL;
> +	int upp_attrs_num = 0, i;
>  
> -	if (conf_type->rxtrig_bytes[0])
> -		up->port.attr_group = &serial8250_dev_attr_group;
> +	up->port.attr_group_allocated = false;
> +
> +	if (up->port.attr_group) {
> +		upp_attrs = up->port.attr_group->attrs;
> +
> +		while (upp_attrs[upp_attrs_num])
> +			upp_attrs_num++;
> +
> +		up->port.attr_group = kcalloc(1, sizeof(struct attribute_group), GFP_KERNEL);
> +		up->port.attr_group->attrs = kcalloc(upp_attrs_num + 2, sizeof(struct attribute *), GFP_KERNEL);
> +
> +		for (i = 0; i < upp_attrs_num; ++i)
> +			up->port.attr_group->attrs[i] = upp_attrs[i];
> +
> +		if (conf_type->rxtrig_bytes[0])
> +			up->port.attr_group->attrs[upp_attrs_num] = &dev_attr_rx_trig_bytes.attr;
> +
> +		up->port.attr_group_allocated = true;

This feels odd, why is this all dynamically allocated?  You want to add
another group to the existing group?


> +	} else {
> +		if (conf_type->rxtrig_bytes[0])
> +			up->port.attr_group = &serial8250_dev_attr_group;
> +	}
>  }
>  
>  static void serial8250_config_port(struct uart_port *port, int flags)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 8cb65f50e830..3212d64c32c6 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -581,6 +581,7 @@ struct uart_port {
>  	unsigned char		console_reinit;
>  	const char		*name;			/* port name */
>  	struct attribute_group	*attr_group;		/* port specific attributes */
> +	bool			attr_group_allocated;	/* whether attr_group is dynamic allocated */

Any way to do this without this variable?

thanks,

greg k-h
