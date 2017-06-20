From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Tue, 20 Jun 2017 13:13:18 -0300
Message-ID: <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Tue, Jun 20, 2017 at 12:37 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
> DMA support for half-duplex RS-485 never worked correctly on i.MX6Q/D
> due to an undiscovered SMP-related bug, instead of the real data being
> sent out, the rest of the transmit buffer is sent (xmit->tail jumps over
> xmit->head in imx_transmit_buffer and UART_XMIT_SIZE bytes are sent out)
> More details: https://lkml.org/lkml/2017/1/4/579
>
> Disable it for that configuration until the bug is found and fixed.
>
> We need to know at probe time if we can enable DMA. (RS-485 could be
> enabled after that). Let's therefore only enable DMA if it is not an
> i.MX6Q/D UART with uart-has-rtscts in the DT and CONFIG_SMP enabled.
>
> Fixes: 17b8f2a3fdca ("serial: imx: add support for half duplex rs485")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/tty/serial/imx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index bbefddd92bfe..000949f686a4 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1277,8 +1277,14 @@ static int imx_startup(struct uart_port *port)
>
>         writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
>
> -       /* Can we enable the DMA support? */
> -       if (!uart_console(port) && !sport->dma_is_inited)
> +       /*
> +        * Can we enable the DMA support?
> +        * RS-485 DMA is broken on i.MX6D/Q SMP systems. Do not use DMA on
> +        * UARTs with RTS/CTS to prevent misbehavior until the bug is fixed.
> +        */
> +       if (!uart_console(port) && !sport->dma_is_inited &&
> +           !(sport->have_rtscts && is_imx6q_uart(sport) &&
> +             IS_ENABLED(CONFIG_SMP)))
>                 imx_uart_dma_init(sport);

The subject gives the impression that the DMA will only be disabled
for RS485, but the impact of this change is wider.

For example: if I have a mx6q system with a Bluetooth serial
connection I can no longer use DMA with your change applied.

Ideally we should fix the RS485 DMA bug. If that is not possible, then
at least we need to restrict this change to the RS485 case.

Maybe we need to pass "linux,rs485-enabled-at-boot-time" in device
tree and then use this property to deceide if DMA will be enabled or
not:

if (!uart_console(port) && !sport->dma_is_inited && !sport->rs485_enabled)
