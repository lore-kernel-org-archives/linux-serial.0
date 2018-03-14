From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 12:35:55 +0200
Message-ID: <CAHp75VcipTDS30CxJ+BEcidaCJAbuDTzsG3q8xZK-h6HCN5McA@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-2-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Aaron Durbin <adurbin@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Douglas Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 14, 2018 at 2:36 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> input clock.
>
> Allow these platforms to set up this clock by specifying a kernel command
> line like:
> earlycon=amdcz,mmio32,0xfedc6000,115200
>

Thanks, this is what I meant.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Suggested-by: ?

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/tty/serial/8250/8250_early.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index ae6a256524d8..c6bf971a6038 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -195,3 +195,18 @@ static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
>  OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
>
>  #endif
> +
> +#ifdef CONFIG_SERIAL_8250_DW
> +static int __init early_amdcz_setup(struct earlycon_device *dev,
> +                                   const char *opt)
> +{
> +       struct uart_port *port = &dev->port;
> +
> +       port->uartclk = 48000000;
> +
> +       return early_serial8250_setup(dev, opt);
> +}
> +
> +EARLYCON_DECLARE(amdcz, early_amdcz_setup);
> +
> +#endif
> --
> 2.16.2.804.g6dcf76e118-goog
>



-- 
With Best Regards,
Andy Shevchenko
