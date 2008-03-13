From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Thu, 13 Mar 2008 09:45:26 +0100
Message-ID: <20080313084526.GA6012@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312093145.GA6270@alpha.franken.de> <200803130138.55582.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:59123 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbYCMJE4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Mar 2008 05:04:56 -0400
Content-Disposition: inline
In-Reply-To: <200803130138.55582.technoboy85@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Mar 13, 2008 at 01:38:55AM +0100, Matteo Croce wrote:
> Il Wednesday 12 March 2008 10:31:46 Thomas Bogendoerfer ha scritto:
> > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > > index 289942f..869b6df 100644
> > > --- a/include/linux/serial_core.h
> > > +++ b/include/linux/serial_core.h
> > > @@ -40,6 +40,7 @@
> > >  #define PORT_NS16550A	14
> > >  #define PORT_XSCALE	15
> > >  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> > > +#define PORT_AR7	16
> > 
> > this doesn't look correct.
> > 
> > Thomas.
> > 
> 
> Isn't it 16?

PORT_RM9000 is 16, how could PORT_AR7 be 16 as well ? And the 16 for 
PORT_RM9000 is correct in my counting.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
