Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F14908B9;
	Mon, 12 Oct 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815828; cv=none; b=WQnasRJOlqSshoMHc/FhUqPI++9iqoO4FQiBI8T4sAyaEJ03gQxoZu6TiDK4cDhZabjMC/XMhX2C73EcYZM+SHUP1uAg04r3sS4Ad0SUumlWGCLzW/TnK6+LasiN9MtVD8qZ6qs6+88R+e3U810Sg5SPhOpG1+DHffxR1JY6qA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815828; c=relaxed/simple;
	bh=bAAr7Hex5s8qzqHsZGd/mU74yHKFKF82kjf2B7R9+ig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BaMhp4L0PfuC0ocQ3vnMkjANUiEH7xRsbIGXaFS4vv+pNPOgyWC9zJg0FXpsimT0T+SIlah41AHBhv7e0Ob2zK8S3t6ASmVfnrb0ZfIbJxU6E8l7fPx5D9JSoo7338GzylJGwum6j0iRFZVn6MH57Jik/09nhqbUWiqDph469y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DB23192009D; Mon, 12 Oct 2026 16:37:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D81CE92009C;
	Mon, 12 Oct 2026 15:37:01 +0100 (BST)
Date: Mon, 12 Oct 2026 15:37:01 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: sashiko-reviews@lists.linux.dev
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, 
    Lukas Wunner <lukas@wunner.de>, John Ogness <john.ogness@linutronix.de>, 
    Jiayuan Chen <jiayuan.chen@shopee.com>, Gerhard Engleder <eg@keba.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Don't clobber the baud rate on
 hangup via B0
In-Reply-To: <sashiko-outbox-167551@kernel.org>
Message-ID: <alpine.DEB.2.21.2610121325280.55767@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk> <alpine.DEB.2.21.2610120231550.55767@angie.orcam.me.uk> <sashiko-outbox-167551@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Oct 2026, sashiko-bot@kernel.org wrote:

> > @@ -514,10 +514,12 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
> >  		 * Special case: B0 rate.
> >  		 */
> >  		if (baud == 0)
> > -			return max(min, 9600);
> > +			return port->hup_speed;
> 
> [Severity: High]
> Does this risk a division by zero panic?
> 
> If a new struct uart_port is initialized, port->hup_speed defaults to 0.
> If a B0 rate is requested before any valid rate is set (such as via
> console=ttyS0,0 or an early tcsetattr with B0), this returns 0.

 Yeah, this has glimpsed in my mind and then I lost it.  Indeed we need to 
keep the fallback 9600/min logic after all for the initial setup.  Easily 
fixed since it's not in the hot path.

> >  
> > -		if (baud >= min && baud <= max)
> > +		if (baud >= min && baud <= max) {
> > +			port->hup_speed = baud;
> 
> [Severity: Medium]
> Could this result in a data race on port->hup_speed?
> 
> In the standard uart_set_termios() path, uart_get_baud_rate() is called
> holding only port->mutex and termios_rwsem, not port->lock.
> 
> At the same time, atomic console write paths execute asynchronously from
> hardirq or NMI holding only the nbcon lock. For example:
> 
> drivers/tty/serial/8250/8250_port.c:serial8250_console_restore() {
> 	...
> 	baud = serial8250_get_baud_rate(port, &termios, NULL);
> 	...
> }
> 
> This calls into uart_get_baud_rate() without holding port->mutex. A
> concurrent tcsetattr() and atomic console write can trigger an unprotected
> data race on port->hup_speed. A torn read or write on this variable could
> yield a garbage baud rate and lead to hardware misconfiguration.

 This seems like the only exception across all the serial drivers in the 
use of uart_get_baud_rate().  Since this is always called to restore the 
most recent baud rate setting only, perhaps the path of least resistance 
would be just to refrain from updating port->hup_speed if called with the 
port lock held?

 Otherwise it would require rewriting all the 60+ call sites to use the 
port lock to guard the whole sequence from a call to uart_get_baud_rate() 
through to the write of the settings obtained to the port registers, which 
seems an overkill to me and asking for trouble with some odd hardware.

 I'll experiment with the idea outlined or will be happy with any hints 
otherwise.

  Maciej
