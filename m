From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Change to serial_core.c .... causing my serial driver problem
 Help Request
Date: Thu, 17 Apr 2008 16:55:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804171652010.6716@axis700.grange>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804160046460.6851@axis700.grange>
 <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
 <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
 <8CA6E482AE34A65-15A8-47A5@webmail-nb06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753269AbYDQOzL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 10:55:11 -0400
In-Reply-To: <8CA6E482AE34A65-15A8-47A5@webmail-nb06.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org

On Wed, 16 Apr 2008, vcgandhi1@aol.com wrote:

> I do the same
> 
> port->dev   = &dev->dev;
> 
> But I am not sure &dev->dev points to the parent. I think it points to the
> device it's self, but I may be wrong.  I have tried port->dev = &dev->dev as
> well as port->dev = dev->dev.parent.

It depends on what your "dev" is, and this is driver-specific. So, 
unfortunately, I don't think I'll be able to help you any further without 
seeing the sources.

> One of these found something when the
> port was TTYS0 but did not work when the port was TTYS2.
> 
> Did you test with a non zero port->line. I working on ttyS2.

Yes, I tested it with ttyS0 and ttyS1.

> Just trying to narrow down what could be wrong. It just that    
> tty_dev = device_find_child(port->dev, &match, serial_match_port);
> 
> is returning NULL for me.
> 
> Thank You for your help.
> Vipul
> 
> PS. One quick suggestion you may want to check the return value and verify it
> is non-NULL before using it. Makes it easier to debug the code. ...

Feel free to submit a patch.

Thanks
Guennadi
---
Guennadi Liakhovetski
