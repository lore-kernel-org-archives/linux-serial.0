From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 5/7] serial: sh-sci: SCIFA/B RX FIFO software timeout
Date: Fri, 3 Feb 2017 12:18:26 +0300
Message-ID: <838736ca-1c75-5ce6-c949-6fe00ff5627f@cogentembedded.com>
References: <1486055420-31595-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1486055420-31595-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1486055420-31595-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, gregkh@linuxfoundation.org
List-Id: linux-serial@vger.kernel.org

Hello!

On 2/2/2017 8:10 PM, Ulrich Hecht wrote:

> Implements support for FIFO fill thresholds greater than one with software
> timeout.
>
> This mechanism is not possible (or at least not useful) on SCIF family
> hardware other than SCIFA and SCIFB because they do not support turning off
> the DR hardware timeout interrupt separately from the RI interrupt.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[...]
> @@ -1473,9 +1494,9 @@ static inline void sci_free_dma(struct uart_port *port)
>
>  static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
>  {
> -#ifdef CONFIG_SERIAL_SH_SCI_DMA
>  	struct uart_port *port = ptr;
>  	struct sci_port *s = to_sci_port(port);
> +#ifdef CONFIG_SERIAL_SH_SCI_DMA

    Hm, I'd expect that #ifdef moved to just before the next statement...

>
>  	if (s->chan_rx) {
>  		u16 scr = serial_port_in(port, SCSCR);
[...]
> @@ -2086,14 +2115,20 @@ static void sci_reset(struct uart_port *port)
>  		serial_port_out(port, SCLSR, status);
>  	}
>
> -	if (s->rx_trigger > 1)
> -		scif_set_rtrg(port, s->rx_trigger);
> +	if (s->rx_trigger > 1) {
> +		if (s->rx_fifo_timeout) {
> +			scif_set_rtrg(port, 1);
> +			setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
> +				    (unsigned long)s);
> +		} else
> +			scif_set_rtrg(port, s->rx_trigger);

    CodingStyle: Need {} on the *else* branch as well since *if* uses {}.

[...]

MBR, Sergei
