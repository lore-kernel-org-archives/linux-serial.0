From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 5/8] serial: imx: save and restore context in the suspend
 path
Date: Sun, 9 Aug 2015 21:04:05 -0700
Message-ID: <20150810040404.GA5943@localhost.localdomain>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
 <1439144349-10494-6-git-send-email-edubezval@gmail.com>
 <CAOMZO5D18DCBXYLA8Z36ZY3wezzS9Nh64d0KWZ==zcFMHaBpsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5D18DCBXYLA8Z36ZY3wezzS9Nh64d0KWZ==zcFMHaBpsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux PM <linux-pm@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Shenwei Wang <shenwei.wang@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 10, 2015 at 12:30:18AM -0300, Fabio Estevam wrote:
> Hi Eduardo,
> 
> On Sun, Aug 9, 2015 at 3:19 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> > This change teaches the imx serial driver to save its
> > context and restore it across suspend and resume path.
> > To do so, it introduces serial_imx_restore_context()
> > and serial_imx_save_context() functions. They use
> > a shadow set of registers to save key registers
> > and restore them accordingly. These functions can
> > be reused on other situations, when the device
> > context is lost.
> >
> > Cc: Fabio Stevam <festevam@gmail.com>
> 
> s/Stevam/Estevam (applies to all the patches)

Sorry, my bad here.

> 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  drivers/tty/serial/imx.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index a03855d..494b182 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -217,6 +217,8 @@ struct imx_port {
> >         unsigned int            tx_bytes;
> >         unsigned int            dma_tx_nents;
> >         wait_queue_head_t       dma_wait;
> > +       unsigned int            saved_reg[8];
> > +       bool                    context_saved;
> >  };
> >
> >  struct imx_port_ucrs {
> > @@ -1803,6 +1805,36 @@ static struct uart_driver imx_reg = {
> >         .cons           = IMX_CONSOLE,
> >  };
> >
> > +static void serial_imx_restore_context(struct imx_port *sport)
> > +{
> > +       if (!sport->context_saved)
> > +               return;
> > +
> > +       writel(sport->saved_reg[4], sport->port.membase + UFCR);
> > +       writel(sport->saved_reg[5], sport->port.membase + UBIR);
> > +       writel(sport->saved_reg[6], sport->port.membase + UBMR);
> > +       writel(sport->saved_reg[7], sport->port.membase + IMX21_UTS);
> > +       writel(sport->saved_reg[0], sport->port.membase + UCR1);
> > +       writel(sport->saved_reg[1] | 0x1, sport->port.membase + UCR2);
> > +       writel(sport->saved_reg[2], sport->port.membase + UCR3);
> > +       writel(sport->saved_reg[3], sport->port.membase + UCR4);
> > +       sport->context_saved = false;
> > +}
> > +
> > +static void serial_imx_save_context(struct imx_port *sport)
> > +{
> > +       /* Save necessary regs */
> > +       sport->saved_reg[0] = readl(sport->port.membase + UCR1);
> > +       sport->saved_reg[1] = readl(sport->port.membase + UCR2);
> > +       sport->saved_reg[2] = readl(sport->port.membase + UCR3);
> > +       sport->saved_reg[3] = readl(sport->port.membase + UCR4);
> > +       sport->saved_reg[4] = readl(sport->port.membase + UFCR);
> > +       sport->saved_reg[5] = readl(sport->port.membase + UBIR);
> > +       sport->saved_reg[6] = readl(sport->port.membase + UBMR);
> > +       sport->saved_reg[7] = readl(sport->port.membase + IMX21_UTS);
> > +       sport->context_saved = true;
> > +}
> 
> This seems to be similar to what Shenwei posted earlier:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/360841.html

OK. Do you know what is the status of that patch set?

did it get accepted by any tree so far?

> 
> Regards,
> 
> Fabio Estevam
