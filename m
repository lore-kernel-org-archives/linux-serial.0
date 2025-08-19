Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECF3112D7
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600553; cv=none; b=dOFQQ4EVF3DujsAyzr9wUS8t2IIaD9I69rOF0CCvYtvjGDlT9iIcFuUCZgJuEgJyH2PlcuTr5Es5QzT140aGW5zedxqQVy2rwNddCGTa02EDpVHyW8TxcU1PNfPMNJA6Esrvni2RKz7x7/gaWmAjJDv1z1Gb2PMUBpnYiB6n9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600553; c=relaxed/simple;
	bh=Ptv/nEe9zz/nK3TvEw8Wux/lx018QB/nbliKYpLQUs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2A6Q6kw4ykFehVkJ3K0FNitqnkGMYlspZ/o15Dme8/yPBgo4eo0FXxv6yQq9pfTby4eaZz1s7tQwQSTZkZCL0Tyx/4nhl52nZMU0L0IYwS914U9WuTZ906eYLmL5mXAJUTY/pTHXswatu8G5SMkg49agZ6/2SjgNmEmo0XuWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8BmJvzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8BmJvzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBB7C4CEF1;
	Tue, 19 Aug 2025 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755600552;
	bh=Ptv/nEe9zz/nK3TvEw8Wux/lx018QB/nbliKYpLQUs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8BmJvzca5C6oOp2ny9nTWDYwhA8B7ncqj6QTV6MdCQtCXgWdZzazMkFsK/mgkVbl
	 eIsCz4/uTZ/65i8O+AcHF6f0ecieL9KAKwfmmD5ROhcdC96Rez66qzLfVoH6tFa4Vk
	 PVNzOoFw983L02u5DHr0L3FDq/me0G8MzJAMdvRs=
Date: Tue, 19 Aug 2025 12:49:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Michal Simek <michal.simek@amd.com>, linux-serial@vger.kernel.org,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Message-ID: <2025081955-debatable-registrar-3c23@gregkh>
References: <20250818095216.795550-1-martin.kaistra@linutronix.de>
 <2025081804-bruising-garage-a57b@gregkh>
 <7a33100a-24bd-4bed-b9b2-539fc5a15c2c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a33100a-24bd-4bed-b9b2-539fc5a15c2c@linutronix.de>

On Mon, Aug 18, 2025 at 02:00:02PM +0200, Martin Kaistra wrote:
> Am 18.08.25 um 12:02 schrieb Greg Kroah-Hartman:
> > On Mon, Aug 18, 2025 at 11:52:16AM +0200, Martin Kaistra wrote:
> > > After all bytes to be transmitted have been written to the FIFO
> > > register, the hardware might still be busy actually sending them.
> > > 
> > > Thus, wait for the TX FIFO to be empty before starting the timer for the
> > > RTS after send delay.
> > > 
> > > Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
> > > Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> > > ---
> > > I tried using the TX empty interrupt instead of polling the register,
> > > but it doesn't seem to be firing reliably, which is why I chose this
> > > implementation instead.
> > > 
> > >   drivers/tty/serial/xilinx_uartps.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > > index fe457bf1e15bb..38d2b33d0b6c8 100644
> > > --- a/drivers/tty/serial/xilinx_uartps.c
> > > +++ b/drivers/tty/serial/xilinx_uartps.c
> > > @@ -454,6 +454,10 @@ static void cdns_uart_handle_tx(void *dev_id)
> > >   	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
> > >   	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
> > > +		/* Wait for the tx fifo to be actually empty */
> > > +		while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
> > > +			udelay(1);
> > 
> > Having a while look that could potentially never exit?  What could go
> > wrong...
> > 
> > Seriously, what happens if the port never empties due to flow control
> > stuff?
> 
> I will add a timeout..
> 
> Before sending a v2, however, can I ask: will a solution with udelay() even
> be accepted?

Probably not, would you want that called when waiting like this?
