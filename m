From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/5] serial: sh-sci: Simplify baud rate calculation algorithms
Date: Tue, 29 Oct 2013 11:48:29 +0100
Message-ID: <2757642.fYyfNpyZ5s@avalon>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383042599-25151-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383042599-25151-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Paul,

On Tuesday 29 October 2013 11:29:57 Laurent Pinchart wrote:
> Rewrite the baud rate register value calculations in easier to read
> forms. The computed value isn't modified.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/tty/serial/sh-sci.c | 8 ++++----
>  include/linux/serial_sci.h  | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2fc1a0e..91ce9214b 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1813,13 +1813,13 @@ static unsigned int sci_scbrr_calc(unsigned int
> algo_id, unsigned int bps, {
>  	switch (algo_id) {
>  	case SCBRR_ALGO_1:
> -		return ((freq + 16 * bps) / (16 * bps) - 1);
> +		return freq / (16 * bps);
>  	case SCBRR_ALGO_2:
> -		return ((freq + 16 * bps) / (32 * bps) - 1);
> +		return DIV_ROUND_CLOSEST(freq, 32 * bps) - 1;
>  	case SCBRR_ALGO_3:
> -		return (((freq * 2) + 16 * bps) / (16 * bps) - 1);
> +		return freq / (8 * bps);
>  	case SCBRR_ALGO_4:
> -		return (((freq * 2) + 16 * bps) / (32 * bps) - 1);
> +		return DIV_ROUND_CLOSEST(freq, 16 * bps) - 1;
>  	}
> 
>  	/* Warn, but use a safe default */
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index 803068d..eb787d4 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -11,10 +11,10 @@
>  #define SCIx_NOT_SUPPORTED	(-1)
> 
>  enum {
> -	SCBRR_ALGO_1,		/* ((clk + 16 * bps) / (16 * bps) - 1) */
> -	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
> -	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
> -	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
> +	SCBRR_ALGO_1,		/* clk / (16 * bps) */
> +	SCBRR_ALGO_2,		/* DIV_ROUND_CLOSEST(clk, 32 * bps) - 1 */
> +	SCBRR_ALGO_3,		/* clk / (8 * bps) */
> +	SCBRR_ALGO_4,		/* DIV_ROUND_CLOSEST(clk, 16 * bps) - 1 */
>  	SCBRR_ALGO_6,		/* HSCIF variable sample rate algorithm */
>  };

While touching this, I'd like to use it as an opportunity to clean things up. 
It looks to me like algorithms 1 and 3 should use DIV_ROUND_CLOSEST() - 1 
instead of rounding the value up as they currently do. I've checked the 
documentation for various SuperH SoCs and they all confirm my hypothesis. As I 
don't have access to any SuperH board I can't test this though.

Given that you have touched the baudrate calculation code in the past, could 
you give me an insight on why algorithms 1 and 3 are implemented without 
rounding to the closest value and without the - 1 ?

On the same subject, algorithm 3 is only used on sh7723 and sh7724 for the 
SCIFA. I've only managed to find a user's manual for the sh7724 (the publicly 
available sh7723 documentation just lists the IP cores and their features), 
and the SCIFA documentation seems to imply that, when using the default 1/16 
sampling rate, algorithm 4 should be used. Could you enlighten me on why the 
sh-sci driver assume a sampling rate of 1/8 instead of 1/16 for baudrate 
calculation for SCIFA on sh772[34] ?

-- 
Regards,

Laurent Pinchart

