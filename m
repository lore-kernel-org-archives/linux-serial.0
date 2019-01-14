From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: not call tty close in fallback
Date: Mon, 14 Jan 2019 08:20:13 +0100
Message-ID: <5870cf42-415f-f24e-2e29-13affea6fc3a@suse.cz>
References: <1547448961-9588-1-git-send-email-yes>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547448961-9588-1-git-send-email-yes>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: yes@hpe.com, robh@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 14. 01. 19, 7:56, yes@hpe.com wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> when fail to open tty, tty is not in open status and not need
> to call close

But tty drivers are special and expect close even on failed open, right?
See tty_open.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index fa1672993b4c..bcc1e27d00de 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -121,7 +121,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  
>  	ret = tty->ops->open(serport->tty, NULL);
>  	if (ret)
> -		goto err_close;
> +		goto err_unlock;
>  
>  	tty_unlock(serport->tty);
>  
> @@ -142,8 +142,6 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  
>  	return 0;
>  
> -err_close:
> -	tty->ops->close(tty, NULL);
>  err_unlock:
>  	tty_unlock(tty);
>  	tty_release_struct(tty, serport->tty_idx);
> 

thanks,
-- 
js
suse labs
