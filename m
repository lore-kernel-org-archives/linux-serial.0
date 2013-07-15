From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] serial: mxs: remove the unused macro
Date: Mon, 15 Jul 2013 10:20:44 +0200
Message-ID: <20130715082044.GL12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab3GOIUt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Jul 2013 04:20:49 -0400
Content-Disposition: inline
In-Reply-To: <1373857736-30108-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hello,

On Mon, Jul 15, 2013 at 11:08:54AM +0800, Huang Shijie wrote:
> The MXS_AUART_DMA_CONFIG is originally used to check if the DT node
> is configured with the DMA property.
>=20
> But now, the MXS_AUART_DMA_CONFIG is not used any more.
> Just remove it.
>=20
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/mxs-auart.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 4f5f161..465ef0b 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -134,7 +134,6 @@ enum mxs_auart_type {
>  struct mxs_auart_port {
>  	struct uart_port port;
> =20
> -#define MXS_AUART_DMA_CONFIG	0x1
>  #define MXS_AUART_DMA_ENABLED	0x2
>  #define MXS_AUART_DMA_TX_SYNC	2  /* bit 2 */
>  #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
> @@ -640,7 +639,7 @@ static void mxs_auart_settermios(struct uart_port=
 *u,
>  		 * we can only implement the DMA support for auart
>  		 * in mx28.
>  		 */
> -		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)) {
> +		if (is_imx28_auart(s)) {
>  			if (!mxs_auart_dma_init(s))
>  				/* enable DMA tranfer */
>  				ctrl2 |=3D AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
> @@ -1002,8 +1001,6 @@ static int serial_mxs_probe_dt(struct mxs_auart=
_port *s,
>  	}
>  	s->port.line =3D ret;
> =20
> -	s->flags |=3D MXS_AUART_DMA_CONFIG;
> -
You're suggesting that MXS_AUART_DMA_CONFIG was set here unconditionall=
y
before and so the check in the hunk above is not necessary anymore.
(<pedantic>So your "not used any more" is technically wrong.</pedantic>=
)

However serial_mxs_probe_dt returns earlier if the device was not probe=
d
by dt (which I think we can assume to not apply, still it should be
mentioned in the commit log).

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
