Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C239A7F7;
	Wed,  4 Feb 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195238; cv=none; b=RlhWE669WxEzqp8C9ngy18uoyWA+/MOPGu93N84/Q0BSnAz5uBNa0YEIjDrhvOSyA+tjDlv2BJyonh/xzl8J49i7zjD8lQ32val40yunJKjOlsioTQA9yRlFyQdJfSMN1yN6u4XLnyAaInnLsfek1tIyrIpgLYSEHWvy2EeZcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195238; c=relaxed/simple;
	bh=Lxo10RhwD702pBNxQwOtsmJ6u7anSv8AgR4ob1XGMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNpPxjONtHkgv9KbLI9UzNuQCf/r2tDXcEAQzLQIYG8+4Gd//uY6+tXF8X4psQhi8dtcAIdj9biq4+zsLtnR6jixUsXz6NTT6LAQxenNpbP/5EwgWsmNQMlrTTdoP/M4kMuEMxj+bYfqIn78tVm4UiQ8dJJ3Gc42XwdSandjprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YS3tXd3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YS3tXd3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D27CC4CEF7;
	Wed,  4 Feb 2026 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770195238;
	bh=Lxo10RhwD702pBNxQwOtsmJ6u7anSv8AgR4ob1XGMko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YS3tXd3EOUaOOaGybEGXunt+zmU3xN5tO7EGLDMB3xsXKgHmtWrEbuDpMhQsDCC2M
	 iw83eIERUFbQq1Qdggl5uumXMZ9EFx8LYawIIiRJ55sInjc9WKLfSkoejlASCRNn6J
	 iKauFrPs6NZv6C5ULdEQnPDftwBXyUmrddOm0JKY=
Date: Wed, 4 Feb 2026 09:53:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-serial@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] serial: core: fix infinite loop in handle_tx() for
 PORT_UNKNOWN
Message-ID: <2026020453-corrode-lecturer-9b36@gregkh>
References: <20260204074327.226165-1-jiayuan.chen@linux.dev>
 <2026020459-lisp-display-0506@gregkh>
 <fa7e9e86df95ffcc301c60367654e084cbff5d83@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa7e9e86df95ffcc301c60367654e084cbff5d83@linux.dev>

On Wed, Feb 04, 2026 at 08:29:06AM +0000, Jiayuan Chen wrote:
> 2026/2/4 16:20, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org mailto:gregkh@linuxfoundation.org?to=%22Greg%20Kroah-Hartman%22%20%3Cgregkh%40linuxfoundation.org%3E > wrote:
> 
> 
> > 
> > On Wed, Feb 04, 2026 at 03:43:20PM +0800, Jiayuan Chen wrote:
> > 
> > > 
> > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >  
> > >  uart_write_room() and uart_write() behave inconsistently when
> > >  xmit_buf is NULL (which happens for PORT_UNKNOWN ports that were
> > >  never properly initialized):
> > > 
> > How does this happen? Why were they not initialized properly, what
> > drivers/hardware cause this?
> 
> 
>   In QEMU environment, /dev/ttyS3 is PORT_UNKNOWN type (no real UART hardware).
>   When uart_port_startup() sees uport->type == PORT_UNKNOWN, it returns early
>   without allocating xmit_buf:
>       if (uport->type == PORT_UNKNOWN)
>           return 1;   // xmit_buf never allocated
>   So xmit_buf remains NULL.

But the flags for the port will have TTY_IO_ERROR set on it, which
should hopefully mean that no data is attempted to be sent through this
(or a ldisc would be bound to it.)

How does this port work at all?  Why is QEMU advertising a broken port
that can not do anything?

And is this the only place such a check would ever be needed?  What
changed recently to suddenly require this?

> > > 
> > > - uart_write_room() returns kfifo_avail() which can be > 0
> > >  - uart_write() checks xmit_buf and returns 0 if NULL
> > >  
> > >  This inconsistency causes an infinite loop in drivers that rely on
> > >  tty_write_room() to determine if they can write:
> > >  
> > >  while (tty_write_room(tty) > 0) {
> > >  written = tty->ops->write(...);
> > >  // written is always 0, loop never exits
> > >  }
> > >  
> > >  For example, caif_serial's handle_tx() enters an infinite loop when
> > >  used with PORT_UNKNOWN serial ports, causing system hangs.
> > >  
> > >  Fix by making uart_write_room() also check xmit_buf and return 0 if
> > >  it's NULL, consistent with uart_write().
> > >  
> > >  Reproducer: https://gist.github.com/mrpre/d9a694cc0e19828ee3bc3b37983fde13
> > >  
> > >  Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> > > 
> > This really isn't a fix for that driver, but rather something else.
> 
>   You're right, this is awkward. The API inconsistency between uart_write_room()
>   and uart_write() has existed since 2.6.12, but it only became visible as a
>   deadloop when CAIF was introduced - because CAIF's handle_tx() relies on
>   tty_write_room() to decide whether to call write().
>   The fix location is in uart, but the trigger condition requires CAIF (or
>   similar drivers). I can remove the Fixes tag if you prefer.

Ok, I think this goes a bit deeper.  This might be due to the kfifo
rewrite of the serial drivers, as in older kernels we did not have a
kfifo, so if it was not initialized the code checking path is much
different.

As a "check" can you see if this fails for you on the latest 5.10.y
tree?  That is before the kfifo code was added to the uart layer.

> > > ---
> > >  drivers/tty/serial/serial_core.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >  
> > >  diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > >  index 2805cad10511..0b2edf185cc7 100644
> > >  --- a/drivers/tty/serial/serial_core.c
> > >  +++ b/drivers/tty/serial/serial_core.c
> > >  @@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tty_struct *tty)
> > >  unsigned int ret;
> > >  
> > >  port = uart_port_ref_lock(state, &flags);
> > >  - ret = kfifo_avail(&state->port.xmit_fifo);
> > >  + if (!state->port.xmit_buf)
> > > 
> > This feels odd. What ports have no transmit buffers? And why would
> > this be the only check that is needed for such broken devices?
> > 
> > Maybe let's fix the root cause here, the driver that does not have a
> > transmit buffer at all?
> 
> 
>   Do you suggest we should prevent setting line discipline (like N_CAIF)
>   on PORT_UNKNOWN ports? Or should CAIF check the port type before using it?
>   Note that CAIF is currently in orphan status (no active maintainer), so
>   I'm not sure about the process for modifying it. The serial core fix
>   might be more straightforward.

I think you found a real bug here, that is independent of the caif code,
and might just be due to the kfifo stuff.  See above for my questions
here, and if so, your patch is correct, it's just that the Fixes: tag is
a bit off.

thanks,

greg k-h
