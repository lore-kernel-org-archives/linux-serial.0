From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Update calculation of timeout for
 DMA
Date: Sun, 15 Mar 2015 18:30:58 +0300
Message-ID: <5505A5B2.2020600@cogentembedded.com>
References: <1426429742-3041-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426429742-3041-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 3/15/2015 5:29 PM, Yoshihiro Kaneko wrote:

> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

> The current calculation method in the case of 9600bps, rounding error occurs
> has become setting that occur timeout faster than the required time. When we
> use 9600bps, 32byte buffer, 10 bit (CS8) and 100 HZ, it becomes 3 jiffies
> (30msec). In fact it is necessary 33msec. This updates to the calculation
> that are not actually less than the value set by the rounding error.
> Also, this is nothing will be calculated value when there is no load. If there
> are a lot of case load, overrun error will occur immediately.
> This is by the buffer size to be calculated twice the DMA buffer, and add the
> change of setting a sufficient time-out value.

> Signedroff-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.

>   drivers/tty/serial/sh-sci.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5b50c79..891116c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1967,18 +1967,40 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
[...]
>   	if (s->chan_rx) {
> -		s->rx_timeout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
> -			port->fifosize / 2;
> +		unsigned int bits;
> +
> +		/* byte size and parity */
> +		switch (termios->c_cflag & CSIZE) {
> +			case CS5:

    *case* should at the same indentation level as *switch*. I guess you 
haven't run the patch thru scripts/checkpatch.pl?

> +				bits = 7;
> +				break;
> +			case CS6:
> +				bits = 8;
> +				break;
> +			case CS7:
> +				bits = 9;
> +				break;
> +			default:
> +				bits = 10;
> +				break;
> +		}
[...]

WBR, Sergei

