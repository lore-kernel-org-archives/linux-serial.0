From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 15:58:41 +0100
Message-ID: <A00955ACF1104CC28630FA1EAA4DF591@acksys.local>
References: <20101116143016.GB6527@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out04.msg.oleane.net ([62.161.7.2]:42077 "EHLO
	smtp-out04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0KPPqv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Nov 2010 10:46:51 -0500
Received: from smtp05.msg.oleane.net (smtp05.mail.priv [172.17.20.114])
	by smtp-out04.msg.oleane.net with ESMTP id oAGFJdqw005563
	for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 16:19:40 +0100
In-Reply-To: <20101116143016.GB6527@ucw.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Pavel Machek' <pavel@ucw.cz>, 'Claudio Scordino' <claudio@evidence.eu.com>
Cc: linux-serial@vger.kernel.org, 'Greg KH' <gregkh@suse.de>

Hi,

> I have seen hardware (kontron pmc-6l) that was capable of switching
> between RS232, RS485 and one other standard by software.
>
> Is such hw common? If so, should we have standard interface?

I believe it is neither common nor a good thing.

Dynamically switching between electrical levels means that the remote device
must be capable of handling both electrical levels, else it might be damaged
(i.e., when the serial card is configured to RS485 but switches to RS232
when reset).

Or, different pins must be used for RS232 and RS485 (then software switching
is not really useful).

Jean-Pierre Tosoni

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Pavel Machek
> Sent: Tuesday, November 16, 2010 3:30 PM
> To: Claudio Scordino
> Cc: Greg KH; Nicolas Ferre; linux-serial@vger.kernel.org;
> Grant Edwards;
> linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Alan
> Cox
> Subject: Re: [PATCH] Documentation about RS485 serial communications
>
>
> Hi!
>
> > Documentation about RS485 serial communications
>
> I have seen hardware (kontron pmc-6l) that was capable of switching
> between RS232, RS485 and one other standard by software.
>
> Is such hw common? If so, should we have standard interface?
>
> > +   From user-level, RS485 configuration can be get/set
> using the previous
> > +   ioctls. For instance, to set RS485 you can use the
> following code:
> > +
> > +	#include <linux/serial.h>
> > +
> > +	/* Driver-specific ioctls: */
> > +	#define TIOCGRS485      0x542E
> > +	#define TIOCSRS485      0x542F
> > +
> > +	/* Open your specific device (e.g., /dev/mydevice): */
> > +	int fd = open ("/dev/mydevice", O_RDWR);
> > +	if (fd < 0) {
> > +		/* Error handling. See errno. */
> > +	}
> > +
> > +	struct serial_rs485 rs485conf;
> > +
> > +	/* Set RS485 mode: */
> > +	rs485conf.flags |= SER_RS485_ENABLED;
>
> IOW... is this supposed to switch electrical levels?
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

