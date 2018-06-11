From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
Date: Tue, 12 Jun 2018 00:02:50 +0300
Message-ID: <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
References: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 6, 2018 at 10:27 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> This patch fix the following build error on M68K:
> drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
> 8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
> 8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'
>
> So 8250_dw need to depend on COMMON_CLK.
>

Makes sense.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index f005eaf8bc57..37d4ec5f3cc9 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -351,7 +351,7 @@ config SERIAL_8250_FSL
>
>  config SERIAL_8250_DW
>         tristate "Support for Synopsys DesignWare 8250 quirks"
> -       depends on SERIAL_8250
> +       depends on SERIAL_8250 && COMMON_CLK
>         help
>           Selecting this option will enable handling of the extra features
>           present in the Synopsys DesignWare APB UART.
> --
> 2.16.4
>


-- 
With Best Regards,
Andy Shevchenko
