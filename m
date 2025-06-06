Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A0284689;
	Fri,  6 Jun 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206472; cv=none; b=H0mYAL1gKXjw0clEFgpOvH7ufKDlmpuU/KsvRIE+IsZqJOvMGmVbUO/rbllfieiiLSEoodBK8kM18pwkx1zbDrulMSH7e8MAgBL/AO9WzqyHSB2FhPBPVdoXrQ5j4Cb6JszuWa8/DsR58ySQhxshxi0oy567XpRefNPMH/0isU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206472; c=relaxed/simple;
	bh=1RAJDfmY+lnaXEvqMTdbBLC/C9yMjAtki0kirkAjUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8iBUJEk1gQmCQm0Yk06HYPsOw7wVLAFV6zWPx9fHJeRpZoRzq0Z0ZECxVQCKd3vwOlchzne/YfXh+s9/apygN72r3rXKz0OYUvnxNWNKZjoZ4PtAso7EUe+ZKCGZZ2Gjx7ax0CPFcms3Ejb1rysAmzRbkYA28f7wZE3xlimwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peLdSwy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peLdSwy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EEEC4CEF1;
	Fri,  6 Jun 2025 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749206472;
	bh=1RAJDfmY+lnaXEvqMTdbBLC/C9yMjAtki0kirkAjUxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peLdSwy7fJQdXOeMxrAFU3BAJG7QZRkfdVx0hSNDBwfu8WQlCsAxQy5D1+ZFFm2mm
	 gyUKLHu2IkAPqt+SpRshb8Ytp+7fINvHQ2TMOH/C6DsArXlR8mxrh3TEMSZdNy7FFR
	 tGWHRWeCMUxqeF+imif1ruWHeB4wNFUXmbTvh9YI=
Date: Fri, 6 Jun 2025 12:41:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu, heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	markus.mayer@linaro.org, matt.porter@linaro.org,
	namcao@linutronix.de, paulmck@kernel.org, pmladek@suse.com,
	schnelle@linux.ibm.com, sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: Re: [PATCH v7 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Message-ID: <2025060659-reason-renewal-bff9@gregkh>
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
 <20250528062609.25104-4-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528062609.25104-4-cuiyunhui@bytedance.com>

On Wed, May 28, 2025 at 02:26:09PM +0800, Yunhui Cui wrote:
> The DW UART may trigger the RX_TIMEOUT interrupt without data
> present and remain stuck in this state indefinitely. The
> dw8250_handle_irq() function detects this condition by checking
> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
> detected, it performs a "dummy read" to recover the DW UART from
> this state.
> 
> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
> while the FIFO is enabled and UART_LSR_DR is not set will generate a
> PSLVERR error, which may lead to a system panic. There are two methods
> to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
> UART_RX when the FIFO is enabled, and the other is to read UART_RX when
> the FIFO is disabled.
> 
> Given these two scenarios, the FIFO must be disabled before the
> "dummy read" operation and re-enabled afterward to maintain normal
> UART functionality.
> 
> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 8b0018fadccea..686f9117a3339 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -301,9 +301,17 @@ static int dw8250_handle_irq(struct uart_port *p)
>  		uart_port_lock_irqsave(p, &flags);
>  		status = serial_lsr_in(up);
>  
> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> +			/* To avoid PSLVERR, disable the FIFO first. */
> +			if (up->fcr & UART_FCR_ENABLE_FIFO)
> +				serial_out(up, UART_FCR, 0);
> +
>  			serial_port_in(p, UART_RX);
>  
> +			if (up->fcr & UART_FCR_ENABLE_FIFO)
> +				serial_out(up, UART_FCR, up->fcr);
> +		}
> +
>  		uart_port_unlock_irqrestore(p, flags);
>  	}
>  
> -- 
> 2.39.5
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
