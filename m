From: Adam Ford <aford173@gmail.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Date: Wed, 9 Oct 2019 14:27:18 -0500
Message-ID: <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com> <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
 <20191009173446.GL5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009173446.GL5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, Yegor Yefremov <yegorslists@googlemail.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 9, 2019 at 12:34 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191009 14:09]:
> > On Wed, Oct 9, 2019 at 8:42 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On 06/10/19 10:34 PM, Adam Ford wrote:
> > > > Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> > > >
> > > > I can use the DMA on the legacy, omap-serial driver, but when I enable
> > > > the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> > > >
> > > > The older driver seems to have an ISR that seems to address a variety
> > > > of items compared to the very tiny ISR for 8250-omap.c.
> > > >
> > > > I am not exactly sure where to start, but if someone has any
> > > > suggestions on how I can troubleshoot, please let me know.  As of now,
> > > > I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> > > > connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> > > > appears to work just fine after some patches I just submitted for
> > > > handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> > > >
> > >
> > > Mainline omap-serial does not support DMA (evident from lack of
> > > dmaengine API calls) and therefore is not a regression. So OMAP3 UART
> > > DMA was never tested at least with 8250 driver.
> > > I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
> > > analyse of whether all erratas workarounds are implemented and see if
> > > there any difference wrt DMA integration itself. Do we know if UART DMA
> > > ever worked on OMAP3 previously?
> >
> > Can we disable CONFIG_SERIAL_8250_DMA from omap2plus_defconfig?   As
> > of right now, it's the only way I can use the Bluetooth.  There are
> > #ifdef's in the 8250-omap driver, so it looks like some of the hooks
> > are there, but if it's incomplete, it seems like we shouldn't enable
> > this config option by default yet.
>
> From what I recall I tested that DMA on omap3 worked fine with runtime
> PM for console. Certainly there are issues still remaining though.
>
> If you want to disable dma for a specific port, just delete the
> add /delete-property/dma-names for the port in question in your
> board specific dts file.
>
> See 8250_omap.c for of_property_count_strings(np, "dma-names").

Thank you.  That seems to have worked.  I'll check the AM3517 when I
have some time to see if it needs the same patch.  For now, I pushed
the patch to the omap mailing list for the Logic PD Torpedo board.

Should we consider removing the OMAP_SERIAL from omap2plus_defconfig
in the 8250 is the preferred driver?  It seems odd to me that both
drivers are enabled.

adam
>
> Regards,
>
> Tony
>
>
