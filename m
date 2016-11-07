From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] serial: sirf: Simplify a test
Date: Mon, 7 Nov 2016 18:19:45 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1611071816140.3128@hadrien>
References: <20161101070333.12255-1-christophe.jaillet@wanadoo.fr> <2916662.De1FDumaQl@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <2916662.De1FDumaQl@wuerfel>
Sender: kernel-janitors-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, gregkh@linuxfoundation.org, jslaby@suse.com, baohua@kernel.org, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On Mon, 7 Nov 2016, Arnd Bergmann wrote:

> On Tuesday, November 1, 2016 8:03:33 AM CET Christophe JAILLET wrote:
> > 'dmaengine_prep_dma_cyclic()' does not return an error pointer, so the test
> > can be simplified to be more consistent.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> The change looks correct in principle. It would be good to automate looking
> for other instances of this bug. How did you find it? Do you have e.g. a
> coccinelle script or did you just stumble over the issue by accident?

I'm working on collecting this information in a more general way.  It is
complicated by the fact that there are some functions that have the same
names but different behaviors, and I want to be clear about when that is
an issue.  There are nevertheless limits to the accuracy that can be
obtained with Coccinelle, because Coccinelle doesn't take values into
account.  Sometimes a variable is initialized to NULL, just to have a
starting value, but in practice the only way to reach an error return is
via conditionals that have the effect of ensuring that the value is
ERR_PTR.  So at least the cases that are reported as being able to return
both NULL and ERR_PTR will need some careful checking.

julia

>
> There is one problem with your patch:
>
> >  drivers/tty/serial/sirfsoc_uart.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> > index b186c9c4f850..666ca3156961 100644
> > --- a/drivers/tty/serial/sirfsoc_uart.c
> > +++ b/drivers/tty/serial/sirfsoc_uart.c
> > @@ -609,7 +609,7 @@ static void sirfsoc_uart_start_next_rx_dma(struct uart_port *port)
> >                 sirfport->rx_dma_items.dma_addr, SIRFSOC_RX_DMA_BUF_SIZE,
> >                 SIRFSOC_RX_DMA_BUF_SIZE / 2,
> >                 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> > -       if (IS_ERR_OR_NULL(sirfport->rx_dma_items.desc)) {
> > +       if (!sirfport->rx_dma_items.desc) {
> >                 dev_err(port->dev, "DMA slave single fail\n");
> >                 return;
> >         }
>
> The serial driver is for the sirf platform, which uses the sirf-dma
> dmaengine driver, and that particular driver has an incorrect
> dma_prep_cyclic implementation, so I think we also need this fix:
>
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 8f62edad51be..220c611c89ae 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -775,7 +775,7 @@ sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
>  	 * BUFB
>  	 */
>  	if (buf_len !=  2 * period_len)
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>
>  	/* Get free descriptor */
>  	spin_lock_irqsave(&schan->lock, iflags);
>
>
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
