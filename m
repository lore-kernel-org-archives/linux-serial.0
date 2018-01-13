From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid overflow in dw8250_set_termios
Date: Sat, 13 Jan 2018 12:59:05 +0100
Message-ID: <CAEXMXLR3HYcgm9iknfq3d31TN=Fx-bYy9dHOSouHR5Y9gsN__w@mail.gmail.com>
References: <20180112134507.9030-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112134507.9030-1-ed.blake@sondrel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Dear Ed,

Thanks.

Tested-by: Nuno Goncalves <nunojpg@gmail.com>

I just would like to report a aditional issue I find, which I am not
sure if it is intend behaviour or not. If I set bauds 1152000,
1500000, 2000000, 2500000, 3000000, I always get a actually set baud
of 1500000, because it appears to be the closest baud by my hardware,
but if I set 3500000, then the port gets disabled.

This is because up to 3000000 the closest integer divider is 1, but
then it becomes 0, which is invalid.

If we still should return the closest baud, then we must return a
minimum of 1, and never 0, at uart_get_divisor, or
serial8250_get_divisor.

Thanks,
Nuno

On Fri, Jan 12, 2018 at 2:45 PM, Ed Blake <ed.blake@sondrel.com> wrote:
> When searching for an achievable input clock rate that is within
> +/-1.6% of an integer multiple of the target baudx16 rate, there is the
> potential to overflow the i * rate calculations.
>
> For example, on a 32-bit system with a baud rate of 4000000, the
> i * max_rate calculation will overflow if i reaches 67 without finding
> an acceptable rate.
>
> Fix this by setting the upper boundary of the loop appropriately to
> avoid overflow.
>
> Reported-by: Nuno Goncalves <nunojpg@gmail.com>
> Signed-off-by: Ed Blake <ed.blake@sondrel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5bb0c42c88dd..04b44829f0e3 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -252,7 +252,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>                                struct ktermios *old)
>  {
>         unsigned int baud = tty_termios_baud_rate(termios);
> -       unsigned int target_rate, min_rate, max_rate;
> +       unsigned int target_rate, min_rate, max_rate, div_max;
>         struct dw8250_data *d = p->private_data;
>         long rate;
>         int i, ret;
> @@ -265,12 +265,14 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>         min_rate = target_rate - (target_rate >> 6);
>         max_rate = target_rate + (target_rate >> 6);
>
> -       for (i = 1; i <= UART_DIV_MAX; i++) {
> +       /* Avoid overflow */
> +       div_max = min(UINT_MAX / max_rate, (unsigned int)UART_DIV_MAX);
> +       for (i = 1; i <= div_max; i++) {
>                 rate = clk_round_rate(d->clk, i * target_rate);
>                 if (rate >= i * min_rate && rate <= i * max_rate)
>                         break;
>         }
> -       if (i <= UART_DIV_MAX) {
> +       if (i <= div_max) {
>                 clk_disable_unprepare(d->clk);
>                 ret = clk_set_rate(d->clk, rate);
>                 clk_prepare_enable(d->clk);
> --
> 2.11.0
>
