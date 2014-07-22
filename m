From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] serial: sh-sci: Updated calculation of bit error
 rate and bit rate
Date: Tue, 22 Jul 2014 10:37:29 +0900
Message-ID: <20140722013726.GA31649@verge.net.au>
References: <1405321800-18114-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405321800-18114-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 14, 2014 at 04:09:58PM +0900, Nobuhiro Iwamatsu wrote:
> Currently, the decimal point is discarded calculation of BRR.
> Therefore, it can not calculate a value close to the correct value.
> This patch fixes this problem by using DIV_ROUND_CLOSEST.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

All three patches:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/tty/serial/sh-sci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 88236da..ce80137 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1796,11 +1796,13 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
>  	for (sr = 8; sr <= 32; sr++) {
>  		for (c = 0; c <= 3; c++) {
>  			/* integerized formulas from HSCIF documentation */
> -			br = freq / (sr * (1 << (2 * c + 1)) * bps) - 1;
> +			br = DIV_ROUND_CLOSEST(freq, (sr *
> +					      (1 << (2 * c + 1)) * bps)) - 1;
>  			if (br < 0 || br > 255)
>  				continue;
> -			err = freq / ((br + 1) * bps * sr *
> -			      (1 << (2 * c + 1)) / 1000) - 1000;
> +			err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
> +					       (1 << (2 * c + 1)) / 1000)) -
> +					       1000;
>  			if (min_err > err) {
>  				min_err = err;
>  				*brr = br;
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
