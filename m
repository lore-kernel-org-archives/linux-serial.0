From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] serial: sh-sci: Fix hang in sci_reset()
Date: Fri, 06 Jan 2017 14:31:28 +0200
Message-ID: <52992122.70bgT4fDeQ@avalon>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be> <1480682111-9299-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480682111-9299-3-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 02 Dec 2016 13:35:11 Geert Uytterhoeven wrote:
> When the .set_termios() callback resets the UART, it first waits until
> all characters in the transmit FIFO have been transmitted, to prevent a
> port configuration change from impacting these characters.
> 
> However, if the previous user of the UART had dedicated RTS/CTS hardware
> flow control enabled, these characters may have been stuck in the FIFO
> due to CTS not being asserted. When the new user opens the port,
> .set_termios() is called while transmission is still disabled, leading
> to an infinite loop:
> 
>     NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
> 
> This has been observed with SCIFA (on r8a7740/armadillo) and SCIFB (on
> r8a7791/koelsch).
> 
> The issue does not seem to happen when using:
>   - GPIO RTS/CTS hardware flow control,
>   - No hardware flow control,
>   - HSCIF (on r8a7791/koelsch).
> 
> To fix this, wait for the draining of the transmit FIFO only if
> transmission is already enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To reproduce:
> 
>     stty -echo < /dev/scifb0
>     stty crtscts < /dev/scifb0
>     echo hello > /dev/scifb0	# returns early (wrote to FIFO)
>     echo hello > /dev/scifb0	# hangs
> 
>  drivers/tty/serial/sh-sci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index c503db1900f003ed..db5de80c5399a7bd 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2137,9 +2137,11 @@ static void sci_reset(struct uart_port *port)
>  	const struct plat_sci_reg *reg;
>  	unsigned int status;
> 
> -	do {
> -		status = serial_port_in(port, SCxSR);
> -	} while (!(status & SCxSR_TEND(port)));
> +	if (serial_port_in(port, SCSCR) & SCSCR_TE) {
> +		do {
> +			status = serial_port_in(port, SCxSR);
> +		} while (!(status & SCxSR_TEND(port)));

Won't we still loop forever if the remote side never asserts CTS ?

> +	}
> 
>  	serial_port_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */

-- 
Regards,

Laurent Pinchart
