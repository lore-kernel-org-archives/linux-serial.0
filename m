From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] serial: amba-pl011: abstract register accessors
Date: Thu, 5 Nov 2015 20:19:15 -0500
Message-ID: <563C0013.7060607@hurleysoftware.com>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
 <1446562867-5693-2-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446562867-5693-2-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/03/2015 10:01 AM, Timur Tabi wrote:
> From: Philip Elcan <pelcan@codeaurora.org>
> 
> The SBSA variant of the PL011 is defined to have exclusively
> 32-bit wide registers, but some implementations use 8-bit
> and 16-bit accessors (ACPI DBG2 table subtype 3) and some
> implementations require 32-bit accesses (subtype 13).
> 
> To support both subtypes, the direct register accessors
> are replaced with vendor-specific calls.
> 
> Since the mechanism for determining which subtype to use does
> not yet exist, this patch itself does not introduce any
> functional change.  The 8-bit and 16-bit accessors are still
> used.
> 
> To improve code readability, local variable 'v' is set to
> uap->vendor.  For consistency, all other usage of uap->vendor
> is replaced with 'v' in the affected functions.
> 
> Finally, note that pl011_putc() is untouched, because that function
> does not have access to the 'uap' object.  A separate mechanism
> is needed to switch accessors in that function.

I'd like to see the code generation from Russell's v2 series
before reviewing this, ok?

Regards,
Peter Hurley


> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> Signed-off-by: AJ Lindell <alindell@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 304 +++++++++++++++++++++++++---------------
>  1 file changed, 194 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 164bd65..74a29f3 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -83,8 +83,26 @@ struct vendor_data {
>  	bool			fixed_options;
>  
>  	unsigned int (*get_fifosize)(struct amba_device *dev);
> +	u16 (*regreadw)(const void __iomem *addr);
> +	void (*regwritew)(u16 val, void __iomem *addr);
> +	void (*regwriteb)(u8 val, void __iomem *addr);
>  };
>  
> +static u16 pl011_readw(const void __iomem *addr)
> +{
> +	return readw(addr);
> +}
> +
> +static void pl011_writew(u16 val, void __iomem *addr)
> +{
> +	writew(val, addr);
> +}
> +
> +static void pl011_writeb(u8 val, void __iomem *addr)
> +{
> +	writeb(val, addr);
> +}
> +
>  static unsigned int get_fifosize_arm(struct amba_device *dev)
>  {
>  	return amba_rev(dev) < 3 ? 16 : 32;
> @@ -100,6 +118,9 @@ static struct vendor_data vendor_arm = {
>  	.always_enabled		= false,
>  	.fixed_options		= false,
>  	.get_fifosize		= get_fifosize_arm,
> +	.regreadw		= pl011_readw,
> +	.regwritew		= pl011_writew,
> +	.regwriteb		= pl011_writeb,
>  };
>  
>  static struct vendor_data vendor_sbsa = {
> @@ -108,6 +129,9 @@ static struct vendor_data vendor_sbsa = {
>  	.cts_event_workaround	= false,
>  	.always_enabled		= true,
>  	.fixed_options		= true,
> +	.regreadw		= pl011_readw,
> +	.regwritew		= pl011_writew,
> +	.regwriteb		= pl011_writeb,
>  };
>  
>  static unsigned int get_fifosize_st(struct amba_device *dev)
> @@ -125,6 +149,9 @@ static struct vendor_data vendor_st = {
>  	.always_enabled		= false,
>  	.fixed_options		= false,
>  	.get_fifosize		= get_fifosize_st,
> +	.regreadw		= pl011_readw,
> +	.regwritew		= pl011_writew,
> +	.regwriteb		= pl011_writeb,
>  };
>  
>  /* Deals with DMA transactions */
> @@ -191,17 +218,18 @@ struct uart_amba_port {
>   */
>  static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	u16 status;
>  	unsigned int ch, flag, max_count = 256;
>  	int fifotaken = 0;
>  
>  	while (max_count--) {
> -		status = readw(uap->port.membase + UART01x_FR);
> +		status = v->regreadw(uap->port.membase + UART01x_FR);
>  		if (status & UART01x_FR_RXFE)
>  			break;
>  
>  		/* Take chars from the FIFO and update status */
> -		ch = readw(uap->port.membase + UART01x_DR) |
> +		ch = v->regreadw(uap->port.membase + UART01x_DR) |
>  			UART_DUMMY_DR_RX;
>  		flag = TTY_NORMAL;
>  		uap->port.icount.rx++;
> @@ -427,6 +455,7 @@ static void pl011_start_tx_pio(struct uart_amba_port *uap);
>  static void pl011_dma_tx_callback(void *data)
>  {
>  	struct uart_amba_port *uap = data;
> +	const struct vendor_data *v = uap->vendor;
>  	struct pl011_dmatx_data *dmatx = &uap->dmatx;
>  	unsigned long flags;
>  	u16 dmacr;
> @@ -438,7 +467,7 @@ static void pl011_dma_tx_callback(void *data)
>  
>  	dmacr = uap->dmacr;
>  	uap->dmacr = dmacr & ~UART011_TXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  
>  	/*
>  	 * If TX DMA was disabled, it means that we've stopped the DMA for
> @@ -476,6 +505,7 @@ static void pl011_dma_tx_callback(void *data)
>   */
>  static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	struct pl011_dmatx_data *dmatx = &uap->dmatx;
>  	struct dma_chan *chan = dmatx->chan;
>  	struct dma_device *dma_dev = chan->device;
> @@ -552,7 +582,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>  	dma_dev->device_issue_pending(chan);
>  
>  	uap->dmacr |= UART011_TXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	uap->dmatx.queued = true;
>  
>  	/*
> @@ -578,6 +608,8 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
>   */
>  static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	if (!uap->using_tx_dma)
>  		return false;
>  
> @@ -588,9 +620,9 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>  	 */
>  	if (uap->dmatx.queued) {
>  		uap->dmacr |= UART011_TXDMAE;
> -		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +		v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  		uap->im &= ~UART011_TXIM;
> -		writew(uap->im, uap->port.membase + UART011_IMSC);
> +		v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  		return true;
>  	}
>  
> @@ -600,7 +632,7 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>  	 */
>  	if (pl011_dma_tx_refill(uap) > 0) {
>  		uap->im &= ~UART011_TXIM;
> -		writew(uap->im, uap->port.membase + UART011_IMSC);
> +		v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  		return true;
>  	}
>  	return false;
> @@ -612,9 +644,11 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
>   */
>  static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	if (uap->dmatx.queued) {
>  		uap->dmacr &= ~UART011_TXDMAE;
> -		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +		v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	}
>  }
>  
> @@ -628,6 +662,7 @@ static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
>   */
>  static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	u16 dmacr;
>  
>  	if (!uap->using_tx_dma)
> @@ -640,14 +675,14 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>  		if (!uap->dmatx.queued) {
>  			if (pl011_dma_tx_refill(uap) > 0) {
>  				uap->im &= ~UART011_TXIM;
> -				writew(uap->im, uap->port.membase +
> -				       UART011_IMSC);
> +				v->regwritew(uap->im,
> +					uap->port.membase + UART011_IMSC);
>  			} else
>  				ret = false;
>  		} else if (!(uap->dmacr & UART011_TXDMAE)) {
>  			uap->dmacr |= UART011_TXDMAE;
> -			writew(uap->dmacr,
> -				       uap->port.membase + UART011_DMACR);
> +			v->regwritew(uap->dmacr,
> +				uap->port.membase + UART011_DMACR);
>  		}
>  		return ret;
>  	}
> @@ -658,9 +693,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>  	 */
>  	dmacr = uap->dmacr;
>  	uap->dmacr &= ~UART011_TXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  
> -	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF) {
> +	if (v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF) {
>  		/*
>  		 * No space in the FIFO, so enable the transmit interrupt
>  		 * so we know when there is space.  Note that once we've
> @@ -669,13 +704,13 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
>  		return false;
>  	}
>  
> -	writew(uap->port.x_char, uap->port.membase + UART01x_DR);
> +	v->regwritew(uap->port.x_char, uap->port.membase + UART01x_DR);
>  	uap->port.icount.tx++;
>  	uap->port.x_char = 0;
>  
>  	/* Success - restore the DMA state */
>  	uap->dmacr = dmacr;
> -	writew(dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(dmacr, uap->port.membase + UART011_DMACR);
>  
>  	return true;
>  }
> @@ -690,6 +725,7 @@ __acquires(&uap->port.lock)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
>  	if (!uap->using_tx_dma)
>  		return;
> @@ -703,7 +739,7 @@ __acquires(&uap->port.lock)
>  			     DMA_TO_DEVICE);
>  		uap->dmatx.queued = false;
>  		uap->dmacr &= ~UART011_TXDMAE;
> -		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +		v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	}
>  }
>  
> @@ -711,6 +747,7 @@ static void pl011_dma_rx_callback(void *data);
>  
>  static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	struct dma_chan *rxchan = uap->dmarx.chan;
>  	struct pl011_dmarx_data *dmarx = &uap->dmarx;
>  	struct dma_async_tx_descriptor *desc;
> @@ -743,11 +780,11 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
>  	dma_async_issue_pending(rxchan);
>  
>  	uap->dmacr |= UART011_RXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	uap->dmarx.running = true;
>  
>  	uap->im &= ~UART011_RXIM;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  
>  	return 0;
>  }
> @@ -761,6 +798,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>  			       u32 pending, bool use_buf_b,
>  			       bool readfifo)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	struct tty_port *port = &uap->port.state->port;
>  	struct pl011_sgbuf *sgbuf = use_buf_b ?
>  		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
> @@ -805,8 +843,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>  	 */
>  	if (dma_count == pending && readfifo) {
>  		/* Clear any error flags */
> -		writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
> -		       uap->port.membase + UART011_ICR);
> +		v->regwritew(UART011_OEIS | UART011_BEIS | UART011_PEIS |
> +			UART011_FEIS, uap->port.membase + UART011_ICR);
>  
>  		/*
>  		 * If we read all the DMA'd characters, and we had an
> @@ -832,6 +870,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>  
>  static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	struct pl011_dmarx_data *dmarx = &uap->dmarx;
>  	struct dma_chan *rxchan = dmarx->chan;
>  	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
> @@ -854,7 +893,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>  
>  	/* Disable RX DMA - incoming data will wait in the FIFO */
>  	uap->dmacr &= ~UART011_RXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	uap->dmarx.running = false;
>  
>  	pending = sgbuf->sg.length - state.residue;
> @@ -874,13 +913,14 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
>  		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
>  			"fall back to interrupt mode\n");
>  		uap->im |= UART011_RXIM;
> -		writew(uap->im, uap->port.membase + UART011_IMSC);
> +		v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  	}
>  }
>  
>  static void pl011_dma_rx_callback(void *data)
>  {
>  	struct uart_amba_port *uap = data;
> +	const struct vendor_data *v = uap->vendor;
>  	struct pl011_dmarx_data *dmarx = &uap->dmarx;
>  	struct dma_chan *rxchan = dmarx->chan;
>  	bool lastbuf = dmarx->use_buf_b;
> @@ -922,7 +962,7 @@ static void pl011_dma_rx_callback(void *data)
>  		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
>  			"fall back to interrupt mode\n");
>  		uap->im |= UART011_RXIM;
> -		writew(uap->im, uap->port.membase + UART011_IMSC);
> +		v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  	}
>  }
>  
> @@ -933,9 +973,11 @@ static void pl011_dma_rx_callback(void *data)
>   */
>  static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	/* FIXME.  Just disable the DMA enable */
>  	uap->dmacr &= ~UART011_RXDMAE;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  }
>  
>  /*
> @@ -946,6 +988,7 @@ static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
>  static void pl011_dma_rx_poll(unsigned long args)
>  {
>  	struct uart_amba_port *uap = (struct uart_amba_port *)args;
> +	const struct vendor_data *v = uap->vendor;
>  	struct tty_port *port = &uap->port.state->port;
>  	struct pl011_dmarx_data *dmarx = &uap->dmarx;
>  	struct dma_chan *rxchan = uap->dmarx.chan;
> @@ -979,7 +1022,7 @@ static void pl011_dma_rx_poll(unsigned long args)
>  		spin_lock_irqsave(&uap->port.lock, flags);
>  		pl011_dma_rx_stop(uap);
>  		uap->im |= UART011_RXIM;
> -		writew(uap->im, uap->port.membase + UART011_IMSC);
> +		v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  		spin_unlock_irqrestore(&uap->port.lock, flags);
>  
>  		uap->dmarx.running = false;
> @@ -993,6 +1036,7 @@ static void pl011_dma_rx_poll(unsigned long args)
>  
>  static void pl011_dma_startup(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	int ret;
>  
>  	if (!uap->dma_probed)
> @@ -1041,16 +1085,16 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
>  skip_rx:
>  	/* Turn on DMA error (RX/TX will be enabled on demand) */
>  	uap->dmacr |= UART011_DMAONERR;
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  
>  	/*
>  	 * ST Micro variants has some specific dma burst threshold
>  	 * compensation. Set this to 16 bytes, so burst will only
>  	 * be issued above/below 16 bytes.
>  	 */
> -	if (uap->vendor->dma_threshold)
> -		writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
> -			       uap->port.membase + ST_UART011_DMAWM);
> +	if (v->dma_threshold)
> +		v->regwritew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
> +			uap->port.membase + ST_UART011_DMAWM);
>  
>  	if (uap->using_rx_dma) {
>  		if (pl011_dma_rx_trigger_dma(uap))
> @@ -1071,16 +1115,18 @@ skip_rx:
>  
>  static void pl011_dma_shutdown(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	if (!(uap->using_tx_dma || uap->using_rx_dma))
>  		return;
>  
>  	/* Disable RX and TX DMA */
> -	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
> +	while (v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
>  		cpu_relax();
>  
>  	spin_lock_irq(&uap->port.lock);
>  	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
> -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> +	v->regwritew(uap->dmacr, uap->port.membase + UART011_DMACR);
>  	spin_unlock_irq(&uap->port.lock);
>  
>  	if (uap->using_tx_dma) {
> @@ -1179,9 +1225,10 @@ static void pl011_stop_tx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
>  	uap->im &= ~UART011_TXIM;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  	pl011_dma_tx_stop(uap);
>  }
>  
> @@ -1190,8 +1237,10 @@ static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>  /* Start TX with programmed I/O only (no DMA) */
>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	uap->im |= UART011_TXIM;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  	pl011_tx_chars(uap, false);
>  }
>  
> @@ -1208,10 +1257,11 @@ static void pl011_stop_rx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
>  	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
>  		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  
>  	pl011_dma_rx_stop(uap);
>  }
> @@ -1220,9 +1270,10 @@ static void pl011_enable_ms(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
>  	uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  }
>  
>  static void pl011_rx_chars(struct uart_amba_port *uap)
> @@ -1239,10 +1290,12 @@ __acquires(&uap->port.lock)
>  	 */
>  	if (pl011_dma_rx_available(uap)) {
>  		if (pl011_dma_rx_trigger_dma(uap)) {
> +			const struct vendor_data *v = uap->vendor;
> +
>  			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
>  				"fall back to interrupt mode again\n");
>  			uap->im |= UART011_RXIM;
> -			writew(uap->im, uap->port.membase + UART011_IMSC);
> +			v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  		} else {
>  #ifdef CONFIG_DMA_ENGINE
>  			/* Start Rx DMA poll */
> @@ -1262,11 +1315,13 @@ __acquires(&uap->port.lock)
>  static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
>  			  bool from_irq)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	if (unlikely(!from_irq) &&
> -	    readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
> +	    v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
>  		return false; /* unable to transmit character */
>  
> -	writew(c, uap->port.membase + UART01x_DR);
> +	v->regwritew(c, uap->port.membase + UART01x_DR);
>  	uap->port.icount.tx++;
>  
>  	return true;
> @@ -1311,9 +1366,10 @@ static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
>  
>  static void pl011_modem_status(struct uart_amba_port *uap)
>  {
> -	unsigned int status, delta;
> -
> -	status = readw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
> +	const struct vendor_data *v = uap->vendor;
> +	unsigned int delta;
> +	unsigned int status =
> +		v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
>  
>  	delta = status ^ uap->old_status;
>  	uap->old_status = status;
> @@ -1335,40 +1391,41 @@ static void pl011_modem_status(struct uart_amba_port *uap)
>  
>  static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int dummy_read;
>  
> -	if (!uap->vendor->cts_event_workaround)
> +	if (!v->cts_event_workaround)
>  		return;
>  
>  	/* workaround to make sure that all bits are unlocked.. */
> -	writew(0x00, uap->port.membase + UART011_ICR);
> +	v->regwritew(0x00, uap->port.membase + UART011_ICR);
>  
>  	/*
>  	 * WA: introduce 26ns(1 uart clk) delay before W1C;
>  	 * single apb access will incur 2 pclk(133.12Mhz) delay,
>  	 * so add 2 dummy reads
>  	 */
> -	dummy_read = readw(uap->port.membase + UART011_ICR);
> -	dummy_read = readw(uap->port.membase + UART011_ICR);
> +	dummy_read = v->regreadw(uap->port.membase + UART011_ICR);
> +	dummy_read = v->regreadw(uap->port.membase + UART011_ICR);
>  }
>  
>  static irqreturn_t pl011_int(int irq, void *dev_id)
>  {
>  	struct uart_amba_port *uap = dev_id;
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned long flags;
>  	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
>  	u16 imsc;
>  	int handled = 0;
>  
>  	spin_lock_irqsave(&uap->port.lock, flags);
> -	imsc = readw(uap->port.membase + UART011_IMSC);
> -	status = readw(uap->port.membase + UART011_RIS) & imsc;
> +	imsc = v->regreadw(uap->port.membase + UART011_IMSC);
> +	status = v->regreadw(uap->port.membase + UART011_RIS) & imsc;
>  	if (status) {
>  		do {
>  			check_apply_cts_event_workaround(uap);
>  
> -			writew(status & ~(UART011_TXIS|UART011_RTIS|
> -					  UART011_RXIS),
> +			v->regwritew(status & ~(UART011_TXIS | UART011_RTIS | UART011_RXIS),
>  			       uap->port.membase + UART011_ICR);
>  
>  			if (status & (UART011_RTIS|UART011_RXIS)) {
> @@ -1386,7 +1443,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>  			if (pass_counter-- == 0)
>  				break;
>  
> -			status = readw(uap->port.membase + UART011_RIS) & imsc;
> +			status = v->regreadw(uap->port.membase + UART011_RIS) & imsc;
>  		} while (status != 0);
>  		handled = 1;
>  	}
> @@ -1400,7 +1457,9 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> -	unsigned int status = readw(uap->port.membase + UART01x_FR);
> +	const struct vendor_data *v = uap->vendor;
> +	unsigned int status = v->regreadw(uap->port.membase + UART01x_FR);
> +
>  	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
>  }
>  
> @@ -1408,8 +1467,9 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int result = 0;
> -	unsigned int status = readw(uap->port.membase + UART01x_FR);
> +	unsigned int status = v->regreadw(uap->port.membase + UART01x_FR);
>  
>  #define TIOCMBIT(uartbit, tiocmbit)	\
>  	if (status & uartbit)		\
> @@ -1427,9 +1487,10 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int cr;
>  
> -	cr = readw(uap->port.membase + UART011_CR);
> +	cr = v->regreadw(uap->port.membase + UART011_CR);
>  
>  #define	TIOCMBIT(tiocmbit, uartbit)		\
>  	if (mctrl & tiocmbit)		\
> @@ -1449,23 +1510,24 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	}
>  #undef TIOCMBIT
>  
> -	writew(cr, uap->port.membase + UART011_CR);
> +	v->regwritew(cr, uap->port.membase + UART011_CR);
>  }
>  
>  static void pl011_break_ctl(struct uart_port *port, int break_state)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned long flags;
>  	unsigned int lcr_h;
>  
>  	spin_lock_irqsave(&uap->port.lock, flags);
> -	lcr_h = readw(uap->port.membase + uap->lcrh_tx);
> +	lcr_h = v->regreadw(uap->port.membase + uap->lcrh_tx);
>  	if (break_state == -1)
>  		lcr_h |= UART01x_LCRH_BRK;
>  	else
>  		lcr_h &= ~UART01x_LCRH_BRK;
> -	writew(lcr_h, uap->port.membase + uap->lcrh_tx);
> +	v->regwritew(lcr_h, uap->port.membase + uap->lcrh_tx);
>  	spin_unlock_irqrestore(&uap->port.lock, flags);
>  }
>  
> @@ -1475,9 +1537,10 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned char __iomem *regs = uap->port.membase;
>  
> -	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
> +	v->regwritew(v->regreadw(regs + UART011_MIS), regs + UART011_ICR);
>  	/*
>  	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
>  	 * we simply mask it. start_tx() will unmask it.
> @@ -1491,13 +1554,15 @@ static void pl011_quiesce_irqs(struct uart_port *port)
>  	 * (including tx queue), so we're also fine with start_tx()'s caller
>  	 * side.
>  	 */
> -	writew(readw(regs + UART011_IMSC) & ~UART011_TXIM, regs + UART011_IMSC);
> +	v->regwritew(v->regreadw(regs + UART011_IMSC) & ~UART011_TXIM,
> +		regs + UART011_IMSC);
>  }
>  
>  static int pl011_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int status;
>  
>  	/*
> @@ -1506,11 +1571,11 @@ static int pl011_get_poll_char(struct uart_port *port)
>  	 */
>  	pl011_quiesce_irqs(port);
>  
> -	status = readw(uap->port.membase + UART01x_FR);
> +	status = v->regreadw(uap->port.membase + UART01x_FR);
>  	if (status & UART01x_FR_RXFE)
>  		return NO_POLL_CHAR;
>  
> -	return readw(uap->port.membase + UART01x_DR);
> +	return v->regreadw(uap->port.membase + UART01x_DR);
>  }
>  
>  static void pl011_put_poll_char(struct uart_port *port,
> @@ -1518,11 +1583,12 @@ static void pl011_put_poll_char(struct uart_port *port,
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
> -	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
> +	while (v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
>  		cpu_relax();
>  
> -	writew(ch, uap->port.membase + UART01x_DR);
> +	v->regwritew(ch, uap->port.membase + UART01x_DR);
>  }
>  
>  #endif /* CONFIG_CONSOLE_POLL */
> @@ -1531,6 +1597,7 @@ static int pl011_hwinit(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	int retval;
>  
>  	/* Optionaly enable pins to be muxed in and configured */
> @@ -1546,15 +1613,15 @@ static int pl011_hwinit(struct uart_port *port)
>  	uap->port.uartclk = clk_get_rate(uap->clk);
>  
>  	/* Clear pending error and receive interrupts */
> -	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
> -	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
> +	v->regwritew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
> +		UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
>  
>  	/*
>  	 * Save interrupts enable mask, and enable RX interrupts in case if
>  	 * the interrupt is used for NMI entry.
>  	 */
> -	uap->im = readw(uap->port.membase + UART011_IMSC);
> -	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
> +	uap->im = v->regreadw(uap->port.membase + UART011_IMSC);
> +	v->regwritew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
>  
>  	if (dev_get_platdata(uap->port.dev)) {
>  		struct amba_pl011_data *plat;
> @@ -1568,7 +1635,9 @@ static int pl011_hwinit(struct uart_port *port)
>  
>  static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  {
> -	writew(lcr_h, uap->port.membase + uap->lcrh_rx);
> +	const struct vendor_data *v = uap->vendor;
> +
> +	v->regwritew(lcr_h, uap->port.membase + uap->lcrh_rx);
>  	if (uap->lcrh_rx != uap->lcrh_tx) {
>  		int i;
>  		/*
> @@ -1576,14 +1645,16 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  		 * to get this delay write read only register 10 times
>  		 */
>  		for (i = 0; i < 10; ++i)
> -			writew(0xff, uap->port.membase + UART011_MIS);
> -		writew(lcr_h, uap->port.membase + uap->lcrh_tx);
> +			v->regwritew(0xff, uap->port.membase + UART011_MIS);
> +		v->regwritew(lcr_h, uap->port.membase + uap->lcrh_tx);
>  	}
>  }
>  
>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>  {
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	const struct vendor_data *v = uap->vendor;
> +
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  
>  	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
>  }
> @@ -1595,15 +1666,16 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
>   */
>  static void pl011_enable_interrupts(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	spin_lock_irq(&uap->port.lock);
>  
>  	/* Clear out any spuriously appearing RX interrupts */
> -	writew(UART011_RTIS | UART011_RXIS,
> -	       uap->port.membase + UART011_ICR);
> +	v->regwritew(UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
>  	uap->im = UART011_RTIM;
>  	if (!pl011_dma_rx_running(uap))
>  		uap->im |= UART011_RXIM;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
>  	spin_unlock_irq(&uap->port.lock);
>  }
>  
> @@ -1611,6 +1683,7 @@ static int pl011_startup(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int cr;
>  	int retval;
>  
> @@ -1622,21 +1695,22 @@ static int pl011_startup(struct uart_port *port)
>  	if (retval)
>  		goto clk_dis;
>  
> -	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
> +	v->regwritew(v->ifls, uap->port.membase + UART011_IFLS);
>  
>  	spin_lock_irq(&uap->port.lock);
>  
>  	/* restore RTS and DTR */
>  	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
>  	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
> -	writew(cr, uap->port.membase + UART011_CR);
> +	v->regwritew(cr, uap->port.membase + UART011_CR);
>  
>  	spin_unlock_irq(&uap->port.lock);
>  
>  	/*
>  	 * initialise the old status of the modem signals
>  	 */
> -	uap->old_status = readw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
> +	uap->old_status =
> +		v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
>  
>  	/* Startup DMA */
>  	pl011_dma_startup(uap);
> @@ -1675,11 +1749,12 @@ static int sbsa_uart_startup(struct uart_port *port)
>  static void pl011_shutdown_channel(struct uart_amba_port *uap,
>  					unsigned int lcrh)
>  {
> -      unsigned long val;
> +	const struct vendor_data *v = uap->vendor;
> +	unsigned long val;
>  
> -      val = readw(uap->port.membase + lcrh);
> -      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
> -      writew(val, uap->port.membase + lcrh);
> +	val = v->regreadw(uap->port.membase + lcrh);
> +	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
> +	v->regwritew(val, uap->port.membase + lcrh);
>  }
>  
>  /*
> @@ -1689,15 +1764,16 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
>   */
>  static void pl011_disable_uart(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int cr;
>  
>  	uap->autorts = false;
>  	spin_lock_irq(&uap->port.lock);
> -	cr = readw(uap->port.membase + UART011_CR);
> +	cr = v->regreadw(uap->port.membase + UART011_CR);
>  	uap->old_cr = cr;
>  	cr &= UART011_CR_RTS | UART011_CR_DTR;
>  	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
> -	writew(cr, uap->port.membase + UART011_CR);
> +	v->regwritew(cr, uap->port.membase + UART011_CR);
>  	spin_unlock_irq(&uap->port.lock);
>  
>  	/*
> @@ -1710,12 +1786,14 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
>  
>  static void pl011_disable_interrupts(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
> +
>  	spin_lock_irq(&uap->port.lock);
>  
>  	/* mask all interrupts and clear all pending ones */
>  	uap->im = 0;
> -	writew(uap->im, uap->port.membase + UART011_IMSC);
> -	writew(0xffff, uap->port.membase + UART011_ICR);
> +	v->regwritew(uap->im, uap->port.membase + UART011_IMSC);
> +	v->regwritew(0xffff, uap->port.membase + UART011_ICR);
>  
>  	spin_unlock_irq(&uap->port.lock);
>  }
> @@ -1803,11 +1881,12 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int lcr_h, old_cr;
>  	unsigned long flags;
>  	unsigned int baud, quot, clkdiv;
>  
> -	if (uap->vendor->oversampling)
> +	if (v->oversampling)
>  		clkdiv = 8;
>  	else
>  		clkdiv = 16;
> @@ -1867,8 +1946,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  		pl011_enable_ms(port);
>  
>  	/* first, disable everything */
> -	old_cr = readw(port->membase + UART011_CR);
> -	writew(0, port->membase + UART011_CR);
> +	old_cr = v->regreadw(port->membase + UART011_CR);
> +	v->regwritew(0, port->membase + UART011_CR);
>  
>  	if (termios->c_cflag & CRTSCTS) {
>  		if (old_cr & UART011_CR_RTS)
> @@ -1881,7 +1960,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  		uap->autorts = false;
>  	}
>  
> -	if (uap->vendor->oversampling) {
> +	if (v->oversampling) {
>  		if (baud > port->uartclk / 16)
>  			old_cr |= ST_UART011_CR_OVSFACT;
>  		else
> @@ -1894,15 +1973,15 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 * to avoid delayed sampling of start bit at high speeds,
>  	 * else we see data corruption.
>  	 */
> -	if (uap->vendor->oversampling) {
> +	if (v->oversampling) {
>  		if ((baud >= 3000000) && (baud < 3250000) && (quot > 1))
>  			quot -= 1;
>  		else if ((baud > 3250000) && (quot > 2))
>  			quot -= 2;
>  	}
>  	/* Set baud rate */
> -	writew(quot & 0x3f, port->membase + UART011_FBRD);
> -	writew(quot >> 6, port->membase + UART011_IBRD);
> +	v->regwritew(quot & 0x3f, port->membase + UART011_FBRD);
> +	v->regwritew(quot >> 6, port->membase + UART011_IBRD);
>  
>  	/*
>  	 * ----------v----------v----------v----------v-----
> @@ -1911,7 +1990,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 * ----------^----------^----------^----------^-----
>  	 */
>  	pl011_write_lcr_h(uap, lcr_h);
> -	writew(old_cr, port->membase + UART011_CR);
> +	v->regwritew(old_cr, port->membase + UART011_CR);
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
> @@ -2051,16 +2130,18 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> +	const struct vendor_data *v = uap->vendor;
>  
> -	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
> +	while (v->regreadw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
>  		cpu_relax();
> -	writew(ch, uap->port.membase + UART01x_DR);
> +	v->regwritew(ch, uap->port.membase + UART01x_DR);
>  }
>  
>  static void
>  pl011_console_write(struct console *co, const char *s, unsigned int count)
>  {
>  	struct uart_amba_port *uap = amba_ports[co->index];
> +	const struct vendor_data *v = uap->vendor;
>  	unsigned int status, old_cr = 0, new_cr;
>  	unsigned long flags;
>  	int locked = 1;
> @@ -2078,11 +2159,11 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>  	/*
>  	 *	First save the CR then disable the interrupts
>  	 */
> -	if (!uap->vendor->always_enabled) {
> -		old_cr = readw(uap->port.membase + UART011_CR);
> +	if (!v->always_enabled) {
> +		old_cr = v->regreadw(uap->port.membase + UART011_CR);
>  		new_cr = old_cr & ~UART011_CR_CTSEN;
>  		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
> -		writew(new_cr, uap->port.membase + UART011_CR);
> +		v->regwritew(new_cr, uap->port.membase + UART011_CR);
>  	}
>  
>  	uart_console_write(&uap->port, s, count, pl011_console_putchar);
> @@ -2092,11 +2173,11 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>  	 *	and restore the TCR
>  	 */
>  	do {
> -		status = readw(uap->port.membase + UART01x_FR);
> +		status = v->regreadw(uap->port.membase + UART01x_FR);
>  		cpu_relax();
>  	} while (status & UART01x_FR_BUSY);
> -	if (!uap->vendor->always_enabled)
> -		writew(old_cr, uap->port.membase + UART011_CR);
> +	if (!v->always_enabled)
> +		v->regwritew(old_cr, uap->port.membase + UART011_CR);
>  
>  	if (locked)
>  		spin_unlock(&uap->port.lock);
> @@ -2109,10 +2190,12 @@ static void __init
>  pl011_console_get_options(struct uart_amba_port *uap, int *baud,
>  			     int *parity, int *bits)
>  {
> -	if (readw(uap->port.membase + UART011_CR) & UART01x_CR_UARTEN) {
> +	const struct vendor_data *v = uap->vendor;
> +
> +	if (v->regreadw(uap->port.membase + UART011_CR) & UART01x_CR_UARTEN) {
>  		unsigned int lcr_h, ibrd, fbrd;
>  
> -		lcr_h = readw(uap->port.membase + uap->lcrh_tx);
> +		lcr_h = v->regreadw(uap->port.membase + uap->lcrh_tx);
>  
>  		*parity = 'n';
>  		if (lcr_h & UART01x_LCRH_PEN) {
> @@ -2127,14 +2210,14 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
>  		else
>  			*bits = 8;
>  
> -		ibrd = readw(uap->port.membase + UART011_IBRD);
> -		fbrd = readw(uap->port.membase + UART011_FBRD);
> +		ibrd = v->regreadw(uap->port.membase + UART011_IBRD);
> +		fbrd = v->regreadw(uap->port.membase + UART011_FBRD);
>  
>  		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
>  
> -		if (uap->vendor->oversampling) {
> -			if (readw(uap->port.membase + UART011_CR)
> -				  & ST_UART011_CR_OVSFACT)
> +		if (v->oversampling) {
> +			if (v->regreadw(uap->port.membase + UART011_CR) &
> +			    ST_UART011_CR_OVSFACT)
>  				*baud *= 2;
>  		}
>  	}
> @@ -2332,11 +2415,12 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
>  
>  static int pl011_register_port(struct uart_amba_port *uap)
>  {
> +	const struct vendor_data *v = uap->vendor;
>  	int ret;
>  
>  	/* Ensure interrupts from this UART are masked and cleared */
> -	writew(0, uap->port.membase + UART011_IMSC);
> -	writew(0xffff, uap->port.membase + UART011_ICR);
> +	v->regwritew(0, uap->port.membase + UART011_IMSC);
> +	v->regwritew(0xffff, uap->port.membase + UART011_ICR);
>  
>  	if (!amba_reg.state) {
>  		ret = uart_register_driver(&amba_reg);
> 
