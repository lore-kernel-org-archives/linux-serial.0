Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02E20FABB;
	Fri, 10 Jan 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520863; cv=none; b=gGTWX4/uE6G07VCk+Lx0aQFGLCPWfSyJvKzyYEJIwBLhPzH9j4ROAdNoFS7ZUnSNJKlVXyarEWE4hy7vZ8RMJd9uyqCekhumYvqvr/ozkqd3BwUc4AGjtQ8ADet7kc2zuM1DleReyM0A44bAqGLpKIzib+eDIlYvRfYkSb17Ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520863; c=relaxed/simple;
	bh=lUzSCn1AX4r6Yodul88XZtMxwiaf8Z9eTarKJqacgVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEB1TVoZvNR/YNTwCq7YgQiKcHgZYdCjxl20tt/B0pNbRH0kCZhAIwUH8Ml0gjxAEM+/rkKAlRonNnfi+MkZADBi6+vgaGttcgn8tyvMPSLFOwQ5mRop+VOq92crLAOORx1trB7pRIBez7r1t4ALVJHFm4rWrFTxqBiL4jnl8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0pxdOzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0pxdOzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4779DC4CED6;
	Fri, 10 Jan 2025 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736520862;
	bh=lUzSCn1AX4r6Yodul88XZtMxwiaf8Z9eTarKJqacgVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0pxdOzSVH5CdvyZargE+BVCNBJdPGCmCGBLxTGveYLMcnFm/304SbTNmUDDqZ0Wt
	 82PgzbuopSXdKSI+g/ENH5BO7ZDMVwyKxt0YMRKUMXU5rhZskO64YoFW60cEenME3f
	 qqEts4DILAuhR6df6ZRk4V5euDbWyBvfkL4pAnF4=
Date: Fri, 10 Jan 2025 15:54:19 +0100
From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] serial: amba-pl011: Implement nbcon console
Message-ID: <2025011031-lying-spirits-e326@gregkh>
References: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>
 <2025010845-deceiver-imaginary-ea04@gregkh>
 <TY4PR01MB137779148D6C8C537E7108071D7132@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY4PR01MB137779148D6C8C537E7108071D7132@TY4PR01MB13777.jpnprd01.prod.outlook.com>

On Thu, Jan 09, 2025 at 01:04:36AM +0000, Toshiyuki Sato (Fujitsu) wrote:
> Hi, Greg. Thanks for the comment.
> 
> > On Wed, Jan 08, 2025 at 12:47:30AM +0000, Toshiyuki Sato wrote:
> > > Implement the callbacks required for an NBCON console [0] on the
> > > amba-pl011 console driver.
> > > The codes for legacy console are retained, and the module
> > > parameter (use_nbcon) allows switching between legacy and NBCON.
> > > The default is off (use legacy console) for now.
> > >
> > > Referred to the NBCON implementation work for 8250 [1] and imx [2].
> > >
> > > The normal-priority write_thread checks for console ownership
> > > each time a character is printed.
> > > write_atomic holds the console ownership until the entire string
> > > is printed.
> > >
> > > UART register operations are protected from other contexts by
> > > uart_port_lock, except for a final flush(nbcon_atomic_flush_unsafe)
> > > on panic.
> > >
> > > The patch has been verified to correctly handle the output and
> > > competition of messages with different priorities and flushing
> > > panic message to console after nmi panic using ARM64 QEMU and
> > > a physical machine(A64FX).
> > >
> > > [0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
> > > [1]
> > https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutronix.d
> > e/T/
> > > [2]
> > https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4c62
> > 7302335b@geanix.com/T/
> > >
> > > Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
> > > ---
> > >  drivers/tty/serial/amba-pl011.c | 113
> > ++++++++++++++++++++++++++++++++
> > >  1 file changed, 113 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > > index 69b7a3e1e..52fab3170 100644
> > > --- a/drivers/tty/serial/amba-pl011.c
> > > +++ b/drivers/tty/serial/amba-pl011.c
> > > @@ -41,6 +41,7 @@
> > >  #include <linux/sizes.h>
> > >  #include <linux/io.h>
> > >  #include <linux/acpi.h>
> > > +#include <linux/moduleparam.h>
> > >
> > >  #define UART_NR			14
> > >
> > > @@ -263,6 +264,7 @@ struct uart_amba_port {
> > >  	char			type[12];
> > >  	bool			rs485_tx_started;
> > >  	unsigned int		rs485_tx_drain_interval; /* usecs */
> > > +	bool			console_line_ended;
> > >  #ifdef CONFIG_DMA_ENGINE
> > >  	/* DMA stuff */
> > >  	unsigned int		dmacr;		/* dma control reg */
> > > @@ -274,6 +276,10 @@ struct uart_amba_port {
> > >  #endif
> > >  };
> > >
> > > +/* if non-zero, the console is nbcon. */
> > > +static int use_nbcon;
> > > +module_param(use_nbcon, int, 0444);
> > 
> > Why is a module parameter needed here?  That feels wrong and not
> > scalable at all.  What happens if you have multiple devices, which one
> > is nbcon and which isn't?
> 
> This module parameter is for pl011 driver.

Yes, and module parameters are from the 1990's, let's not add new ones
please.

> With this patch implemented, only one type will be usable, depending
> on the value of use_nbcon.
> I thought it would be more user-friendly if legacy operation could be
> selected via boot parameter.
> Would it be better to make the patch purely nbcon-compatible, without
> retaining the legacy functionality?

Why would you want the "legacy" functionality?  Aren't we converting all
consoles over to use the new stuff?

thanks,

greg k-h
