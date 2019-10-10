From: Adam Ford <aford173@gmail.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Date: Thu, 10 Oct 2019 09:11:29 -0500
Message-ID: <CAHCN7x+B5nw=muPPTXAv+Pwx69bJSmi2jZhC68fA=rtN7=ELoA@mail.gmail.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com> <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
 <20191009173446.GL5610@atomide.com> <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
 <20191009201612.GQ5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009201612.GQ5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, Yegor Yefremov <yegorslists@googlemail.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 9, 2019 at 3:16 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191009 19:28]:
> > On Wed, Oct 9, 2019 at 12:34 PM Tony Lindgren <tony@atomide.com> wrote:
> > > From what I recall I tested that DMA on omap3 worked fine with runtime
> > > PM for console. Certainly there are issues still remaining though.
> > >
> > > If you want to disable dma for a specific port, just delete the
> > > add /delete-property/dma-names for the port in question in your
> > > board specific dts file.
> > >
> > > See 8250_omap.c for of_property_count_strings(np, "dma-names").
> >
> > Thank you.  That seems to have worked.  I'll check the AM3517 when I
> > have some time to see if it needs the same patch.  For now, I pushed
> > the patch to the omap mailing list for the Logic PD Torpedo board.
> >
> > Should we consider removing the OMAP_SERIAL from omap2plus_defconfig
> > in the 8250 is the preferred driver?  It seems odd to me that both
> > drivers are enabled.
>
> We have CONFIG_SERIAL_8250_OMAP=y and by default also we have
> CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y. With those omap_serial
> won't probe.. So yeah I guess for v5.5 we could drop the
> option for CONFIG_SERIAL_OMAP for both omap2plus_defconfig and
> multi_v7_defconfig.

Do you want me to push a patch for that, or is that something you want to do?

adam
>
> Regards,
>
> Tony
