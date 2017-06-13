From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V3 1/7] tty: serial: lpuart: introduce lpuart_soc_data to
 represent SoC property
Date: Tue, 13 Jun 2017 10:28:48 +0800
Message-ID: <20170613022848.GA15770@b29396-OptiPlex-7040>
References: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
 <1497281848-12995-2-git-send-email-aisheng.dong@nxp.com>
 <CAHp75Vdi8_cxkVuwnvBo7TmceMuA1n1mUg+D5v3xN4ck67MTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vdi8_cxkVuwnvBo7TmceMuA1n1mUg+D5v3xN4ck67MTMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Mingkai Hu <Mingkai.Hu@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 12, 2017 at 08:49:36PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2017 at 6:37 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> > This is used to dynamically check the SoC specific lpuart properies.
> > Currently only the iotype is added, it functions the same as before.
> > With this, new chips with different iotype will be more easily added.
> 
> 
> > +struct lpuart_soc_data {
> > +       char    iotype;
> > +};
> > +
> > +static const struct lpuart_soc_data vf_data = {
> > +       .iotype = UPIO_MEM,
> > +};
> > +
> > +static const struct lpuart_soc_data ls_data = {
> > +       .iotype = UPIO_MEM32BE,
> 
> > +
> 
> Redundant.

My mistake to introduce one more extra blank line...

> 
> > +};
> 
> And now most interesting part...
> 
> > -               if (sport->lpuart32)
> > +               if (sport->port.iotype & UPIO_MEM32BE)
> >                         lpuart32_write(sport->port.x_char, sport->port.membase + UARTDATA);
> >                 else
> >                         writeb(sport->port.x_char, sport->port.membase + UARTDR);
> 
> > -               if (sport->lpuart32)
> > +               if (sport->port.iotype & UPIO_MEM32BE)
> >                         lpuart32_stop_tx(&sport->port);
> >                 else
> >                         lpuart_stop_tx(&sport->port);
> 
> > -       if (sport->lpuart32)
> > +       if (sport->port.iotype & UPIO_MEM32BE)
> >                 lpuart32_transmit_buffer(sport);
> >         else
> >                 lpuart_transmit_buffer(sport);
> 
> > -               if (sport->lpuart32)
> > +               if (sport->port.iotype & UPIO_MEM32BE)
> >                         lpuart32_console_get_options(sport, &baud, &parity, &bits);
> >                 else
> >                         lpuart_console_get_options(sport, &baud, &parity, &bits);
> 
> > -       if (sport->lpuart32)
> > +       if (sport->port.iotype & UPIO_MEM32BE)
> >                 lpuart32_setup_watermark(sport);
> >         else
> >                 lpuart_setup_watermark(sport);
> 
> > -       if (sport->lpuart32)
> > +       sport->port.iotype = sdata->iotype;
> > +       if (sport->port.iotype & UPIO_MEM32BE)
> >                 sport->port.ops = &lpuart32_pops;
> >         else
> >                 sport->port.ops = &lpuart_pops;
> 
> > -       if (sport->lpuart32)
> > +       if (sport->port.iotype & UPIO_MEM32BE)
> >                 lpuart_reg.cons = LPUART32_CONSOLE;
> >         else
> >                 lpuart_reg.cons = LPUART_CONSOLE;
> 
> ...all above since you introduced nice struct, can get rid of conditionals.
> Instead it might be a members of the struct above.
> 
> (I dunno if it's good to have in this patch, but at list a follow up
> could be nice to have)
> 

Yes, to clean up all conditionals, much more things need to be done,
so a separate follow up patch may be better.

This patch only address iotype which is just the same as before.

> > -       if (sport->lpuart32) {
> > +       if (sport->port.iotype & UPIO_MEM32BE) {
> >                 /* disable Rx/Tx and interrupts */
> >                 temp = lpuart32_read(sport->port.membase + UARTCTRL);
> >                 temp &= ~(UARTCTRL_TE | UARTCTRL_TIE | UARTCTRL_TCIE);
> 
> > -       if (sport->lpuart32) {
> > +       if (sport->port.iotype & UPIO_MEM32BE) {
> >                 lpuart32_setup_watermark(sport);
> >                 temp = lpuart32_read(sport->port.membase + UARTCTRL);
> >                 temp |= (UARTCTRL_RIE | UARTCTRL_TIE | UARTCTRL_RE |
> 
> Above are questionable, might be not need to convert them.
> 
> So, in any case above is a sighting which you could address (separately).

Yes, seems not a easy convert which can be investigated later.

Thanks for the review.

Regards
Dong Aisheng

> 
> -- 
> With Best Regards,
> Andy Shevchenko
