From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Thu, 13 Mar 2008 10:01:09 +0100
Message-ID: <20080313090109.GB6012@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312111629.0fa15d9c@the-village.bc.nu> <200803130131.54570.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:59128 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbYCMJE4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2008 05:04:56 -0400
Content-Disposition: inline
In-Reply-To: <200803130131.54570.technoboy85@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Mar 13, 2008 at 01:31:54AM +0100, Matteo Croce wrote:
> Il Wednesday 12 March 2008 12:16:29 Alan Cox ha scritto:
> > On Wed, 12 Mar 2008 02:30:06 +0100
> > Matteo Croce <technoboy85@gmail.com> wrote:
> > 
> > > Ugly but we need it
> > 
> > Too ugly - NAK
> > 
> > However please send an explanation of the problem and lets find a nicer
> > way to do it or bury it in arch code.
> > 
> > 
> 
> This is my problem:
> 
> ffi_cmdset_000: DDisabling erae-ssuspend-progrm ddue to code bokeenness.
> cmdlinparrt partition arssing not avaiabll
> RedBoo ppartition parsngg not availabl
> NET: Rgiistered protocl  family 1
> NET: Regsteered protocol ammily 10
> IPv6 overIPPv4 tunnelingdriiver
> NET: Regsteered protocolfammily 17
> FS:: Mounted roo (ssquashfs filessttem) readonly.
> Freeing nuused kernel meorry: 120k freed
> 
> I'll try to find a nicer way to fix it

don't use AFE mode and treat it like a normal 16550 (PORT_16550A). You
could also try to use UPIO_MEM32. That's how my console driver
(different OS) works for AR7 without the hack to wait for LSR_TEMP and 
LSR_THRE.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
