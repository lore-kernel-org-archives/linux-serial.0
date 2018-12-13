From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] tty: serial: don't do termios for BTIF
Date: Thu, 13 Dec 2018 11:00:29 +0000
Message-ID: <20181213110029.GN30658@n2100.armlinux.org.uk>
References: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <972976519be8e28ee600651fe14d1f6d5f23e697.1544679557.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Wang <sean.wang@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org, Roy Luo <cheng-hao.luo@mediatek.com>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 13, 2018 at 02:24:03PM +0800, Ryder Lee wrote:
> The MediaTek BTIF controller doesn't need to set termios so add
> a new capability 'UART_CAP_NMOD' for the unsupported case.
> 
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250.h      | 1 +
>  drivers/tty/serial/8250/8250_port.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index ebfb0bd..2b9ba39 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -80,6 +80,7 @@ struct serial8250_config {
>  #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>  					 */
> +#define UART_CAP_NMOD	(1 << 18)	/* UART doesn't do termios */
>  
>  #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
>  #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c39482b..e4a69a0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -297,7 +297,7 @@
>  		.tx_loadsz	= 16,
>  		.fcr		= UART_FCR_ENABLE_FIFO |
>  				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> -		.flags		= UART_CAP_FIFO,
> +		.flags		= UART_CAP_FIFO | UART_CAP_NMOD,
>  	},
>  	[PORT_NPCM] = {
>  		.name		= "Nuvoton 16550",
> @@ -2663,6 +2663,11 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  	unsigned long flags;
>  	unsigned int baud, quot, frac = 0;
>  
> +	if (up->capabilities & UART_CAP_NMOD) {
> +		termios->c_cflag = 0;

So your port is limited to 5-bits and is unable to receive characters?
That's what a zero cflag means, and that's what you'll be telling
userspace here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
