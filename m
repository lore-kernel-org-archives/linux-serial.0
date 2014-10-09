From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial: 8250_mtk: Fix quot calculation
Date: Thu, 9 Oct 2014 14:52:28 -0700
Message-ID: <20141009215228.GA23507@kroah.com>
References: <1412871811-5986-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412871811-5986-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, jslaby@suse.cz, heiko@sntech.de, yingjoe.chen@gmail.com, ibanezchen@gmail.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 09, 2014 at 06:23:31PM +0200, Matthias Brugger wrote:
> The calculation of value quot for highspeed register set to three
> was wrong. This patch fixes the calculation so that the serial port
> for baudrates bigger then 576000 baud is working correctly.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 1c4b4bf..4376c48 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -81,7 +81,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>  		/* Set to highest baudrate supported */
>  		if (baud >= 1152000)
>  			baud = 921600;
> -		quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
> +		quot = (port->uartclk / (256 * baud)) + 1;
>  	}
>  
>  	/*

Has this always been incorrect, or was it caused by a specific patch?
Should it go to the stable kernels?  If so, how far back?

thanks,

greg k-h
