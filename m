From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/27] serial: sh-sci: External Clock Support
Date: Mon, 14 Dec 2015 21:23:37 -0800
Message-ID: <20151215052337.GB30050@kroah.com>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
 <20151215045350.GD32397@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151215045350.GD32397@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 15, 2015 at 01:53:51PM +0900, Simon Horman wrote:
> Hi Geert,
> 
> thanks for taking care of this, is quite a task!
> 
> On Mon, Dec 14, 2015 at 07:57:09PM +0100, Geert Uytterhoeven wrote:
> > 	Hi Greg, Simon, Magnus, Sato-san,
> > 
> > This patch series contains several patches for the Renesas SCI serial
> > driver:
> >   - Clean up the naming of clocks in the driver and its DT bindings,
> >   - Add support for the optional external clock on (H)SCI(F) and some
> >     SCIFA, where this pin can serve as a clock input,
> >   - Add support for the optional clock sources for the Baud Rate
> >     Generator for External Clock (BRG), as found on some SCIF variants
> >     and on HSCIF.
> > Using external clocks increases the range and accuracy of supported baud
> > rates.
> > 
> > This series is an updated version of the core (driver) changes of two
> > series I sent before:
> >   - [PATCH v2 00/16] serial: sh-sci: Clock Cleanups
> >     (http://www.spinics.net/lists/linux-serial/msg19762.html)
> >   - [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
> >     (https://lkml.org/lkml/2015/11/19/550)
> > To reduce (cross) dependencies, I split off the integration (DTS)
> > patches into separate series:
> >   - "[PATCH 0/7] ARM: shmobile: dtsi: Add SCIF fallback compatibility
> >      strings",
> >   - "[PATCH v3 00/12] ARM: shmobile: dtsi: Rename the serial port
> >      clock to fck",
> >   - "[PATCH v2 0/7] ARM: shmobile: dtsi: Add BRG support for (H)SCIF",
> >   - "[PATCH v2 0/9] ARM: shmobile: dts: Enable SCIF_CLK frequency and
> >     pins".
> > As the SH architecture is orphaned, and the risk of conflicts is small,
> > I have bundled all SH-specific changes with the core changes.  This
> > reduces dependencies, too.
> 
> At this point I see two ways to move things forwards:
> 
> 1. Greg can consider taking this series and I can take the
>    related integration (DTS) series (noted below) into v4.6.
> 2. I can get some missing Acks from Greg (patches 02 and 07 I believe)
>    and try and queue up this series and the related integration (DTS)
>    series (noted below).
> 
> As it (perhaps surprisingly) it is late in the merge cycle for me to take
> changes for v4.5 that will go though the ARM SoC tree and I am trying to
> stabilise things a little. Thus, I favour option 1.

I can take them, one question:

> > I've also pushed this series (against v4.4-rc1) to the
> > topic/scif-clk-sck-brg-core-v3 branch of my renesas-drivers git
> > repository at
> > https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> > 
> > For testing, you best use the renesas-drivers-2015-12-14-v4.4-rc5 tag,
> > as it includes the integration part.

Can I just pull from that tag to get everything?  That would be the
simplest for me...

thanks,

greg k-h
