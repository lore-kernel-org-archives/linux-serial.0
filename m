From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under
 IGNPAR option
Date: Mon, 17 Aug 2015 11:49:43 -0400
Message-ID: <55D20297.6010500@hurleysoftware.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com> <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Anirudha Sarangi <anirudha.sarangi@xilinx.com>, =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 08/17/2015 03:22 AM, Michal Simek wrote:
> From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> 
> The existing implementation includes overrun errors under IGNPAR
> option. This patch fixes it by including only parity and framing
> error under IGNPAR option.

The convention adopted by Linux serial drivers is to ignore overrun
errors if both IGNPAR and IGNBRK are set.

Regards,
Peter Hurley

> Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index a3020344ac9d..c4437e8929ff 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -691,7 +691,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  
>  	if (termios->c_iflag & IGNPAR)
>  		port->ignore_status_mask |= CDNS_UART_IXR_PARITY |
> -			CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN;
> +					    CDNS_UART_IXR_FRAMING;
>  
>  	/* ignore all characters if CREAD is not set */
>  	if ((termios->c_cflag & CREAD) == 0)
> 
