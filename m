From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16] pmac_zilog: fix unexpected irq
Date: Fri, 25 Nov 2011 07:41:48 +1100
Message-ID: <1322167308.32635.6.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
	 <20111023141115.208699274@telegraphics.com.au>
	 <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
	 <20111124145624.24438832@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20111124145624.24438832@lxorguk.ukuu.org.uk>
Sender: linux-m68k-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Finn Thain <fthain@telegraphics.com.au>, linux-serial@vger.kernel.org, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 2011-11-24 at 14:56 +0000, Alan Cox wrote:
> > This patch has been tested on a variety of m68k Macs but no
> PowerMacs.
> > 
> > I am re-sending this patch Cc linux-serial. It still needs a
> suitable ack 
> > so that Geert can push it through his tree.
> 
> Given the change should work for all hardware do we really need the
> ifdefs. Far better I would have thought to just change it so we don't
> have to maintain what is effectively two versions of the code between
> now
> and 2038.
> 
> So no ack from me yet - I'd like to understand the ifdef decision
> first.
> Otherwise it looks sensible.

Yes, agreed. Sorry, that one was one my to-do list for a while, I meant
to look into more details and test on a ppc or two here see if it breaks
anything, and never got to do it.

I'll try to give it a go before hell freezes over.

Cheers,
Ben.
