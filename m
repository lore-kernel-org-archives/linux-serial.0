From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/4] TTY: serial, fix locking imbalance
Date: Thu, 22 Sep 2011 20:30:02 +0200
Message-ID: <4E7B7EAA.50706@gmail.com>
References: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45779 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1IVSaI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Sep 2011 14:30:08 -0400
In-Reply-To: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/31/2011 09:24 PM, Jiri Slaby wrote:
> Commit "TTY: serial, move locking in uart_close" moved the lock, but
> omitted to update branches which unlock the lock. Now they try to
> unlock the lock without holding it.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> If possible, please, merge this into the patch mentioned above (it's
> not upstream yet).

Hi Greg, should I resend these?

>  drivers/tty/serial/serial_core.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 5c04cb9..c0fdbc5 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1262,7 +1262,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  
>  	if (tty_hung_up_p(filp)) {
>  		spin_unlock_irqrestore(&port->lock, flags);
> -		goto done;
> +		return;
>  	}
>  
>  	if ((tty->count == 1) && (port->count != 1)) {
> @@ -1284,7 +1284,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  	}
>  	if (port->count) {
>  		spin_unlock_irqrestore(&port->lock, flags);
> -		goto done;
> +		return;
>  	}
>  
>  	/*
> @@ -1347,7 +1347,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  	wake_up_interruptible(&port->open_wait);
>  	wake_up_interruptible(&port->close_wait);
>  
> -done:
>  	mutex_unlock(&port->mutex);
>  }
>  


-- 
js
