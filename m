From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mxs-auart: count FIFO overrun errors
Date: Wed, 16 Nov 2016 10:57:53 +0100
Message-ID: <20161116095753.GA4947@kroah.com>
References: <1479207929.4985.25.camel@reccoware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479207929.4985.25.camel@reccoware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Ocker <weo@reccoware.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 15, 2016 at 12:05:29PM +0100, Wolfgang Ocker wrote:
> The mxs-auart driver does not count FIFO overrun errors. These errors never
> appear in /proc/tty/driver/ttyAPP. This is because the OERR status bit is
> masked by read_status_mask in the rx interrupt function, but the
> AUART_STAT_OERR bit is never set in read_status_mask. The patch enables the
> counting of overrun errors.
> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---
>  drivers/tty/serial/mxs-auart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 770454e0dfa3..8c1c9112b3fd 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1016,7 +1016,7 @@ static void mxs_auart_settermios(struct uart_port *u,
>  			ctrl |= AUART_LINECTRL_EPS;
>  	}
>  
> -	u->read_status_mask = 0;
> +	u->read_status_mask = AUART_STAT_OERR;
>  
>  	if (termios->c_iflag & INPCK)
>  		u->read_status_mask |= AUART_STAT_PERR;
> -- 
> 2.10.0

This patch is corrupted and can not be applied, what did you do here?

Please fix up and resend.

thanks,

greg k-h
