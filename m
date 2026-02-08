Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C23624B1;
	Sun,  8 Feb 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770564526; cv=none; b=E8x8poVCEg+GA8f+J/rZmiAS6cQ26eS7WyfGa5IH70hUJP07l2pyGVJldh5KgZy0yEhCqsz/4Gx+ZyUghjOcQ+TGrRMa3hdq7D35NI1hJCF2oxthyNnAcn3ySFmq2PEL5FmGdPmepCJa3TSM7OHgSORbBlkim7lqrSxFT10FS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770564526; c=relaxed/simple;
	bh=6nduMbQlGeKWsJDfILvozxO6RQQdq0EFYXW3NFBLuyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlHx+baC/bqeQJ95svJ0BmFpJU7IUspB7BOgtq69ZyZi7Pplq6rNHpUP4AfXwaBGGDvgaeOBRLzErUpg1OlAfFVtKKMg6S/kKxQzPoduFs2D0PkCLf7cM2eQ15sy5iHnqKzrkc8GTYoycnILCYePTua5H/To+Pk80zIuwOO8nHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOBpjmUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOBpjmUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB5C4CEF7;
	Sun,  8 Feb 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770564526;
	bh=6nduMbQlGeKWsJDfILvozxO6RQQdq0EFYXW3NFBLuyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOBpjmUWE4zvzmXl4o4rYyT62OUrv3gyp29W2SHQKl5WNRPKNXpeRBytsv0msirQx
	 xzcGB+GX2NYaA9SIKu1ek8MRQsr1+viawbGH/MT35bvnvugTIoK4FJrCNQd8FNeDDG
	 pQsOxbEts3CLa+2ffvawuJCH9+pmpJiw6sYDMI7c=
Date: Sun, 8 Feb 2026 16:28:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sheng Yu <yushenglive@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add CONFIG_SERIAL_8250_PROBE_BAUD option
Message-ID: <2026020829-starch-copilot-8162@gregkh>
References: <20260201043615.524435-1-yushenglive@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201043615.524435-1-yushenglive@gmail.com>

On Sat, Jan 31, 2026 at 08:36:14PM -0800, Sheng Yu wrote:
> Currently, the 8250 driver defaults to 9600 baud if no console options
> are provided via the command line. This can result in garbled output if
> the firmware or bootloader has already initialized the UART to a
> different speed.
> 
> Introduce CONFIG_SERIAL_8250_PROBE_BAUD. When enabled, the driver will
> attempt to read the current baud rate from the hardware registers if
> no options are specified, rather than forcing the 9600 default.
> 
> Signed-off-by: Sheng Yu <yushenglive@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_core.c |  2 +-
>  drivers/tty/serial/8250/8250_port.c |  5 ++++-
>  drivers/tty/serial/8250/Kconfig     | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 0e81f78c6063..c11b19921a1f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -427,7 +427,7 @@ static int univ8250_console_setup(struct console *co, char *options)
>  	/* link port to console */
>  	uart_port_set_cons(port, co);
>  
> -	retval = serial8250_console_setup(port, options, false);
> +	retval = serial8250_console_setup(port, options, IS_ENABLED(CONFIG_SERIAL_8250_PROBE_BAUD));
>  	if (retval != 0)
>  		uart_port_set_cons(port, NULL);
>  	return retval;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 719faf92aa8a..5309b921e7b7 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3399,8 +3399,11 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>  
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> -	else if (probe)
> +	else if (probe) {
>  		baud = probe_baud(port);
> +		pr_info("console [%s%d] probed baud rate: %d\n",
> +			port->cons->name, port->cons->index, baud);
> +	}
>  
>  	ret = uart_set_options(port, port->cons, baud, parity, bits, flow);
>  	if (ret)
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index c488ff6f2865..bee6a82023d4 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -596,3 +596,15 @@ config SERIAL_OF_PLATFORM
>  	  are probed through devicetree, including Open Firmware based
>  	  PowerPC systems and embedded systems on architectures using the
>  	  flattened device tree format.
> +
> +config SERIAL_8250_PROBE_BAUD
> +	bool "Probe baud rate if console options are missing"
> +	depends on SERIAL_8250
> +	help
> +	  If the "console=" command line parameter is missing options (e.g.,
> +	  "console=ttyS0" instead of "console=ttyS0,115200n8"), this option
> +	  allows the kernel to probe the baud rate from hardware instead of
> +	  defaulting to 9600.
> +
> +	  If a baud rate is explicitly provided in the options, that value
> +	  is always respected.
> -- 
> 2.51.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
