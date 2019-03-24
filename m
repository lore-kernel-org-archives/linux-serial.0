From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Sun, 24 Mar 2019 14:31:11 +0200
Message-ID: <CAHp75VeyL-G9i=ABg8r6R7+oBBYRDM82L2-jFEm1uK0-136aMw@mail.gmail.com>
References: <20190323225313.12325-1-pakki001@umn.edu> <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
 <CAHp75VfbPue803w06GdJwU_JYcFKEcShLpyGRMhOg9xi4ZwpAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfbPue803w06GdJwU_JYcFKEcShLpyGRMhOg9xi4ZwpAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 24, 2019 at 2:26 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Mar 24, 2019 at 2:05 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 24, 2019 at 12:55 AM Aditya Pakki <pakki001@umn.edu> wrote:
> > >
> > > pci_ioremap_bar could fail. The fix captures the failure and
> > > pass an error code upstream. This can avoid potential NULL
> > > pointer dereferences in the future.
> > >
> >
> > NAK.
> > This will break non-DMA case.
>
> > > @@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>
> Just to clarify, what you need is simple
>

> void __iomem *regs;

Sorry for leftover.

> chip->pdata = ... //move it here for better looking code
> chip->irq = ...

> chip->regs = pci_ioremap_bar(...);

And looking into the code it needs pci_iounmap() on exit one.

> if (!chip->regs)
>   return;
>
> and thank you for pointing to this.

-- 
With Best Regards,
Andy Shevchenko
