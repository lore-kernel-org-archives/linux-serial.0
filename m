From: Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Thu, 13 Mar 2008 01:38:55 +0100
Message-ID: <200803130138.55582.technoboy85@gmail.com>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312093145.GA6270@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080312093145.GA6270@alpha.franken.de>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

Il Wednesday 12 March 2008 10:31:46 Thomas Bogendoerfer ha scritto:
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 289942f..869b6df 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -40,6 +40,7 @@
> >  #define PORT_NS16550A	14
> >  #define PORT_XSCALE	15
> >  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> > +#define PORT_AR7	16
> 
> this doesn't look correct.
> 
> Thomas.
> 

Isn't it 16?
