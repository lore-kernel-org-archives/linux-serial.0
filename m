From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
Date: Wed, 15 Jul 2015 18:06:26 +0200
Message-ID: <55A68502.1090609@i2se.com>
References: <1436945777-4332-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436945777-4332-1-git-send-email-jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi Juergen,

Am 15.07.2015 um 09:36 schrieb Juergen Borleis:
> Whenever the UART device driver gets closed from userland, the driver
> disables the UART unit and then stops its clock to save power.
>
> The bit which disabled the UART unit is described as:
>
>   "UART Enable. If this bit is set to 1, the UART is enabled. Data
>   transmission and reception occurs for the UART signals. When the
>   UART is disabled in the middle of transmission or reception, it
>   completes the current character before stopping."
>
> The important part is the "it completes the current character". Whenever
> a reception is ongoing when the UART gets disabled (including the clock
> off) the statemachine freezes and "remembers" this state on the next
> open() and re-enabling of the unit's clock.
>
> In this case we end up receiving an additional bogus character
> immediately.
>
> The solution in this change is to move the AUART unit into its reset
> state on close() and only release it from its reset state on the next
> open().
>
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> ---

changelog for v2?

>  drivers/tty/serial/mxs-auart.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 13cf773..13b3e3c 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *u)
>  	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
>  }
>  
> +static void mxs_auart_keep_reset(struct uart_port *u)
> +{
> +	int i;
> +	u32 reg;
> +
> +	reg = readl(u->membase + AUART_CTRL0);
> +	/* if already in reset state, keep it untouched */
> +	if (reg & AUART_CTRL0_SFTRST)
> +		return;
> +
> +	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
> +	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
> +
> +	for (i = 0; i < 10000; i++) {
> +		reg = readl(u->membase + AUART_CTRL0);
> +		/* reset is finished when the clock is gated */
> +		if (reg & AUART_CTRL0_CLKGATE)
> +			return;
> +		udelay(3);
> +	}
> +
> +	dev_err(u->dev, "Failed to reset the unit.");

Sorry, i missed that in my first review. It looks like that the newline
at the end of the error message is missing.

Regards
Stefan
