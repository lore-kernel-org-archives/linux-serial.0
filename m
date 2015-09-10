From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/3] serial: samsung: remove unneded 'ignore_char' label
Date: Thu, 10 Sep 2015 09:27:44 +0900
Message-ID: <55F0CE80.3030400@samsung.com>
References: <1441705127-24125-1-git-send-email-r.baldyga@samsung.com>
 <1441705127-24125-3-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441705127-24125-3-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 08.09.2015 18:38, Robert Baldyga wrote:
> This label does nothing special and we don't need to have it anymore.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Label does nothing but it has a meaning. It serves as a comment - ignore
the character. So maybe:

-					goto ignore_char;
+					continue; /* Ignore character */

What do you think?

Best regards,
Krzysztof


> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index fee764c..2b05194 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -676,7 +676,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  				dbg("break!\n");
>  				port->icount.brk++;
>  				if (uart_handle_break(port))
> -					goto ignore_char;
> +					continue;
>  			}
>  
>  			if (uerstat & S3C2410_UERSTAT_FRAME)
> @@ -696,13 +696,10 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  		}
>  
>  		if (uart_handle_sysrq_char(port, ch))
> -			goto ignore_char;
> +			continue;
>  
>  		uart_insert_char(port, uerstat, S3C2410_UERSTAT_OVERRUN,
>  				 ch, flag);
> -
> -ignore_char:
> -		continue;
>  	}
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
> 
