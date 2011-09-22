From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH: tty-next] TTY: serial: Move mutex_unlock in uart_close
 function
Date: Thu, 22 Sep 2011 15:46:28 -0700
Message-ID: <20110922224628.GA21383@kroah.com>
References: <1314600216-8146-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <20110922224330.GA21296@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36396 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab1IVXA7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Sep 2011 19:00:59 -0400
Content-Disposition: inline
In-Reply-To: <20110922224330.GA21296@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de

On Thu, Sep 22, 2011 at 03:43:30PM -0700, Greg KH wrote:
> On Mon, Aug 29, 2011 at 03:43:36PM +0900, Nobuhiro Iwamatsu wrote:
> > When mutex_lock is not called, mutex_unlock is sometimes called.
> > This deletes unnecessary goto and makes modifications so that
> > mutex_unlock is called.
> 
> No you don't, your patch prevents mutex_unlock() from being called:
> 
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1262,7 +1262,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
> >  
> >  	if (tty_hung_up_p(filp)) {
> >  		spin_unlock_irqrestore(&port->lock, flags);
> > -		goto done;
> > +		return;
> 
> Before this mutex_lock() was called, so we need to unlock it, yet you
> just prevented that from happening.
> 
> So this patch is not correct at all, right?

Nevermind, I was looking at the wrong tree, your patch is correct, and
identical to what Jiri sent out after you did, so I'll take your
version, as you got it to me first.

Sorry for the noise and confusion.

greg k-h
