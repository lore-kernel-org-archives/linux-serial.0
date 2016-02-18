From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: samsung: fix the inconsistency in spinlock
Date: Thu, 18 Feb 2016 09:48:25 -0800
Message-ID: <56C603E9.9050307@hurleysoftware.com>
References: <1455817202-3005-1-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455817202-3005-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Anand,

On 02/18/2016 09:40 AM, Anand Moon wrote:
> From: Anand Moon <linux.amoon@gmail.com>
> 
> changes fix the correct order of the spin_lock_irqrestore/save.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/tty/serial/samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index d72cd73..96fe14d 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -759,9 +759,9 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>  	}
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
> -		spin_unlock(&port->lock);
> +		spin_unlock_irqrestore(&port->lock, flags);
>  		uart_write_wakeup(port);
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);

This driver shouldn't be dropping the spin lock at for write wakeup.
If this is causing lock-ups in a line discipline, the line discipline
needs fixed.

Regards,
Peter Hurley


>  	}
>  
>  	if (uart_circ_empty(xmit))
> 
