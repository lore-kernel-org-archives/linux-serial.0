Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808122F4A0C;
	Mon, 11 May 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512620; cv=none; b=T1dzouyDtGdRXzRkp7Df+Aljbb095eioTnoitjC0i227yQicO3SL2MTBbtaeJv3HqvbmHgp88kpxLsmuHbM6EpMKxHt3OkOuJyYJi22ZSO2LYG6nSvwpheH2olNi//6WsPdzKjFkbj8IpALdzmjbiUPDbEDrI1dG4h632C7WTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512620; c=relaxed/simple;
	bh=CaFqo1mJDBQL7AoMt05poKoJBXGk8H75kqLKzcS2A4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9rp1TMqv0XVprAy+SVg782AIXo4/LZIIPwfKGehoI8jpNHlIdSdrwV7h3C/Dp64W/bNWK7yIUMsx1hlOcPk1VBeVU3ouslnAMxZuW3HOHMCMJHbSsaAPrrKwpsAmmVyzr5d4xb4YVgYnK14MvXV8jZLlyouhcnZm/CKWn0+OrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDN5ufPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDN5ufPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61786C2BCB0;
	Mon, 11 May 2026 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778512619;
	bh=CaFqo1mJDBQL7AoMt05poKoJBXGk8H75kqLKzcS2A4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDN5ufPRDrIyf6eqWtXAvziT70qwfc0swPet+EF6dam3Yng5rp1Ldw0DLgNPQ6j71
	 NRc4nfd0v+KfjfUR1XS7xVDomdtCiZy1SoUwMGNXJmAWDB7VK7bIDyrkcXvZrca5Oi
	 MMNvHuoYuIQNMCy65qFt0P/01Dbl4Q8CJUy+aUTA=
Date: Mon, 11 May 2026 17:16:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	osama.abdelkader@gmail.com, andy.shevchenko@gmail.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2] serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration
Message-ID: <2026051135-kung-badass-8eba@gregkh>
References: <20260428090349.30047-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090349.30047-1-fushuai.wang@linux.dev>

On Tue, Apr 28, 2026 at 05:03:49PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When two PnP devices map to the same physical port, the serial8250 driver
> removes and re-registers the console structure for the same port.
> 
> During re-registration, the console structure still has CON_PRINTBUFFER set
> from the initial registration, which causes console_init_seq() to set
> console->seq to syslog_seq. This results in re-printing the entire
> system log buffer, which may lead to RCU stall on slow serial consoles.
> 
> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> log printing.
> 
> Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> V1->V2: Add Fixes tag
> previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u
> 
> Please ignore previous email if you received it before. There is something wrong with my email client.
> 
>  drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb..01b14392d9f7 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  {
>  	struct uart_8250_port *uart;
>  	int ret;
> +	bool was_removed = false;
>  
>  	if (up->port.uartclk == 0)
>  		return -EINVAL;
> @@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	if (uart->port.type == PORT_8250_CIR)
>  		return -ENODEV;
>  
> -	if (uart->port.dev)
> +	if (uart->port.dev) {
>  		uart_remove_one_port(&serial8250_reg, &uart->port);
> +		was_removed = true;
> +	}
>  
>  	uart->port.ctrl_id	= up->port.ctrl_id;
>  	uart->port.port_id	= up->port.port_id;
> @@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  					&uart->capabilities);
>  
>  		serial8250_apply_quirks(uart);
> +
> +		if (was_removed && uart_console(&uart->port))
> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;

Why not set the flag up above when you remove the port?  Why down here?

thanks,

greg k-h
