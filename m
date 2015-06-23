From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/9] arm: twr-k70f120m: clock source drivers for Kinetis SoC
Date: Wed, 24 Jun 2015 00:25:11 +0200
Message-ID: <1914738.cJbsHkbelI@wuerfel>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-7-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435094387-20146-7-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Osmialowski <pawelo@king.net.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan Lynch <nathan_lynch@mentor.com>, Nicolas Pitre <nico@linaro.org>, Maxime
List-Id: linux-serial@vger.kernel.org

On Tuesday 23 June 2015 23:19:44 Paul Osmialowski wrote:
> +#define KINETIS_CG_UART0       KINETIS_MKCG(3, 10)     /* SIM_SCGC4[10] */
> +#define KINETIS_CG_UART1       KINETIS_MKCG(3, 11)     /* SIM_SCGC4[11] */
> +#define KINETIS_CG_UART2       KINETIS_MKCG(3, 12)     /* SIM_SCGC4[12] */
> +#define KINETIS_CG_UART3       KINETIS_MKCG(3, 13)     /* SIM_SCGC4[13] */
> +#define KINETIS_CG_UART4       KINETIS_MKCG(0, 10)     /* SIM_SCGC1[10] */
> +#define KINETIS_CG_UART5       KINETIS_MKCG(0, 11)     /* SIM_SCGC1[11] */
> +/* Ports */
> +#define KINETIS_CG_PORTA       KINETIS_MKCG(4, 9)      /* SIM_SCGC5[9] */
> +#define KINETIS_CG_PORTB       KINETIS_MKCG(4, 10)     /* SIM_SCGC5[10] */
> +#define KINETIS_CG_PORTC       KINETIS_MKCG(4, 11)     /* SIM_SCGC5[11] */
> +#define KINETIS_CG_PORTD       KINETIS_MKCG(4, 12)     /* SIM_SCGC5[12] */
> +#define KINETIS_CG_PORTE       KINETIS_MKCG(4, 13)     /* SIM_SCGC5[13] */
> +#define KINETIS_CG_PORTF       KINETIS_MKCG(4, 14)     /* SIM_SCGC5[14] */
> 

Instead of using a triple indirection here, just put the tuples
in the DT directly using #clock-cells=<2>, and get rid of both this
header file and the dt-bindings/clock/kinetis-mcg.h file.

	Arnd
