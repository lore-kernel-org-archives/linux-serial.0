From: Jon Loeliger <jdl@jdl.com>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 05 Aug 2007 16:50:29 -0500
Message-ID: <E1IHnzZ-0008SZ-2y@jdl.com>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange> <200708050135.07753.arnd@arndb.de> <Pine.LNX.4.60.0708051600550.4120@poirot.grange> <200708051841.17471.arnd@arndb.de> <E1IHnhY-0008PO-IZ@jdl.com>  <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jdl.com ([208.123.74.7]:33867 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893AbXHEVuc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Aug 2007 17:50:32 -0400
In-Reply-To: Your message of "Sun, 05 Aug 2007 23:39:19 +0200."
             <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

So, like, the other day Guennadi Liakhovetski mumbled:
> On Sun, 5 Aug 2007, Jon Loeliger wrote:
> 
> ...if you choose to use of_serial.c, yes, if you don't use it and just use 
> legacy_serial.c, then you're fine.

Ah, I see.  OK.

> BTW, my offer still holds to see if we can build a single kernel for both 
> with just specific device-trees, but that's a separate matter:-)

Indeed.  I'm fully on-board with that goal, but it may take a couple
rounds to refine it into that state.

One question I have is the stupid ethernet driver.  Is the driver
that is in mainline now usable on the StorCenter?  I haven't
waded through the supplied vendor patch to verify how it compares
to the r8169 in mainline yet.

Also, what do you want to do about the Kconfig set up for these then?
Specifically, do you want to have "TurboStation" and "StorCenter"?
Or would it make more sense to have something like a generic
"NAS8241" with sub-choices of "storcenter" and "turbostation"?

Thanks,
jdl
