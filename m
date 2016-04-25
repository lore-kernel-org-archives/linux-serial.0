From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] tty: serial: msm_serial regression fix data
 corruption
Date: Mon, 25 Apr 2016 15:31:17 -0700
Message-ID: <20160425223117.GM3202@tuxbot>
References: <571BAC8B.80001@gmail.com>
 <571BAD78.4020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571BAD78.4020609@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On Sat 23 Apr 10:14 PDT 2016, Frank Rowand wrote:

> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Commit 3a878c430fd6 ("tty: serial: msm: Add TX DMA support") regression.
> The calculation of tx_count was moved from the old msm_handle_tx(),
> now renamed msm_handle_tx_pio(), to the new msm_handle_tx().  The
> move left out one size test.
> 
> The regression seen on the qcom-apq8074-dragonboard is dropped
> characters and corrupted characters (values greater than 0x7f)
> when DMA is not enabled.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/msm_serial.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: b/drivers/tty/serial/msm_serial.c
> ===================================================================
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -727,6 +727,8 @@ static void msm_handle_tx(struct uart_po
>  	}
>  
>  	pio_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	pio_count = min3(pio_count, (unsigned int)UART_XMIT_SIZE - xmit->tail,

These two lines essentially reimplements CIRC_CNT_TO_END()

> +			port->fifosize);

And this looks equivalent to the removed part below.


So I think a smaller patch would be to change the calculation to:
pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);

>  	dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  
>  	dma_min = 1;	/* Always DMA */
> @@ -738,9 +740,6 @@ static void msm_handle_tx(struct uart_po
>  			dma_count = UARTDM_TX_MAX;
>  	}
>  
> -	if (pio_count > port->fifosize)
> -		pio_count = port->fifosize;
> -
>  	if (!dma->chan || dma_count < dma_min)
>  		msm_handle_tx_pio(port, pio_count);
>  	else

However, as you've concluded that the problem is that we don't handle
wrapping writes let's look at msm_handle_tx_pio():

int tf_pointer = 0;
while (tf_pointer < pio_count) {
	char buf[4];

	if (is_uartdm)
		num_chars = min(pio_count - tf_pointer,
				(unsigned int)sizeof(buf));
	else
		num_chars = 1;

	for (i = 0; i < num_chars; i++)
		buf[i] = xmit->buf[xmit->tail + i];

	xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
	tf_pointer += num_chars;
}

So the problem you seem to run into is that we copy num_chars bytes
sequentially from xmit->tail, running outside the buffer.

So the problem is that the num_chars calculation isn't limited, perhaps
something like this instead:

num_chars = min3(tx_count - tf_pointer,
		 sizeof(buf),
		 (unsigned int)CIRC_CNT_TO_END(xmit->head,
					       xmit->tail,
					       UART_XMIT_SIZE));



You should either make msm_handle_tx_pio() handle wrapping buffers or
make the pio_count calculation follow the dma case (with _TO_END).

Regards,
Bjorn
