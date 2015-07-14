From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
Date: Tue, 14 Jul 2015 19:33:04 +0200 (CEST)
Message-ID: <1463261573.74606.1436895184420.JavaMail.open-xchange@oxbsltgw03.schlund.de>
References: <1436884864-6782-1-git-send-email-jbe@pengutronix.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436884864-6782-1-git-send-email-jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Juergen,

> Juergen Borleis <jbe@pengutronix.de> hat am 14. Juli 2015 um 16:41
> geschrieben:
>
>
> [...]
> ---
> drivers/tty/serial/mxs-auart.c | 38 ++++++++++++++++++++++++++++++--------
> 1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 13cf773..f42b6ad 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *u)
> writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> }
>
> +static void mxs_auart_do_reset(struct uart_port *u)

i think the naming of this new function is too similiar to mxs_auart_reset() and
doesn't represent the exact behavior. How about mxs_auart_keep_reset() or
mxs_auart_gate()?

> +{
> + int i;
> + u32 reg;
> +
> + reg = readl(u->membase + AUART_CTRL0);
> + /* if already in reset state, keep it untouched */
> + if (reg & AUART_CTRL0_SFTRST)
> + return;
> +
> + writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> + writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
> +
> + for (i = 0; i < 1000; i++) {
> + reg = readl(u->membase + AUART_CTRL0);
> + /* reset is finished when the clock is gated */
> + if (reg & AUART_CTRL0_CLKGATE)
> + return;
> + udelay(10);

The delay in mxs_auart_reset() has a value of 3 microseconds. Why not the same
here?

> + }
> +
> + dev_err(u->dev, "Failed to reset the unit.");
> +}
> +
> static int mxs_auart_startup(struct uart_port *u)
> {
> int ret;
> @@ -867,7 +891,10 @@ static int mxs_auart_startup(struct uart_port *u)
> if (ret)
> return ret;
>
> - writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> + /* reset the unit if not aready done */

Just a typo: already?

Thanks
Stefan
