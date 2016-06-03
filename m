From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] tty: serial: msm: Don't read off end of tx fifo
Date: Thu, 2 Jun 2016 20:59:15 -0700
Message-ID: <57510093.5000702@gmail.com>
References: <1464914908-19059-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1464914908-19059-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Dechesne <nicolas.dechesne@linaro.org>, Ivan Ivanov <iivanov.xz@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/02/16 17:48, Bjorn Andersson wrote:
> For dm uarts in pio mode tx data is transferred to the fifo register 4
> bytes at a time, but care is not taken when these 4 bytes spans the end
> of the xmit buffer so the loop might read up to 3 bytes past the buffer
> and then skip the actual data at the beginning of the buffer.
> 
> Fix this by, analogous to the DMA case, make sure the chunk doesn't
> wrap the xmit buffer.
> 
> Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Ivan Ivanov <iivanov.xz@gmail.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: stable@vger.kernel.org
> Reported-by: Frank Rowand <frowand.list@gmail.com>
> Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index b7d80bd57db9..7d62610d9de5 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -726,7 +726,7 @@ static void msm_handle_tx(struct uart_port *port)
>  		return;
>  	}
>  
> -	pio_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	pio_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  	dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  
>  	dma_min = 1;	/* Always DMA */
> 

Thanks Bjorn.  This eliminates my symptoms on 4.6 and 4.7-rc1.

Tested-by: Frank Rowand <frank.rowand@am.sony.com>

-Frank
