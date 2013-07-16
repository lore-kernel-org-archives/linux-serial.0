From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
Date: Tue, 16 Jul 2013 11:54:49 +0200
Message-ID: <20130716095449.GS12139@pengutronix.de>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
 <1373957732-16638-3-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45292 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab3GPJyx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 05:54:53 -0400
Content-Disposition: inline
In-Reply-To: <1373957732-16638-3-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Tue, Jul 16, 2013 at 02:55:31PM +0800, Huang Shijie wrote:
> The original DMA support works only when RTS/CTS is enabled.
What is original here?

> But after several patches, DMA support has lost this limit.
This is still misleading.

> This patch adds an optional property for the UART DT node
> which indicates the UART has RTS and CTS lines.
>=20
> This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
> RTS/CTS before we enable the DMA for the UART.

I still think this should go to stable. The options are:

	a) also take patch 1 into stable
	b) apply this patch without patch 1

I don't know if option a) is OK, b) is probably preferable. And as Greg
has much to do anyhow, better move this patch first. (Otherwise he will
probably only say: That patch doesn't apply, please help.)

> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
>  drivers/tty/serial/mxs-auart.c                     |    5 ++++-
>  2 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-aua=
rt.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> index 2c00ec6..59a40f1 100644
> --- a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
> @@ -10,6 +10,10 @@ Required properties:
>    Refer to dma.txt and fsl-mxs-dma.txt for details.
>  - dma-names: "rx" for RX channel, "tx" for TX channel.
> =20
> +Optional properties:
> +- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines,
> +	it also means you enable the DMA support for this UART.
> +
>  Example:
>  auart0: serial@8006a000 {
>  	compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 465ef0b..27532fd 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -134,6 +134,7 @@ enum mxs_auart_type {
>  struct mxs_auart_port {
>  	struct uart_port port;
> =20
> +#define MXS_AUART_RTSCTS	1
>  #define MXS_AUART_DMA_ENABLED	0x2
>  #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
>  #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
> @@ -639,7 +640,7 @@ static void mxs_auart_settermios(struct uart_port=
 *u,
>  		 * we can only implement the DMA support for auart
>  		 * in mx28.
>  		 */
> -		if (is_imx28_auart(s)) {
> +		if (is_imx28_auart(s) && (s->flags & MXS_AUART_RTSCTS)) {
I thought you wanted to add a comment here. Without knowing the details

	if (RTSCTS)
		enable_dma();

looks strange.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
