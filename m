Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BEDC32771
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 07:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiI1Hrs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiI1Hr3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 03:47:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA817A5C67
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 00:43:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odRjL-0003gm-1l; Wed, 28 Sep 2022 09:43:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odRjK-003NGS-Q4; Wed, 28 Sep 2022 09:43:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odRjI-004519-H5; Wed, 28 Sep 2022 09:43:40 +0200
Date:   Wed, 28 Sep 2022 09:43:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@dh-electronics.com, NXP Linux Team <linux-imx@nxp.com>,
        kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Handle RS485 DE signal active high
Message-ID: <20220928074338.4myghfoyxb2mmywo@pengutronix.de>
References: <20220928044037.605217-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzb3sd6pjcdccpnt"
Content-Disposition: inline
In-Reply-To: <20220928044037.605217-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--tzb3sd6pjcdccpnt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 06:40:37AM +0200, Marek Vasut wrote:
> The default polarity of RS485 DE signal is active high. This driver does
> not handle such case properly. Currently, when a pin is multiplexed as a
> UART CTS_B on boot, this pin is pulled HIGH by the i.MX UART CTS circuit,
> which activates DE signal on the RS485 transceiver and thus behave as if
> the RS485 was transmitting data, so the system blocks the RS485 bus when
> it starts and until user application takes over. This behavior is not OK.
> The problem consists of two separate parts.
>=20
> First, the i.MX UART IP requires UCR1 UARTEN and UCR2 RXEN to be set for
> UCR2 CTSC and CTS bits to have any effect. The UCR2 CTSC bit permits the
> driver to set CTS (RTS_B or RS485 DE signal) to either level sychronous
> to the internal UART IP clock. Compared to other options, like GPIO CTS
> control, this has the benefit of being synchronous to the UART IP clock
> and thus without glitches or bus delays. The reason for the CTS design
> is likely because when the Receiver is disabled, the UART IP can never
> indicate that it is ready to receive data by assering CTS signal, so
> the CTS is always pulled HIGH by default.
>=20
> When the port is closed by user space, imx_uart_stop_rx() clears UCR2
> RXEN bit, and imx_uart_shutdown() clears UCR1 UARTEN bit. This disables
> UART Receiver and UART itself, and forces CTS signal HIGH, which leads
> to the RS485 bus being blocked because RS485 DE is incorrectly active.
>=20
> The proposed solution for this problem is to keep the Receiver running
> even after the port is closed, but in loopback mode. This disconnects
> the RX FIFO input from the RXD external signal, and since UCR2 TXEN is
> cleared, the UART Transmitter is disabled, so nothing can feed data in
> the RX FIFO. Because the Receiver is still enabled, the UCR2 CTSC and
> CTS bits still have effect and the CTS (RS485 DE) control is retained.
>=20
> Note that in case of RS485 DE signal active low, there is no problem and
> no special handling is necessary. The CTS signal defaults to HIGH, thus
> the RS485 is by default set to Receive and the bus is not blocked.
>=20
> Note that while there is the possibility to control CTS using GPIO with
> either CTS polarity, this has the downside of not being synchronous to
> the UART IP clock and thus glitchy and susceptible to slow DE switching.
>=20
> Second, on boot, before the UART driver probe callback is called, the
> driver core triggers pinctrl_init_done() and configures the IOMUXC to
> default state. At this point, UCR1 UARTEN and UCR2 RXEN are both still
> cleared, but UART CTS_B (RS485 DE) is configured as CTS function, thus
> the RTS signal is pulled HIGH by the UART IP CTS circuit.
>=20
> One part of the solution here is to enable UCR1 UARTEN and UCR2 RXEN and
> UTS loopback in this driver probe callback, thus unblocking the CTSC and
> CTS control early on. But this is still too late, since the pin control
> is already configured and CTS has been pulled HIGH for a short period
> of time.
>=20
> When Linux kernel boots and this driver is bound, the pin control is set
> to special "init" state if the state is available, and driver can switch
> the "default" state afterward when ready. This state can be used to set
> the CTS line as a GPIO in DT temporarily, and a GPIO hog can force such
> GPIO to LOW, thus keeping the RS485 DE line LOW early on boot. Once the
> driver takes over and UCR1 UARTEN and UCR2 RXEN and UTS loopback are all
> enabled, the driver can switch to "default" pin control state and control
> the CTS line as function instead. DT binding example is below:
>=20
> "
> &gpio6 {
>   rts-init-hog {
>     gpio-hog;
>     gpios =3D <5 0>;
>     output-low;
>     line-name =3D "rs485-de";
>   };
> };
>=20
> &uart5 { /* DHCOM UART2 */
>   pinctrl-0 =3D <&pinctrl_uart5>;
>   pinctrl-1 =3D <&pinctrl_uart5_init>;
>   pinctrl-names =3D "default", "init";
>   ...
> };
> pinctrl_uart5_init: uart5-init-grp {
>   fsl,pins =3D <
> ...
>     MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05       0x30b1
>   >;
> };
>=20
> pinctrl_uart5: uart5-grp {
>   fsl,pins =3D <
> ...
>     MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B      0x30b1
>   >;
> };
> "

An alternative work around is to use the GPIO as RTS also in default,
isn't it?

> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: kernel@dh-electronics.com
> Cc: kernel@pengutronix.de
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/imx.c | 51 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 05b432dc7a85c..144f1cedd4b64 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -489,7 +489,7 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  static void imx_uart_stop_rx(struct uart_port *port)
>  {
>  	struct imx_port *sport =3D (struct imx_port *)port;
> -	u32 ucr1, ucr2, ucr4;
> +	u32 ucr1, ucr2, ucr4, uts;
> =20
>  	ucr1 =3D imx_uart_readl(sport, UCR1);
>  	ucr2 =3D imx_uart_readl(sport, UCR2);
> @@ -505,7 +505,17 @@ static void imx_uart_stop_rx(struct uart_port *port)
>  	imx_uart_writel(sport, ucr1, UCR1);
>  	imx_uart_writel(sport, ucr4, UCR4);
> =20
> -	ucr2 &=3D ~UCR2_RXEN;
> +	if (port->rs485.flags & SER_RS485_ENABLED &&
> +	    port->rs485.flags & SER_RS485_RTS_ON_SEND &&
> +	    sport->have_rtscts && !sport->have_rtsgpio) {

IMHO this needs a comment. The later hunks might benefit from a comment
two. I'd explain it once in more detail and refer to that description
=66rom the other relevant code sections.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tzb3sd6pjcdccpnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMz+yYACgkQwfwUeK3K
7AmC2Qf/ZjvFqBd/PMf1guNxdAvs4DEfaUYPfHvRxQcRP49TqNkNq2YcDLh431p4
y2okzVFvgLLXh0fP860WgKiwJIpANbZT1PSQO7dJF8iGlIm4lFXJjtA0effVypf/
ifsRrXZe8r3+trjkFNNuHOKvD9m4SGEBZ9dlr6088xLgJbv22B/aYPMhKbIIhxk1
8VvXGimxtPxrKLc0ev2UaKPIDerlkEucPHKlpMAEdtfHUwzyHN1/xUCXuTtoYMUi
Zn1WrJj+H95zLrLKdMIgewZm3H/l5wdquTpCns0YlTBScckUrkPCdzMqOUlRxC7X
exBeV0XNYw0UFEY/iq2mMlqw6lJDFg==
=IFJc
-----END PGP SIGNATURE-----

--tzb3sd6pjcdccpnt--
