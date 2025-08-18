Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE94317709
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511326; cv=none; b=j6c7vKsolxZL85l4GeIW1+K1ND/fMO43NKse54zqYOsKX0ScAFtNfd5ZJN2y+EmVzbEcwFjY64bMAAcjpO4Yut7lAaZ34BlzhVknsSmcob4CTPOsJCxg1OmvAeGEx9B/itLRAjFXOF1MHkcUCRNR+VzVhp+Orq7Vdh3d0NjYteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511326; c=relaxed/simple;
	bh=/BOPbMD1Ke1Uklj2oIk0Mzjbid7slIU6XzVxXO2LGRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8ReVHNvRHGcN6M+CL58b9mJ51yIBdSwv+AR1fS9bJEEqFS6Kcf2e9lHmtVnFvUyutLKcGifdR/7pJ1LlMP+lXqf4Ez8OQTATPD04W/TfHv3NNKxsfZ2X/QFBE76Wg5aRPuFd6I9rc9YgxNKC2sbGMqbLrJsHhTukI3qxwnEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JH8ZYdsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JH8ZYdsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0103C4CEEB;
	Mon, 18 Aug 2025 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511326;
	bh=/BOPbMD1Ke1Uklj2oIk0Mzjbid7slIU6XzVxXO2LGRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JH8ZYdsU7+T6B4H3YbYL1IlixZqZ0cgsS8LzZJCH7E8kwpYcSbVunIbtP+d6FR6hQ
	 5wdWYNOoMqWJqUhdWgyhuZbhfWaoGdRTTDAchIVTUNQmPwwjJ6ly0hPq+Ia8LgAgYX
	 htEsDdumn/gfrjHAxUTm9c+2mjNq9yVQQkbu6icg=
Date: Mon, 18 Aug 2025 12:02:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Michal Simek <michal.simek@amd.com>, linux-serial@vger.kernel.org,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Message-ID: <2025081850-washer-outmatch-3037@gregkh>
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
> +
>  		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
>  		hrtimer_start(&cdns_uart->tx_timer,
>  			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
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
