From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_lpss: Unconditionally set PCI master for
 Quark
Date: Tue, 10 Jan 2017 14:06:22 +0200
Message-ID: <1484049982.2133.5.camel@linux.intel.com>
References: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
         <CAHp75VdVagWk1P2X7Tp3mgGGeJoU_dbxyTiyZ-Hz=VxjF2VX3g@mail.gmail.com>
         <99156264-8525-f5b6-9a67-735bcdd6f399@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99156264-8525-f5b6-9a67-735bcdd6f399@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2017-01-09 at 18:00 +0100, Jan Kiszka wrote:
> On 2017-01-05 22:54, Andy Shevchenko wrote:
> > On Wed, Jan 4, 2017 at 10:48 PM, Jan Kiszka <jan.kiszka@siemens.com>
> > wrote:
> > > MSI needs it as well.
> > > 
> > > Should have no practical impact, though, as DMA is always
> > > available on
> > > the Quark. But given the few users of pci_alloc_irq_vectors so
> > > far, this
> > > incorrect pattern may spread otherwise.
> > > 
> > 
> > One question below.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > 
> > > Fixes: 3f3a46951e02 ("serial: 8250_lpss: set PCI master only for
> > > private DMA")
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_lpss.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_lpss.c
> > > b/drivers/tty/serial/8250/8250_lpss.c
> > > index f09f68a..9315197 100644
> > > --- a/drivers/tty/serial/8250/8250_lpss.c
> > > +++ b/drivers/tty/serial/8250/8250_lpss.c
> > > @@ -183,7 +183,6 @@ static void qrk_serial_setup_dma(struct
> > > lpss8250 *lpss, struct uart_port *port)
> > >         if (ret)
> > >                 return;
> > > 
> > > -       pci_set_master(pdev);
> > >         pci_try_set_mwi(pdev);
> > 
> > Does it make sense to move MWI there as well?
> 
> TBH, I didn't come across the need to enable this bit so far,
> specifically not for doing MSI transactions. Is MWI used at all for
> MSI
> (spec says that MSI is "using a PCI DWORD memory write transaction")?

No, it can't. PCIe has no MWI feature at all, but you may have MSI
there.

> That question is better answered by someone more familiar with such
> PCI
> details.

In most (modern) cases trying MWI is no-op.

So, I think you may send v2 of this with my tag without any changes in
the code. Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
