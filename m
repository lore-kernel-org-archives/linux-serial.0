From: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: handle rx race
Date: Thu, 24 Sep 2015 23:58:40 -0700
Message-ID: <20150925065840.GA13750@cfreeman-dt>
References: <1443051326-1979-1-git-send-email-cfreeman@nvidia.com>
 <5603C158.4000002@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5603C158.4000002-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Jon,

On 09-24 10:24 AM, Jon Hunter wrote:
> Hi Chris,
> 
> Adding tegra maintainers ...
> 
> On 24/09/15 00:35, Christopher Freeman wrote:
> > tegra_uart_rx_dma_complete (via DMA callback) and
> > tegra_uart_handle_rx_dma (via uart isr) can happen concurrently.
> > tegra_uart_rx_complete gives up the port lock temporarily to call
> > tty_flip_buffer_push.  Since tegra_uart_start_rx_dma has not been
> > called yet in that context, tegra_uart_handle_rx_dma has the chance
> > to operate on the same DMA cookie.  This allows for the same DMA
> > transaction to be processed twice.
> 
> I had to recall why we had these two paths in the first place. My
> understanding is that the tegra_uart_rx_dma_complete() is called on
> completion of the dma transfer. The tegra_uart_handle_rx_dma() is called
> when we have received data but there has been a pause in the transfer,
> which could be an end of transfer, so we terminate the DMA and read
> whatever has been received.
> 
> Can you provide more details on the scenario? I am guessing it is
> something like ...
> 
> 1. EORD interrupt is triggered due to pause in data
> 2. ISR runs but before we terminate the DMA, more data is received and
>    the DMA completes.
> 3. ISR races with callback and we get duplicated data. I assume that
>    the ISR copies the data first.
> 
The case is more like this:
1. DMA interrupt "completes" DMA.  Schedules tasklet to do DMA callback
2. DMA callback to uart starts to execute.  This will read data off the buffer
and restart the DMA.  This is done under spinlock.
3. Some time during this callback, UART interrupt is raised for whatever
reason, EORD or character timeout.  UART waits to acquire port spinlock.
4. DMA callback gives up spinlock after reading data, but before restarting DMA.
5. UART isr gets spin lock and now reads the same DMA buffer because DMA has not
restarted and terminate_all, etc. will operate on the values from the last DMA.

> It would be good to add a bit more details on the scenario and why we
> have these two paths to the changelog.
>

I don't know the history, but I suppose the two exist to catch every reason why
we might want to read data in.  Theoretically we don't need the DMA callback and
can just rely on character timeout interrupt to handle DMA completion.  I
removed the DMA callback just now as a test and it didn't seem to have any ill
effects.  Perhaps there's a decrease in throughput?  Maybe we should put more
consideration into that.

> > The solution is to postpone tty_flip_buffer_push until after the next
> > DMA is started in both routines.  That way when the lock is released
> > in either context, the other context will operate on a new DMA
> > transaction.
> > 
> > Signed-off-by: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> > index cf0133a..f9bd378 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -606,12 +606,6 @@ static void tegra_uart_rx_dma_complete(void *args)
> >  	tegra_uart_copy_rx_to_tty(tup, port, count);
> >  
> >  	tegra_uart_handle_rx_pio(tup, port);
> > -	if (tty) {
> > -		spin_unlock_irqrestore(&u->lock, flags);
> > -		tty_flip_buffer_push(port);
> > -		spin_lock_irqsave(&u->lock, flags);
> > -		tty_kref_put(tty);
> > -	}
> >  	tegra_uart_start_rx_dma(tup);
> 
> With this change, tegra_uart_start_rx_dma() is called within the context
> of the spinlock (I am sure this is intentional). However,
> tegra_uart_start_rx_dma() calls dmaengine_prep_slave_single() and this
> calls tegra_dma_prep_slave_sg(). The problem is that
> tegra_dma_prep_slave_sg() *may* call kzalloc() to allocate memory. The
> allocation only happens if there is not a free dma descriptor available
> and if tegra_dma_prep_slave_sg() has been called once, you may get lucky.
>
This has been the case before this change so we've been getting lucky a lot.
Noted though.

> When we call dma_terminate_all() in the tegra_uart_handle_rx_dma(), this
> will call tegra_dma_abort_all() (apb-dma driver) and should set the
> cookie status to DMA_ERROR. Hence, I am wondering if adding the
> following could work, however, that's based upon some guess work of what
> the actual scenario you are seeing is, so not sure!
> 
> diff --git a/drivers/tty/serial/serial-tegra.c
> b/drivers/tty/serial/serial-tegra.c
> index cf0133ae762d..b80b2d1201e2 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -596,6 +596,11 @@ static void tegra_uart_rx_dma_complete(void *args)
>                 goto done;
>         }
> 
> +       if (status == DMA_ERROR) {
> +               dev_dbg(tup->uport.dev, "RX DMA terminated\n");
> +               goto done;
> +       }
> +
This is actually pretty close to the first solution I came up with for the
issue.  It worked for me in all of the cases I saw. I'll paste below.

diff --git a/drivers/tty/serial/serial-tegra.c
b/drivers/tty/serial/serial-tegra.c
index a4c034d..f4ed799 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -631,11 +631,20 @@ static void tegra_uart_handle_rx_dma(struct
tegra_uart_port *tup,
        struct tty_port *port = &tup->uport.state->port;
        struct uart_port *u = &tup->uport;
        unsigned int count;
+       enum dma_status status;
 
        /* Deactivate flow control to stop sender */
        if (tup->rts_active)
                set_rts(tup, false);
 
+       status = dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+
+       if (status == DMA_COMPLETE) {
+               dev_dbg(tup->uport.dev, "DMA was complete in ISR\n");
+               tty_kref_put(tty);
+               return;
+       }
+
        dmaengine_terminate_all(tup->rx_dma_chan);
        dmaengine_tx_status(tup->rx_dma_chan,  tup->rx_cookie, &state);
        async_tx_ack(tup->rx_dma_desc);

I *think* you're right and that we should still check for DMA_ERROR in
rx_dma_complete.  I'm honestly a bit more fond of this approach so if it makes
sense then we can move forward with it instead.  But actually now I'm really
interested if we can be done with the rx_dma_complete callback completely!

>
> Cheers
> Jon
