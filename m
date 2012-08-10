From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Q: how to control the TTY output queue in real time?
Date: Fri, 10 Aug 2012 20:33:55 +0100
Message-ID: <20120810203355.224622cc@pyramind.ukuu.org.uk>
References: <50255E31.8060904@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50255E31.8060904@list.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Stas Sergeev <stsp@list.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> I am writing an app that needs to control the
> serial xmit in real-time. What I need is a notification
> that the TTY output queue fillup (returned by TIOCOUTQ
> ioctl) have dropped below the specified value.

Not a supported feature basically.

> I haven't found anything that can help implementing
> this. If I can't get an async notification, the sync
> notification will do too, like, for instance, the tcdrain()
> call, but with the argument to specify the needed fillup,
> below which the function will return.
> If there is nothing like this, then even the notification
> on every transmitted char will do.
> But I've found nothing of the above. :(
> 
> Any suggestions how the real-time control can be
> implemented?

Bascially even on the hardware that knows with this degree of granularity
we don't propogate the information back in the manner you want.

I'm not sure its a total loss however. Currently all the code basically
does stuff in the tx path or tx irq handler along the line of


	if (bytes_left < constant)
		write_wakeup


and I suspect if you made that adjustable and turned off the fifo and any
other funnies you'd at least make it work for a sufficiently rigged demo.

We could in theory put it in the tty_port in future too if its general
purpose useful.

Alan
