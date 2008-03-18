From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Tue, 18 Mar 2008 14:30:15 +0100
Message-ID: <20080318133015.GA7239@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:37142 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbYCRNa3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Mar 2008 09:30:29 -0400
Content-Disposition: inline
In-Reply-To: <200803161645.06364.technoboy85@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sun, Mar 16, 2008 at 04:45:06PM +0100, Matteo Croce wrote:
> Il Saturday 15 March 2008 11:40:09 Thomas Bogendoerfer ha scritto:
> > On Fri, Mar 14, 2008 at 04:46:09PM +0100, Matteo Croce wrote:
> > > This is a bit better
> > 
> > is it possible to try without the serial changes first ?
> > 
> > Use 
> > 
> >        uart_port[0].type = PORT_16550A;
> > 
> > in arch/mips/ar7/platform.c.
> > 
> > Does it work ?
> > 
> 
> Tried I get teh usual broken serial output:

I just checked the latest AR7/UR8 source, I have, and they don't need
special hacks. This is a 2.6.10 based tree. At that time there was
no serial8250_console_putchar(), console output was done via
serial8250_console_write() without any helper. Before writing to 
the UART_TX, wait_for_xmitr() is called. And this wait_for_xmitr() does
check for BOTH_EMPTY.

Is there a good reason, why we don't check for BOTH_EMPTY in
serial8250_console_putchar() ? To match the 2.6.10 behaviour we
would need that and this would fix the AR7 case without any
special handling.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
