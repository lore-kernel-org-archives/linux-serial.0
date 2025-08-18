Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2220766E
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511369; cv=none; b=FpSSPckpwcpQslnI1Wh0HbPJa2eATNloFSOatRO98Gn05xHHUb1Xu7UjwNZ1wl3+CTbrT6t0tci6v97/ONsfSpg5bYCJ4+BHLH7stmnGUJVoBWRKGsKMFVxPaqmHfZYWU7PO89xCoTN3kk3qobkoQ3MtOcYqpbJlI6mEAsW0hG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511369; c=relaxed/simple;
	bh=6xKDXpd2ox374fTFrWQlJUJLEuaP9tPVwOb0Tfwi/Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rElyY8m27rsdTAejYLSIGu3nAMwm8Wsz4ejmkk8ewh0nk1F1tLI97YmXeQrAyNJi2wbiEph/AGEgxPt9ow7C5rpeXFYJEFnVxS7m3MdQxiSOo9+Zz3Hao2nU79i2tzkrnAx/Jq4B1+ZA7Fp71h4wMjS2UCPzEq8rZs5MlxBN+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEX+jXbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEX+jXbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C0C4CEEB;
	Mon, 18 Aug 2025 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511369;
	bh=6xKDXpd2ox374fTFrWQlJUJLEuaP9tPVwOb0Tfwi/Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEX+jXbIK633aCleqER9pBYV/XofKa1PCtmMge4MXVjmi02F5VZKxMZwR6D7tnwkN
	 sjO7B6BSCI1R9gIPivofkn1gDNxWo9yq6B67K+zVRazrS6V4PgkiXxmRUg4YKE+CCu
	 t7okQ6BSm2b922zGxyzIucF4i7v+0k5nO2y6dMpU=
Date: Mon, 18 Aug 2025 12:02:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Michal Simek <michal.simek@amd.com>, linux-serial@vger.kernel.org,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Message-ID: <2025081804-bruising-garage-a57b@gregkh>
References: <20250818095216.795550-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818095216.795550-1-martin.kaistra@linutronix.de>

On Mon, Aug 18, 2025 at 11:52:16AM +0200, Martin Kaistra wrote:
> After all bytes to be transmitted have been written to the FIFO
> register, the hardware might still be busy actually sending them.
> 
> Thus, wait for the TX FIFO to be empty before starting the timer for the
> RTS after send delay.
> 
> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
> I tried using the TX empty interrupt instead of polling the register,
> but it doesn't seem to be firing reliably, which is why I chose this
> implementation instead.
> 
>  drivers/tty/serial/xilinx_uartps.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index fe457bf1e15bb..38d2b33d0b6c8 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -454,6 +454,10 @@ static void cdns_uart_handle_tx(void *dev_id)
>  
>  	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
>  	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
> +		/* Wait for the tx fifo to be actually empty */
> +		while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
> +			udelay(1);

Having a while look that could potentially never exit?  What could go
wrong...

Seriously, what happens if the port never empties due to flow control
stuff?

thanks,

greg k-h
