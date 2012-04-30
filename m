From: Christian Melki <christian.melki@ericsson.com>
Subject: RE: 8250.c: Generic support for RTS disabling once shiftreg and
 fifo is empty. (low latency RS485 etc).
Date: Mon, 30 Apr 2012 09:05:10 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A07E011F7@ESESSCMS0353.eemea.ericsson.se>
References: <1346E68D3A5B2043907CF4BF466383411A07E01021@ESESSCMS0353.eemea.ericsson.se>
 <20120427100207.48c04654@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw2.ericsson.se ([193.180.251.37]:52349 "EHLO
	mailgw2.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2D3HFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Apr 2012 03:05:13 -0400
In-Reply-To: <20120427100207.48c04654@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> On Fri, 27 Apr 2012 08:23:23 +0200
> Christian Melki <christian.melki@ericsson.com> wrote:
> 
> > Hi.
> > 
> > I have written a patch for 8250.c that introduces a new 
> > ioctl to tell the uart driver to shift disable RTS when uart 
> > has been completely emptied.
> > This idea is to set the ioctl once the master is finished 
> > and wants to shift the bus.
> > We needed this to be in the kernel since we have very 
> > little time to shift RTS according to the implemented 
> > protocol on top of RS485.
> > 
> > Is there any interest in the community for such a behavior?
> 
> We have a set of RS485 ioctls that provide a standard 
> interface for assisting RS485 handling. The interface should 
> probably use those if possible.

Ok, didn't see that ioctl. Don't like the naming though.
I know I have used RS485 as a reference, but this can be used for
any half duplex protocol control. Maybe something like RTSCTL
would be more appropriate. (I was looking for ioctls with RTS names).
Anyway, no more whining :). I'll redo it with that ioctl instead.
 
> > The patch is a little ugly right now. It busywaits a 
> > maximum amount of time for the shift register to become 
> > empty. I don't know how to do it without introducing a 
> > latency that is more than our max RTS time shift requirement 
> > (50us). I think it could be useful with a generic 8250.c 
> > support for this.
> 
> We've hit the same hardware limit in a couple of other places 
> where you end up having to spin on the last byte. I don't 
> think it's a problem providing it is only triggered when 
> trying to do the RS485 bits with that feature.

It will be exactly like that in the tx-path. So it won't disturb
"normal" users beside one more feature check.

> Alan
> 