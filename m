From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
Date: Thu, 08 Dec 2011 15:30:38 +1100
Message-ID: <1323318638.12793.23.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
	 <20111023141115.208699274@telegraphics.com.au>
	 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
	 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
	 <1323318004.12793.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1323318004.12793.21.camel@pasglop>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2011-12-08 at 15:20 +1100, Benjamin Herrenschmidt wrote:

> So basic operations seem to work, I've applied the patch to
> powerpc-next.
> 
> However, the internal modem on my Pismo powerbook doesn't appear to
> survive suspend/resume. I'll dig into that and merge a fixup patch asap.

BTW. I applied anyway because suspend/resume was already broken (you
spotted that we don't clear the suspended flag for example).

Fixing the flag alone helps a bit. We can't use the modem if we
suspend/resume with the open port, but closing and re-opening works.

Lockdep also picked-up a A->B B->A between the port mutex and the pmz
irq mutex on suspend.

I'll try to fix all these, and will let you know (I may not have time
today).

Cheers,
Ben.
