From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: not call tty close in fallback
Date: Tue, 19 Feb 2019 13:41:15 +0100
Message-ID: <20190219124115.GB4867@kroah.com>
References: <5c3c3289.1c69fb81.c1953.0900SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c3c3289.1c69fb81.c1953.0900SMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yes@kroah.com
Cc: robh@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 14, 2019 at 02:56:01PM +0800, yes wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> when fail to open tty, tty is not in open status and not need
> to call close
> 
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

No, close is always called after open, even if open fails.

thanks,

greg k-h
