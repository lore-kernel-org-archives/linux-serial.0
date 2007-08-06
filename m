From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Mon, 6 Aug 2007 21:54:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708062139140.5694@poirot.grange>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange> <E1IHnhY-0008PO-IZ@jdl.com>
 <Pine.LNX.4.60.0708052336360.4120@poirot.grange> <200708052357.32650.arnd@arndb.de>
 <1288ff079974aa806119584018bab973@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758565AbXHFTyV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Aug 2007 15:54:21 -0400
In-Reply-To: <1288ff079974aa806119584018bab973@kernel.crashing.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>, linux-serial@vger.kernel.org

On Mon, 6 Aug 2007, Segher Boessenkool wrote:

> > Maybe the best solution would be for 824[15] to not claim compatibility
> > with 8250 at all then.
> 
> Or at least it should have a more specific entry for this
> "special" 16x50 UART, and that one should be probed first.
> 
> > If the device tree contains an entry that matches
> > what the generic driver looks for, it better be something that can
> > be handled by that driver.
> 
> Pretty much; you can't make this rule too strict though,
> if a device mostly works with the generic driver, you can
> claim compatibility with it -- keep in mind that that can
> come back to bite you though, like in this case.  The
> advantages do outweigh the disadvantages sometimes, it's
> all a tradeoff; avoid it if possible.

Well, the 8250 driver DOES already support devices without the loopback 
test support, that's what that bit there is for, isn't it? So, we just 
have to use it, as well as others do (grep -r UPF_SKIP_TEST 
drivers/serial/). I'll go for the extra compatible property, as suggested, 
seems like the most commonly accepted wa to handle this (and the easiest 
to implement).

Thanks
Guennadi
---
Guennadi Liakhovetski
