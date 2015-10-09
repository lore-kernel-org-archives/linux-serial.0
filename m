From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] serial: tegra: Handle another RX race condition
Date: Fri, 9 Oct 2015 14:52:00 +0100
Message-ID: <5617C680.3070601@nvidia.com>
References: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
 <1444398602-24020-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444398602-24020-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Adding Chris to CC.

Jon

On 09/10/15 14:49, Jon Hunter wrote:
> Commit 853a699739fe ("serial: tegra: handle race condition on uart rx
> side") attempted to fix a race condition between the RX end of
> transmission interrupt and RX DMA completion callback. Despite this
> fix there is still another case where these two paths can race and
> result in duplicated data. The race condition is as follows:
> 
> 1. DMA completion interrupt occurs and schedules tasklet to call DMA
>    callback.
> 2. DMA callback for the UART driver starts to execute. This will copy
>    the data from the DMA buffer and restart the DMA. This is done under
>    uart port spinlock.
> 3. During the callback, UART interrupt is raised for end of receive. The
>    UART ISR runs and waits to acquire port spinlock held by the DMA
>    callback.
> 4. DMA callback gives up spinlock after copying the data, but before
>    restarting DMA.
> 5. UART ISR acquires the spin lock and reads the same DMA buffer because
>    DMA has not been restarted yet.
> 
> The release of the spinlock during the DMA callback was introduced by
> commit 9b88748b362c ("tty: serial: tegra: drop uart_port->lock before
> calling tty_flip_buffer_push()") to fix a spinlock lock-up issue when
> calling tty_flip_buffer_push(). However, since then commit a9c3f68f3cd8
> ("tty: Fix low_latency BUG") migrated tty_flip_buffer_push() to always
> use a workqueue, allowing tty_flip_buffer_push() to be called from
> within atomic sections. Therefore, we can remove the unlocking of the
> spinlock from the DMA callback and UART ISR and this will ensure that
> the race condition no longer occurs.
> 
> Reported-by: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/tty/serial/serial-tegra.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index cf0133ae762d..38b49f447bd7 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -607,9 +607,7 @@ static void tegra_uart_rx_dma_complete(void *args)
>  
>  	tegra_uart_handle_rx_pio(tup, port);
>  	if (tty) {
> -		spin_unlock_irqrestore(&u->lock, flags);
>  		tty_flip_buffer_push(port);
> -		spin_lock_irqsave(&u->lock, flags);
>  		tty_kref_put(tty);
>  	}
>  	tegra_uart_start_rx_dma(tup);
> @@ -622,13 +620,11 @@ done:
>  	spin_unlock_irqrestore(&u->lock, flags);
>  }
>  
> -static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
> -		unsigned long *flags)
> +static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup)
>  {
>  	struct dma_tx_state state;
>  	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
>  	struct tty_port *port = &tup->uport.state->port;
> -	struct uart_port *u = &tup->uport;
>  	unsigned int count;
>  
>  	/* Deactivate flow control to stop sender */
> @@ -645,9 +641,7 @@ static void tegra_uart_handle_rx_dma(struct tegra_uart_port *tup,
>  
>  	tegra_uart_handle_rx_pio(tup, port);
>  	if (tty) {
> -		spin_unlock_irqrestore(&u->lock, *flags);
>  		tty_flip_buffer_push(port);
> -		spin_lock_irqsave(&u->lock, *flags);
>  		tty_kref_put(tty);
>  	}
>  	tegra_uart_start_rx_dma(tup);
> @@ -714,7 +708,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
>  		iir = tegra_uart_read(tup, UART_IIR);
>  		if (iir & UART_IIR_NO_INT) {
>  			if (is_rx_int) {
> -				tegra_uart_handle_rx_dma(tup, &flags);
> +				tegra_uart_handle_rx_dma(tup);
>  				if (tup->rx_in_progress) {
>  					ier = tup->ier_shadow;
>  					ier |= (UART_IER_RLSI | UART_IER_RTOIE |
> 
