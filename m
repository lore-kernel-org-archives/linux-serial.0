From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH] 8250_dw: do not int overflow when rate can not be aplied
Date: Thu, 11 Jan 2018 17:18:59 +0000
Message-ID: <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
References: <20180111133832.13125-1-nunojpg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111133832.13125-1-nunojpg@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nuno Goncalves <nunojpg@gmail.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Nuno,

Thanks for reporting this and the patch.

On 11/01/18 13:38, Nuno Goncalves wrote:
> When target_rate is big enough and not permitted in hardware,
> then i is looped to UART_DIV_MAX (0xFFFF), and i * max_rate will overflow
> (32b signed).
>
> A fix is to quit the loop early enough, as soon as rate < i * min_rate as it
> means the rate is not permitted.

'rate < i * min_rate' does not mean the rate is not permitted.  clk_round_rate() gives the nearest achievable rate to the one requested, which may be lower than i * min_rate.  This is not an error and in this case we want to continue the loop searching for an acceptable rate.


>
> This avoids arbitraty rates to be applied. Still in my hardware the max
> allowed rate (1500000) is aplied when a higher is requested. This seems a
> artifact of clk_round_rate which is not understood by me and independent of
> this fix. Might or might not be another bug.
>
> Signed-off-by: Nuno Goncalves <nunojpg@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5bb0c42c88dd..a27ea916abbf 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -267,7 +267,13 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  
>  	for (i = 1; i <= UART_DIV_MAX; i++) {
>  		rate = clk_round_rate(d->clk, i * target_rate);
> -		if (rate >= i * min_rate && rate <= i * max_rate)
> +
> +		if (rate < i * min_rate) {
> +			i = UART_DIV_MAX + 1;
> +			break;
> +		}
> +
> +		if (rate <= i * max_rate)
>  			break;
>  	}
>  	if (i <= UART_DIV_MAX) {

-- 
Ed
