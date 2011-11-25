From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 01/16] pmac_zilog: fix unexpected irq
Date: Fri, 25 Nov 2011 14:15:10 +1100 (EST)
Message-ID: <alpine.LNX.2.00.1111250207040.6314@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au> <20111023141115.208699274@telegraphics.com.au> <alpine.LNX.2.00.1111250133321.6314@nippy.intranet> <20111124145624.24438832@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20111124145624.24438832@lxorguk.ukuu.org.uk>
Sender: linux-m68k-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-serial@vger.kernel.org, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org


On Thu, 24 Nov 2011, Alan Cox wrote:

> Given the change should work for all hardware do we really need the 
> ifdefs. Far better I would have thought to just change it so we don't 
> have to maintain what is effectively two versions of the code between 
> now and 2038.

I agree.

> 
> So no ack from me yet - I'd like to understand the ifdef decision first.

Removing ifdefs makes the changes more invasive and the suspend/resume 
code then has to be addressed, which I've avoided.

The suspend/resume code path can't be tested on m68k macs and the common 
code paths I can't easily test on a powermac.

This patch should not be needed because the chip reset shouldn't leave the 
tx and rx interrupts enabled. Those interrupts are explicitly enabled only 
after request_irq(), so patching the master interrupt enable behaviour 
should be redundant. But that's not the case in practice.

The chip reset code is already messy. I was inclined towards ifdefs and 
reluctant to share more code after practical experience suggested possible 
differences in the SCC/ESCC devices.

I guess I was hoping that the powermac maintainers might prefer ifdefs to 
increased risk of destabilising the driver on powermacs...

But a more invasive patch would make for better code. I will see if I can 
borrow a suitable PCI PowerMac.

Finn

> Otherwise it looks sensible.
> 
> Alan
