From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 23:39:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
 <200708050135.07753.arnd@arndb.de> <Pine.LNX.4.60.0708051600550.4120@poirot.grange>
  <200708051841.17471.arnd@arndb.de>  <E1IHnhY-0008PO-IZ@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60173 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751874AbXHEVjL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Aug 2007 17:39:11 -0400
In-Reply-To: <E1IHnhY-0008PO-IZ@jdl.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

On Sun, 5 Aug 2007, Jon Loeliger wrote:

> So, like, the other day Arnd Bergmann mumbled:
> > On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> > > That would be a possibility, but that would mean all 8241/8245 have to 
> > > adjust their .dts. Ok, there are not so many of them in the mainline now 
> > > (in fact, hardly any apart from linkstation:-)), still. Cannot we use 
> 
> Heck, I'm slowly working on the StorCenter too.. :-)
> 
> I supect it will have the same issue in the end, right?

...if you choose to use of_serial.c, yes, if you don't use it and just use 
legacy_serial.c, then you're fine.

BTW, my offer still holds to see if we can build a single kernel for both 
with just specific device-trees, but that's a separate matter:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
