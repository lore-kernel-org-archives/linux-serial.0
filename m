From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 08/25] serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() unsigned
Date: Thu, 19 Nov 2015 22:36:13 +0200
Message-ID: <1636784.2d3bsCa4Hn@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-9-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-9-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:38:47 Geert Uytterhoeven wrote:
> Move the -1 offset of br to the assignment to *brr, so br cannot become
> negative anymore, and update the clamp() call. Now all unsigned values
> in sci_baud_calc_hscif() can become unsigned.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9442961a198378c7..fba1e1eea15dc3a1 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1870,7 +1870,8 @@ static unsigned int sci_scbrr_calc(struct sci_port *s,
> unsigned int bps, static void sci_baud_calc_hscif(unsigned int bps,
> unsigned long freq, int *brr, unsigned int *srr, unsigned int *cks)
>  {
> -	int sr, c, br, err, recv_margin;
> +	unsigned int sr, br, c;
> +	int err, recv_margin;
>  	int min_err = 1000; /* 100% */
>  	int recv_max_margin = 0;
> 
> @@ -1880,9 +1881,9 @@ static void sci_baud_calc_hscif(unsigned int bps,
> unsigned long freq, int *brr, for (c = 0; c <= 3; c++) {
>  			/* integerized formulas from HSCIF documentation */
>  			br = DIV_ROUND_CLOSEST(freq, (sr *
> -					      (1 << (2 * c + 1)) * bps)) - 1;
> -			br = clamp(br, 0, 255);
> -			err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
> +					      (1 << (2 * c + 1)) * bps));
> +			br = clamp(br, 1U, 256U);
> +			err = DIV_ROUND_CLOSEST(freq, (br * bps * sr *
>  					       (1 << (2 * c + 1)) / 1000)) -
>  					       1000;

While you're at it you can remove the parentheses around the second argument 
to DIV_ROUND_CLOSEST, they're not needed.

>  			/* Calc recv margin
> @@ -1908,7 +1909,7 @@ static void sci_baud_calc_hscif(unsigned int bps,
> unsigned long freq, int *brr, else
>  				continue;
> 
> -			*brr = br;
> +			*brr = br - 1;
>  			*srr = sr - 1;
>  			*cks = c;
>  		}

-- 
Regards,

Laurent Pinchart
