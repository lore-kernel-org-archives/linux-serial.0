From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250.c: Generic support for RTS disabling once shiftreg and
 fifo is empty. (low latency RS485 etc).
Date: Fri, 27 Apr 2012 10:02:07 +0100
Message-ID: <20120427100207.48c04654@pyramind.ukuu.org.uk>
References: <1346E68D3A5B2043907CF4BF466383411A07E01021@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43345 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759677Ab2D0I7W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 04:59:22 -0400
In-Reply-To: <1346E68D3A5B2043907CF4BF466383411A07E01021@ESESSCMS0353.eemea.ericsson.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Melki <christian.melki@ericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, 27 Apr 2012 08:23:23 +0200
Christian Melki <christian.melki@ericsson.com> wrote:

> Hi.
> 
> I have written a patch for 8250.c that introduces a new ioctl to tell the uart driver to shift disable RTS when uart has been completely emptied.
> This idea is to set the ioctl once the master is finished and wants to shift the bus.
> We needed this to be in the kernel since we have very little time to shift RTS according to the implemented protocol on top of RS485.
> 
> Is there any interest in the community for such a behavior?

We have a set of RS485 ioctls that provide a standard interface for
assisting RS485 handling. The interface should probably use those if
possible.

> The patch is a little ugly right now. It busywaits a maximum amount of time for the shift register to become empty. I don't know how to do it without introducing a latency that is more than our max RTS time shift requirement (50us). I think it could be useful with a generic 8250.c support for this.

We've hit the same hardware limit in a couple of other places where you
end up having to spin on the last byte. I don't think it's a problem
providing it is only triggered when trying to do the RS485 bits with that
feature.

Alan
