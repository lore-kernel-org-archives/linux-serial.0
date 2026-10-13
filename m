Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECE3AFCE6;
	Tue, 13 Oct 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897402; cv=none; b=Rc/r0Jer0Gfy6a7Rk2heWF6OhTAcyl+g9BDvwIrzYVe5rOqzMfnHwkjTCideRFMI1Ic8N5lmgnnWc+Z/Uch5uE3oxcOi3z5hZHdv7aVWH9PxBtwV1MxTUZCnPwSQPk/iefdXrBnvs2MafGhAmuFCLIQgWxcF7ft4R6c3qHZWHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897402; c=relaxed/simple;
	bh=sM8pKQRt12vbGbmJ5HjLljfoQ7mT0O8+unjbKXyNcvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQk6/I7b+AGkNyR7GtgFQ4D02cf/s2z9bWV8BePc/nIXJpzv7A/7pQB8Lka58DMc4X+da3yrSl7nQ2guC3iid8pSxCrkvWjmsFx1yNyRfflw3EvUqNcXa/lxfV0rMzlKpb8rfbD8G1jUn0v4wkXMudg5u0dLA4VghoKHttp6kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6gtwCGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6gtwCGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C2F1F000FF;
	Tue, 13 Oct 2026 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791897400;
	bh=/V8zHD2+Tt6ku2GF2WunuVhaxFZWu2UDntjhzyS3j5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6gtwCGX2pyuLrsatu/4zpu5TrMYN0jvXrD+PO/uKGY/pWZRkMaqtN1EfoSiY7++n
	 Hh6739oYwYp91JlfJ7mdHrJ8zpJeeoXhbnLiHE1hEOg8AQ3pP2J01A+kBVungS/5zj
	 j7cEGQQWaxgfnr56XEe3VSWKgAL7/2S3i24BCL6M=
Date: Tue, 13 Oct 2026 15:16:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sashiko-reviews@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	John Ogness <john.ogness@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Gerhard Engleder <eg@keba.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Don't clobber the baud rate on
 hangup via B0
Message-ID: <2026101335-broadside-register-8a53@gregkh>
References: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk>
 <alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk>
 <sashiko-outbox-167551@kernel.org>
 <alpine.DEB.2.21.2610121325280.55767@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2610121325280.55767@angie.orcam.me.uk>

On Mon, Oct 12, 2026 at 03:37:01PM +0100, Maciej W. Rozycki wrote:
> On Mon, 12 Oct 2026, sashiko-bot@kernel.org wrote:
> 
> > > @@ -514,10 +514,12 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
> > >  		 * Special case: B0 rate.
> > >  		 */
> > >  		if (baud == 0)
> > > -			return max(min, 9600);
> > > +			return port->hup_speed;
> > 
> > [Severity: High]
> > Does this risk a division by zero panic?
> > 
> > If a new struct uart_port is initialized, port->hup_speed defaults to 0.
> > If a B0 rate is requested before any valid rate is set (such as via
> > console=ttyS0,0 or an early tcsetattr with B0), this returns 0.
> 
>  Yeah, this has glimpsed in my mind and then I lost it.  Indeed we need to 
> keep the fallback 9600/min logic after all for the initial setup.  Easily 
> fixed since it's not in the hot path.
> 
> > >  
> > > -		if (baud >= min && baud <= max)
> > > +		if (baud >= min && baud <= max) {
> > > +			port->hup_speed = baud;
> > 
> > [Severity: Medium]
> > Could this result in a data race on port->hup_speed?
> > 
> > In the standard uart_set_termios() path, uart_get_baud_rate() is called
> > holding only port->mutex and termios_rwsem, not port->lock.
> > 
> > At the same time, atomic console write paths execute asynchronously from
> > hardirq or NMI holding only the nbcon lock. For example:
> > 
> > drivers/tty/serial/8250/8250_port.c:serial8250_console_restore() {
> > 	...
> > 	baud = serial8250_get_baud_rate(port, &termios, NULL);
> > 	...
> > }
> > 
> > This calls into uart_get_baud_rate() without holding port->mutex. A
> > concurrent tcsetattr() and atomic console write can trigger an unprotected
> > data race on port->hup_speed. A torn read or write on this variable could
> > yield a garbage baud rate and lead to hardware misconfiguration.
> 
>  This seems like the only exception across all the serial drivers in the 
> use of uart_get_baud_rate().  Since this is always called to restore the 
> most recent baud rate setting only, perhaps the path of least resistance 
> would be just to refrain from updating port->hup_speed if called with the 
> port lock held?
> 
>  Otherwise it would require rewriting all the 60+ call sites to use the 
> port lock to guard the whole sequence from a call to uart_get_baud_rate() 
> through to the write of the settings obtained to the port registers, which 
> seems an overkill to me and asking for trouble with some odd hardware.
> 
>  I'll experiment with the idea outlined or will be happy with any hints 
> otherwise.

That idea seems sane, thanks for working on this.

greg k-h
