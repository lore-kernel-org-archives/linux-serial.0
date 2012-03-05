From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 01/68] USB: cdc-acm, use tty_standard_install
Date: Mon, 05 Mar 2012 15:03:41 +0100
Message-ID: <4F54C7BD.1020105@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz> <1330955575-26641-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-2-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.name>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Forgot to CC maintainers. Done now.

On 03/05/2012 02:51 PM, Jiri Slaby wrote:
> This is a piece I missed the last time.
> 
> Do not copy the functionality all over the tree. Instead, use the
> helper the tty layer provides us with.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/usb/class/cdc-acm.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 6dcc3a3..b3fd449 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -509,17 +509,12 @@ static int acm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>  	if (!acm)
>  		return -ENODEV;
>  
> -	retval = tty_init_termios(tty);
> +	retval = tty_standard_install(driver, tty);
>  	if (retval)
>  		goto error_init_termios;
>  
>  	tty->driver_data = acm;
>  
> -	/* Final install (we use the default method) */
> -	tty_driver_kref_get(driver);
> -	tty->count++;
> -	driver->ttys[tty->index] = tty;
> -
>  	return 0;
>  
>  error_init_termios:


-- 
js
suse labs
