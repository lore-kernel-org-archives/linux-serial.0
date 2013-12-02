From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
Date: Mon, 2 Dec 2013 11:49:32 +0200
Message-ID: <20131202094932.GF3942@xps8300>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
 <20131202090253.GE3942@xps8300>
 <1385976238.12531.8.camel@host5.omatika.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56674 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab3LBJtx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 04:49:53 -0500
Content-Disposition: inline
In-Reply-To: <1385976238.12531.8.camel@host5.omatika.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi,

On Mon, Dec 02, 2013 at 01:23:58PM +0400, Sergei Ianovich wrote:
> On Mon, 2013-12-02 at 11:02 +0200, Heikki Krogerus wrote:
> > On Sun, Dec 01, 2013 at 10:26:14AM +0400, Sergei Ianovich wrote:
> > > PXA serial ports have "standard" UART names (ttyS[0-3]), major
> > > device number (4) and first minor device number (64) by default.
> > > 
> > > If the system has extra 8250 serial port hardware in addition
> > > to onboard PXA serial ports, default settings produce a device
> > > allocation conflict.
> > > 
> > > The patch provides a configuration option which can move onboard
> > > ports out of the way of 8250_core by assigning a different (204)
> > > major number and corresponding device names (ttySA[0-3]).
> > > 
> > <snip>
> > 
> > If drivers/tty/serial/pxa.c was converted to an other probe driver for
> > the 8250, this would not be an issue.
> 
> It seems that my patch is not going to be accepted. However, there is a
> device which has both PXA ports and a additional 8250 accent chip. As a
> result, there is a device allocation conflict. For the device to be
> usable the conflict needs to be resolved.
> 
> Do you mean that drivers/tty/serial/pxa.c needs to be rewritten to
> support lp8x4x special case?

Sorry I was not clear. I was suggesting that drivers/tty/serial/pxa.c
would be converted to drivers/tty/serial/8250/8250_pxa.c since it
looks to me like just an other 16x50 compatible UART. That would fix
the issue with the name conflict. You would then simply register 8250
ports from two probe drivers (drivers/tty/serial/8250/8250_pxa.c and
drivers/tty/serial/8250/8250_lp8x4x.c).

Depending on the order you register your platform devices (which you
decide in your platform code), but let's say the pxa gets registered
first and let's say it only has one port. You will then have in your
system /dev/ttyS0 for the pxa port and /dev/ttyS[1-4] for the other
UART.

I hope I was able to explain what I mean this time :)

Thanks,

-- 
heikki
