From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] pch_uart: remove set but not used variable 'tx_empty'
Date: Mon, 29 Oct 2018 08:52:58 +0100
Message-ID: <dae7fa7e-5e74-b5c4-f049-a8f7691d1a20@suse.cz>
References: <1540300894-27202-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540300894-27202-1-git-send-email-zhongjiang@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 23. 10. 18, 15:21, zhong jiang wrote:
> tx_empty is not used after setting its value. It is safe to remove
> the unused variable.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Jiri Slaby <jslaby@suse.cz>

> ---
>  drivers/tty/serial/pch_uart.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index cb85002..9ed121f 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -933,7 +933,6 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  	struct scatterlist *sg;
>  	int nent;
>  	int fifo_size;
> -	int tx_empty;
>  	struct dma_async_tx_descriptor *desc;
>  	int num;
>  	int i;
> @@ -958,11 +957,9 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>  	}
>  
>  	fifo_size = max(priv->fifo_size, 1);
> -	tx_empty = 1;
>  	if (pop_tx_x(priv, xmit->buf)) {
>  		pch_uart_hal_write(priv, xmit->buf, 1);
>  		port->icount.tx++;
> -		tx_empty = 0;
>  		fifo_size--;
>  	}
>  
> 

thanks,
-- 
js
suse labs
