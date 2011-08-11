From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2] serial:bfin_uart: Put TX IRQ in individual platform resource.
Date: Thu, 11 Aug 2011 16:03:52 +0800
Message-ID: <CAJxxZ0Ob6MddPM17B_yhx47ZCCfxa38g0j+bUD4gTbH_GfFhQQ@mail.gmail.com>
References: <1312256727-13906-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55248 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1HKIDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Aug 2011 04:03:55 -0400
In-Reply-To: <1312256727-13906-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi Alan,

Any comments?

Sonic Zhang

On Tue, Aug 2, 2011 at 11:45 AM, Sonic Zhang <sonic.adi@gmail.com> wrot=
e:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> Serial TX IRQ is not RX IRQ plus 1 in some blackfin chips.
> Give individual platform resources to both TX and RX irqs.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/tty/serial/bfin_uart.c | =A0 35 +++++++++++++++++++++-----=
---------
> =A01 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin=
_uart.c
> index e08bc04..881c6e7 100644
> --- a/drivers/tty/serial/bfin_uart.c
> +++ b/drivers/tty/serial/bfin_uart.c
> @@ -667,17 +667,17 @@ static int bfin_serial_startup(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kgdboc_break_enabled =3D 0;
> =A0 =A0 =A0 =A0else {
> =A0# endif
> - =A0 =A0 =A0 if (request_irq(uart->port.irq, bfin_serial_rx_int, IRQ=
=46_DISABLED,
> + =A0 =A0 =A0 if (request_irq(uart->rx_irq, bfin_serial_rx_int, IRQF_=
DISABLED,
> =A0 =A0 =A0 =A0 =A0 =A0 "BFIN_UART_RX", uart)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_NOTICE "Unable to attach B=
lackFin UART RX interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (request_irq
> - =A0 =A0 =A0 =A0 =A0 (uart->port.irq+1, bfin_serial_tx_int, IRQF_DIS=
ABLED,
> + =A0 =A0 =A0 =A0 =A0 (uart->tx_irq, bfin_serial_tx_int, IRQF_DISABLE=
D,
> =A0 =A0 =A0 =A0 =A0 =A0 "BFIN_UART_TX", uart)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_NOTICE "Unable to attach B=
lackFin UART TX interrupt\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->port.irq, uart);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->rx_irq, uart);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0}
>
> @@ -692,7 +692,7 @@ static int bfin_serial_startup(struct uart_port *=
port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned uart_dma_ch_rx, uart_dma_ch_t=
x;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (uart->port.irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (uart->rx_irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case IRQ_UART3_RX:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_dma_ch_rx =3D CH_=
UART3_RX;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_dma_ch_tx =3D CH_=
UART3_TX;
> @@ -709,16 +709,16 @@ static int bfin_serial_startup(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (uart_dma_ch_rx &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0request_dma(uart_dma_c=
h_rx, "BFIN_UART_RX") < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_NOTICE"Fai=
l to attach UART interrupt\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->port.irq=
, uart);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->port.irq=
 + 1, uart);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->rx_irq, =
uart);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->tx_irq, =
uart);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (uart_dma_ch_tx &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0request_dma(uart_dma_c=
h_tx, "BFIN_UART_TX") < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_NOTICE "Fa=
il to attach UART interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_dma(uart_dma_ch_r=
x);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->port.irq=
, uart);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->port.irq=
 + 1, uart);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->rx_irq, =
uart);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(uart->tx_irq, =
uart);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -785,8 +785,8 @@ static void bfin_serial_shutdown(struct uart_port=
 *port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0};
> =A0#endif
> - =A0 =A0 =A0 free_irq(uart->port.irq, uart);
> - =A0 =A0 =A0 free_irq(uart->port.irq+1, uart);
> + =A0 =A0 =A0 free_irq(uart->rx_irq, uart);
> + =A0 =A0 =A0 free_irq(uart->tx_irq, uart);
> =A0#endif
>
> =A0#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> @@ -1319,14 +1319,21 @@ static int bfin_serial_probe(struct platform_=
device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart->port.mapbase =3D res->start;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->port.irq =3D platform_get_irq(pde=
v, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart->port.irq < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No=
 uart RX/TX IRQ specified\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->tx_irq =3D platform_get_irq(pdev,=
 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart->tx_irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No=
 uart TX IRQ specified\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOENT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_error_unmap;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->status_irq =3D platform_get_irq(p=
dev, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->rx_irq =3D platform_get_irq(pdev,=
 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart->rx_irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No=
 uart RX IRQ specified\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_error_unmap;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->status_irq =3D platform_get_irq(p=
dev, 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (uart->status_irq < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "N=
o uart status IRQ specified\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOENT;
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
