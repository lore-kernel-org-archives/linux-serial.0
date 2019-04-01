From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] serial: sh-sci: Fix HSCIF RX sampling point calculation
Date: Mon, 1 Apr 2019 17:42:17 +0530
Message-ID: <3361fcd0-12e6-aaf8-33c2-54a99bac1900@codeaurora.org>
References: <20190401112510.23145-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401112510.23145-1-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 4/1/2019 4:55 PM, Geert Uytterhoeven wrote:
> There are several issues with the formula used for calculating the
> deviation from the intended rate:
>    1. While min_err and last_stop are signed, srr and baud are unsigned.
>       Hence the signed values are promoted to unsigned, which will lead
>       to a bogus value of deviation if min_err is negative,
>    2. Srr is the register field value, which is one less than the actual
>       sampling rate factor,
>    3. The divisions do not use rounding.
>
> Fix this by casting unsigned variables to int, adding one to srr, and
> using a single DIV_ROUND_CLOSEST().
>
> Fixes: 63ba1e00f178a448 ("serial: sh-sci: Support for HSCIF RX sampling point adjustment")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> Anyone with a good test setup for verifying this feature actually works
> as advertised?
> ---
>   drivers/tty/serial/sh-sci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2bdaeba5d527a6ce..8dea59edde34c224 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2522,7 +2522,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>   			 * center of the last stop bit in sampling clocks.
>   			 */
>   			int last_stop = bits * 2 - 1;
> -			int deviation = min_err * srr * last_stop / 2 / baud;
> +			int deviation = DIV_ROUND_CLOSEST(min_err * last_stop *
> +							  (int)(srr + 1),
> +							  2 * (int)baud);
>   
>   			if (abs(deviation) >= 2) {
>   				/* At least two sampling clocks off at the
