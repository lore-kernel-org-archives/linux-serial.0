From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH V2 2/2] serial: 8250_omap: Fix gpio check for auto RTS/CTS
Date: Sun, 6 Oct 2019 20:11:32 +0200
Message-ID: <CAGm1_kuoZ_sMDut7X_BGycsPYnb7J3K8_RWw+FdTJcYjCPjtrA@mail.gmail.com>
References: <20191006163314.23191-1-aford173@gmail.com> <20191006163314.23191-2-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191006163314.23191-2-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 6, 2019 at 6:33 PM Adam Ford <aford173@gmail.com> wrote:
>
> There are two checks to see if the manual gpio is configured, but
> these the check is seeing if the structure is NULL instead it
> should check to see if there are CTS and/or RTS pins defined.
>
> This patch uses checks for those individual pins instead of
> checking for the structure itself to restore auto RTS/CTS.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> V2:  Made the NULL dererence check from patch 1/2 come before this.
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c68e2b3a1634..836e736ae188 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -141,7 +141,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
>
>         serial8250_do_set_mctrl(port, mctrl);
>
> -       if (!up->gpios) {
> +       if (!mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS)) {
>                 /*
>                  * Turn off autoRTS if RTS is lowered and restore autoRTS
>                  * setting if RTS is raised
> @@ -456,7 +456,8 @@ static void omap_8250_set_termios(struct uart_port *port,
>         up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
>
>         if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
> -           !up->gpios) {
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
> +           !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
>                 /* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
>                 up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
>                 priv->efr |= UART_EFR_CTS;
> --
> 2.17.1
>
