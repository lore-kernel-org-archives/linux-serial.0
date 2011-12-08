From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
Date: Thu, 08 Dec 2011 15:20:04 +1100
Message-ID: <1323318004.12793.21.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
	 <20111023141115.208699274@telegraphics.com.au>
	 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
	 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2011-12-07 at 14:49 +1100, Finn Thain wrote:
> On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> masked. This can be a problem when pmac_zilog starts up.
> 
> For example, the serial debugging code in arch/m68k/kernel/head.S may be 
> used beforehand. It disables the SCC interrupts at the chip but doesn't 
> ack them. Then when a pmac_zilog port is used, the machine locks up with 
> "unexpected interrupt".
> 
> This can happen in pmz_shutdown() since the irq is freed before the 
> channel interrupts are disabled.
> 
> Fix this by clearing interrupt enable bits before the handler is 
> uninstalled. Also move the interrupt control bit flipping into a separate 
> pmz_interrupt_control() routine. Replace all instances of these operations 
> with calls to this routine. Omit the zssync() calls that seem to serve no 
> purpose.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Alan Cox <alan@linux.intel.com>
> 
> ---

So basic operations seem to work, I've applied the patch to
powerpc-next.

However, the internal modem on my Pismo powerbook doesn't appear to
survive suspend/resume. I'll dig into that and merge a fixup patch asap.

Cheers,
Ben.
