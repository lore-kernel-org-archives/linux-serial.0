Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2A3BFAD1;
	Fri, 22 May 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443055; cv=none; b=NEp/tOpzQcCPGFGTyRnoSdT+eS2ku/R4ZZbcCDYLH9lMgLh0gjhp8iU56IAtg4g4TqbY7hNoYGHH5bUjgH4HjEut56DJNVWe8Fhytk8CO62sofmduEk7W7T0DCZNFVXoKCskayUtVs2B9sq2yTzr+pyuCtpDS0o7Qmy19fFYSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443055; c=relaxed/simple;
	bh=HziK/CRBvkgvklsghrYBC1OwJ7y5IDzCcZ948rlZCW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p13WwkqA6Qu8AaH0OwuIqmXWDnir/PliQMBTQxjZTZi/u2DVbDKhAetqfUPJcSGxQn1RF5wsJYizO2o6d5PH7IQ7fEjAwS29NryiX8Yjq/QawShG/oaGjIjVgmOVL/XmKDv6j7AKl9WX4WEcQWtUA8mKGGDH2zs2CoA3p3vcqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZIqFDME3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIqFDME3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E0F1F000E9;
	Fri, 22 May 2026 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779443053;
	bh=LtPZnfH6GrflENUYwQ5lSGp6QyOsbmKjWEzaxQVC1Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZIqFDME3ddyW7cPLgC8QrQu28sPZeeo4zJWJXY4pI6Cnum4glvqyQ4vi2XU7DLL9j
	 zqI4piV8xwISXNXP2E/AFDDfxvhteQfOwCkA4/yJA5l1QyQGNXwjEQmbmAPCaJX1iG
	 6AGmox4jWzPqQRKTUQO1rNAOzZ0w7Ym6+7IQd4a4=
Date: Fri, 22 May 2026 11:44:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: andy.shevchenko@gmail.com, ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, osama.abdelkader@gmail.com,
	wangfushuai@baidu.com
Subject: Re: [PATCH v2] serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration
Message-ID: <2026052203-glutinous-smudge-91ab@gregkh>
References: <2026051135-kung-badass-8eba@gregkh>
 <20260515074402.98048-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515074402.98048-1-fushuai.wang@linux.dev>

On Fri, May 15, 2026 at 03:44:02PM +0800, Fushuai Wang wrote:
> >> From: Fushuai Wang <wangfushuai@baidu.com>
> >> 
> >> When two PnP devices map to the same physical port, the serial8250 driver
> >> removes and re-registers the console structure for the same port.
> >> 
> >> During re-registration, the console structure still has CON_PRINTBUFFER set
> >> from the initial registration, which causes console_init_seq() to set
> >> console->seq to syslog_seq. This results in re-printing the entire
> >> system log buffer, which may lead to RCU stall on slow serial consoles.
> >> 
> >> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> >> log printing.
> >> 
> >> Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> >> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> >> ---
> >> V1->V2: Add Fixes tag
> >> previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u
> >> 
> >> Please ignore previous email if you received it before. There is something wrong with my email client.
> >> 
> >>  drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> index a428e88938eb..01b14392d9f7 100644
> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> @@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
> >>  {
> >>  	struct uart_8250_port *uart;
> >>  	int ret;
> >> +	bool was_removed = false;
> >>  
> >>  	if (up->port.uartclk == 0)
> >>  		return -EINVAL;
> >> @@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
> >>  	if (uart->port.type == PORT_8250_CIR)
> >>  		return -ENODEV;
> >>  
> >> -	if (uart->port.dev)
> >> +	if (uart->port.dev) {
> >>  		uart_remove_one_port(&serial8250_reg, &uart->port);
> >> +		was_removed = true;
> >> +	}
> >>  
> >>  	uart->port.ctrl_id	= up->port.ctrl_id;
> >>  	uart->port.port_id	= up->port.port_id;
> >> @@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
> >>  					&uart->capabilities);
> >>  
> >>  		serial8250_apply_quirks(uart);
> >> +
> >> +		if (was_removed && uart_console(&uart->port))
> >> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;
> > 
> > Why not set the flag up above when you remove the port?  Why down here?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi, Greg
> 
> I just felt it's cleaner to clear it only when re-registration happens.
> Do you think there is any problem with doing it right after the removal?

If you do that, no flag is needed.
