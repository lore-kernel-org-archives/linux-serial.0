From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] serial: pl011: also enable DMA Rx polling with no platform
 data
Date: Thu, 12 Dec 2013 10:18:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1312120923160.32185@axis700.grange>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
 <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chanho Min <chanho.min@lge.com>, Phil Edworthy <phil@edworthys.org>, linux-serial@vger.kernel.org, Jongsung Kim <neidhard.kim@lge.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

An addendum to this patch, that might well lead to dropping it and, 
possibly, doing the opposite - removing the DMA Rx polling completely. 
This patch was a logical continuation of the referenced below patch from 
Linus W. It doesn't make matters worse on its own, it just unifies the two 
cases - with platform data and with DT. However, after fixing other issues 
with my set up, it has been identified, that this polling is actually 
causing problems, rather than fixing any. In our set up we don't use the 
"single character DMA transfer request line," but the burst DMA request 
line, which means, a DMA request is only activated, when a watermark is 
reached. And as soon as DMA picks up data from the FIFO to drop below the 
threshold, the request line is deactivated again. This means, if less than 
a complete DMA buffer of data is received, "threshold - 1" (15 in our 
case) bytes will stay in UART FIFO, causing an Rx timeout interrupt, which 
will pick those 15 bytes up and deliver the data to the tty layer. All 
works beautifully.

Whereas with polling we get data loss and corruption. This isn't my top 
priority at the moment to investigate and fix this. Please, feel free to 
decide whether to take this patch to unify driver's behaviour with and 
without DT, or to drop it to at least give some configurations a chance to 
work correctly, or maybe someone has an idea what exactly can be going 
wrong and how to fix it.

To help a bit with looking for a fix, in one of the tests the first 4144 
bytes have been received correctly, which = 4096 (DMA buffer size) + 32 
(UART FIFO size) + 16 (half UART FIFO size). Then 45 bytes went lost (3 * 
15?), then reception resumed correctly.

Thanks
Guennadi

On Mon, 9 Dec 2013, Guennadi Liakhovetski wrote:

> An earlier patch "serial: pl011: use DMA RX polling by default" enabled
> DMA Rx polling on PL011 only in configurations, using platform data. A
> simple extension of that patch also enables DMA Rx polling when no
> platform data is used, e.g. in Device Tree configurations. In such cases
> a default poll timeout and an automatically calculated poll rate will be
> used.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/tty/serial/amba-pl011.c |   39 ++++++++++++++++++---------------------
>  1 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e593f8d..baecdfa 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -327,28 +327,25 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>  		dmaengine_slave_config(chan, &rx_conf);
>  		uap->dmarx.chan = chan;
>  
> -		if (plat) {
> -			/* Set poll rate if specified. */
> -			if (plat->dma_rx_poll_rate) {
> -				uap->dmarx.auto_poll_rate = false;
> -				uap->dmarx.poll_rate = plat->dma_rx_poll_rate;
> -			} else {
> -				/*
> -				 * 100 ms defaults to poll rate if not
> -				 * specified. This will be adjusted with
> -				 * the baud rate at set_termios.
> -				 */
> -				uap->dmarx.auto_poll_rate = true;
> -				uap->dmarx.poll_rate =  100;
> -			}
> -			/* 3 secs defaults poll_timeout if not specified. */
> -			if (plat->dma_rx_poll_timeout)
> -				uap->dmarx.poll_timeout =
> -					plat->dma_rx_poll_timeout;
> -			else
> -				uap->dmarx.poll_timeout = 3000;
> -		} else
> +		/* Set poll rate if specified. */
> +		if (plat && plat->dma_rx_poll_rate) {
>  			uap->dmarx.auto_poll_rate = false;
> +			uap->dmarx.poll_rate = plat->dma_rx_poll_rate;
> +		} else {
> +			/*
> +			 * 100 ms defaults to poll rate if not
> +			 * specified. This will be adjusted with
> +			 * the baud rate at set_termios.
> +			 */
> +			uap->dmarx.auto_poll_rate = true;
> +			uap->dmarx.poll_rate =  100;
> +		}
> +		/* 3 secs defaults poll_timeout if not specified. */
> +		if (plat && plat->dma_rx_poll_timeout)
> +			uap->dmarx.poll_timeout =
> +				plat->dma_rx_poll_timeout;
> +		else
> +			uap->dmarx.poll_timeout = 3000;
>  
>  		dev_info(uap->port.dev, "DMA channel RX %s\n",
>  			 dma_chan_name(uap->dmarx.chan));
> -- 
> 1.7.2.5
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
