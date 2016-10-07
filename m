From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix Tx DMA edge case
Date: Fri, 07 Oct 2016 11:06:25 -0700
Message-ID: <a93b300237eef1e9a02f680e96449504@agner.ch>
References: <1475791984-17705-1-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475791984-17705-1-git-send-email-aaron.brice@datasoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Brice <aaron.brice@datasoft.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, bhuvanchandra.dv@toradex.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2016-10-06 15:13, Aaron Brice wrote:
> In the case where head == 0 on the circular buffer, there should be one
> DMA buffer, not two.  The second zero-length buffer would break the
> lpuart driver, transfer would never complete.

That looks right, and seems to work fine here:

Acked-by: Stefan Agner <stefan@agner.ch>
Tested-by: Stefan Agner <stefan@agner.ch>

@Greg, would be good if this would still make it into 4.9.

--
Stefan

> 
> Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index de9d510..76103f2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -328,7 +328,7 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  
>  	sport->dma_tx_bytes = uart_circ_chars_pending(xmit);
>  
> -	if (xmit->tail < xmit->head) {
> +	if (xmit->tail < xmit->head || xmit->head == 0) {
>  		sport->dma_tx_nents = 1;
>  		sg_init_one(sgl, xmit->buf + xmit->tail, sport->dma_tx_bytes);
>  	} else {
> @@ -359,7 +359,6 @@ static void lpuart_dma_tx(struct lpuart_port *sport)
>  	sport->dma_tx_in_progress = true;
>  	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
>  	dma_async_issue_pending(sport->dma_tx_chan);
> -
>  }
>  
>  static void lpuart_dma_tx_complete(void *arg)
