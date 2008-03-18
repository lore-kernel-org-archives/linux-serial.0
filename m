From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Tue, 18 Mar 2008 16:28:39 +0100
Message-ID: <20080318152839.GA7765@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com> <20080318133015.GA7239@alpha.franken.de> <20080318140133.3d41fd87@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20080318140133.3d41fd87@core>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 18, 2008 at 02:01:33PM +0000, Alan Cox wrote:
> > Is there a good reason, why we don't check for BOTH_EMPTY in
> > serial8250_console_putchar() ? To match the 2.6.10 behaviour we
> 
> A very good one - we have at least 1 byte of FIFO and the serial-ethernet
> magic console devices also use that fifo emptying entirely to deduce when
> to send a new packet.

ok, now I understand.

> > would need that and this would fix the AR7 case without any
> > special handling.
> 
> If the AR7 is an 8250 why does it need special handling? and indeed why
> does serial work on it except for console - or does that fail too.

well TI calls it a 16550A and I still wonder about the reported
problems. Looks like I need to dig a little bit deeper...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
