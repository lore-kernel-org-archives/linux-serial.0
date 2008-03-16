From: Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Sun, 16 Mar 2008 16:49:30 +0100
Message-ID: <200803161649.30531.technoboy85@gmail.com>
References: <200803120221.25044.technoboy85@gmail.com> <200803130131.54570.technoboy85@gmail.com> <20080313090109.GB6012@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out25.alice.it ([85.33.2.25]:1553 "EHLO
	smtp-out25.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYCPPtu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 16 Mar 2008 11:49:50 -0400
In-Reply-To: <20080313090109.GB6012@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Il Thursday 13 March 2008 10:01:09 Thomas Bogendoerfer ha scritto:
> On Thu, Mar 13, 2008 at 01:31:54AM +0100, Matteo Croce wrote:
> > Il Wednesday 12 March 2008 12:16:29 Alan Cox ha scritto:
> > > On Wed, 12 Mar 2008 02:30:06 +0100
> > > Matteo Croce <technoboy85@gmail.com> wrote:
> > > 
> > > > Ugly but we need it
> > > 
> > > Too ugly - NAK
> > > 
> > > However please send an explanation of the problem and lets find a nicer
> > > way to do it or bury it in arch code.
> > > 
> > > 
> > 
> > This is my problem:
> > 
> > ffi_cmdset_000: DDisabling erae-ssuspend-progrm ddue to code bokeenness.
> > cmdlinparrt partition arssing not avaiabll
> > RedBoo ppartition parsngg not availabl
> > NET: Rgiistered protocl  family 1
> > NET: Regsteered protocol ammily 10
> > IPv6 overIPPv4 tunnelingdriiver
> > NET: Regsteered protocolfammily 17
> > FS:: Mounted roo (ssquashfs filessttem) readonly.
> > Freeing nuused kernel meorry: 120k freed
> > 
> > I'll try to find a nicer way to fix it
> 
> don't use AFE mode and treat it like a normal 16550 (PORT_16550A). You
> could also try to use UPIO_MEM32. That's how my console driver
> (different OS) works for AR7 without the hack to wait for LSR_TEMP and 
> LSR_THRE.
> 
> Thomas.
> 

What do you mean by don't using AFE? Just removing UART_CAP_AFE from the .fcr field?
I've tried but it doesn't work.

I tried also UPIO_MEM32 instead of UPIO_MEM (with PORT_AR7) but it doesn't works
