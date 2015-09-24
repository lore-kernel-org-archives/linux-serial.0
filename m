From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: handle rx race
Date: Thu, 24 Sep 2015 10:24:40 +0100
Message-ID: <5603C158.4000002@nvidia.com>
References: <1443051326-1979-1-git-send-email-cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443051326-1979-1-git-send-email-cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Chris,

Adding tegra maintainers ...

On 24/09/15 00:35, Christopher Freeman wrote:
> tegra_uart_rx_dma_complete (via DMA callback) and
> tegra_uart_handle_rx_dma (via uart isr) can happen concurrently.
> tegra_uart_rx_complete gives up the port lock temporarily to call
> tty_flip_buffer_push.  Since tegra_uart_start_rx_dma has not been
> called yet in that context, tegra_uart_handle_rx_dma has the chance
> to operate on the same DMA cookie.  This allows for the same DMA
> transaction to be processed twice.

I had to recall why we had these two paths in the first place. My
understanding is that the tegra_uart_rx_dma_complete() is called on
completion of the dma transfer. The tegra_uart_handle_rx_dma() is called
when we have received data but there has been a pause in the transfer,
which could be an end of transfer, so we terminate the DMA and read
whatever has been received.

Can you provide more details on the scenario? I am guessing it is
something like ...

1. EORD interrupt is triggered due to pause in data
2. ISR runs but before we terminate the DMA, more data is received and
   the DMA completes.
3. ISR races with callback and we get duplicated data. I assume that
   the ISR copies the data first.

It would be good to add a bit more details on the scenario and why we
have these two paths to the changelog.

> The solution is to postpone tty_flip_buffer_push until after the next
> DMA is started in both routines.  That way when the lock is released
> in either context, the other context will operate on a new DMA
> transaction.
> 
> Signed-off-by: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/tty/serial/serial-tegra.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index cf0133a..f9bd378 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -606,12 +606,6 @@ static void tegra_uart_rx_dma_complete(void *args)
>  	tegra_uart_copy_rx_to_tty(tup, port, count);
>  
>  	tegra_uart_handle_rx_pio(tup, port);
> -	if (tty) {
> -		spin_unlock_irqrestore(&u->lock, flags);
> -		tty_flip_buffer_push(port);
> -		spin_lock_irqsave(&u->lock, flags);
> -		tty_kref_put(tty);
> -	}
>  	tegra_uart_start_rx_dma(tup);

With this change, tegra_uart_start_rx_dma() is called within the context
of the spinlock (I am sure this is intentional). However,
tegra_uart_start_rx_dma() calls dmaengine_prep_slave_single() and this
calls tegra_dma_prep_slave_sg(). The problem is that
tegra_dma_prep_slave_sg() *may* call kzalloc() to allocate memory. The
allocation only happens if there is not a free dma descriptor available
and if tegra_dma_prep_slave_sg() has been called once, you may get lucky.

When we call dma_terminate_all() in the tegra_uart_handle_rx_dma(), this
will call tegra_dma_abort_all() (apb-dma driver) and should set the
cookie status to DMA_ERROR. Hence, I am wondering if adding the
following could work, however, that's based upon some guess work of what
the actual scenario you are seeing is, so not sure!

diff --git a/drivers/tty/serial/serial-tegra.c
b/drivers/tty/serial/serial-tegra.c
index cf0133ae762d..b80b2d1201e2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -596,6 +596,11 @@ static void tegra_uart_rx_dma_complete(void *args)
                goto done;
        }

+       if (status == DMA_ERROR) {
+               dev_dbg(tup->uport.dev, "RX DMA terminated\n");
+               goto done;
+       }
+

Cheers
Jon
