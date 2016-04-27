From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] serial: mctrl_gpio: Drop support for out1-gpios and out2-gpios
Date: Wed, 27 Apr 2016 10:20:24 +0200
Message-ID: <CACQ1gAhCM89ZPM1BNwxXDaCffuhMrZkZUvK6nVgXyxhkO2XrLg@mail.gmail.com>
References: <1461337814-29058-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461337814-29058-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016-04-22 17:10 GMT+02:00 Geert Uytterhoeven <geert+renesas@glider.be>:
> The OUT1 and OUT2 pins present on some legacy UARTs are basically GPIOs.
> It doesn't make much sense to emulate GPIOs using other GPIOs, hence
> drop support for that.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 02147361eaa94747..821ffa637eb630cb 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -43,8 +43,6 @@ static const struct {
>         { "rng", TIOCM_RNG, false, },
>         { "rts", TIOCM_RTS, true, },
>         { "dtr", TIOCM_DTR, true, },
> -       { "out1", TIOCM_OUT1, true, },
> -       { "out2", TIOCM_OUT2, true, },
>  };
>
>  void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
> --
> 1.9.1
>
Maybe I missed something, but I think you want to remove
UART_GPIO_OUT{1,2} also :
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
b/drivers/tty/serial/serial_mctrl_gpio.h
index 9716db283290..10632e72b89f 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -32,8 +32,6 @@ enum mctrl_gpio_idx {
     UART_GPIO_RI = UART_GPIO_RNG,
     UART_GPIO_RTS,
     UART_GPIO_DTR,
-    UART_GPIO_OUT1,
-    UART_GPIO_OUT2,
     UART_GPIO_MAX,
 };

Richard.
