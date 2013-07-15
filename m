From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts is
 enabled
Date: Mon, 15 Jul 2013 11:07:55 +0200
Message-ID: <20130715090755.GN12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de>
 <51E3B5B5.1030706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49029 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab3GOJH6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Jul 2013 05:07:58 -0400
Content-Disposition: inline
In-Reply-To: <51E3B5B5.1030706@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Mon, Jul 15, 2013 at 04:41:25PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8815=E6=97=A5 16:27, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
> >do you want to say that the driver fails to only enable DMA when RTS=
/CTS
> >are available; or that today the driver can handle DMA just fine eve=
n
> >without RTS/CTS? I interpret your commit log as the latter, your pat=
ch
> >implements the former however.
> in the mxs-auart, if the RTS/CTS is not invalid, the DMA should be
> not enabled.
>=20
> But current code lost the limit, a uart without the RTS/CTS may also
> enables the DMA in which case the uart
> may does not run or run in a abnormal way.
So this sounds like a fix that should go into stable and so preferably
should be the first patch in your series.

Something like:

	serial: mxs-auart: DMA unreliable without RTS/CTS

	According to [add some document name here] DMA doesn't work
	reliable without hardware handshaking. So make DMA dependant on
	a newly introdused property "fsl,uart-has-rtscts".

	Cc: stable@kernel.org # [first affected version]

The flag is only used to decide if dma should be enabled. So I think an
in-code comment would be nice, too. Is it still correct to set
AUART_CTRL2_RTSEN and AUART_CTRL2_RTS and read AUART_STAT_CTS when
fsl,uart-has-rtscts is not provided?
(BTW, mxs_auart_set_mctrl has:

	u32 ctrl =3D readl(u->membase + AUART_CTRL2);

	ctrl &=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
        if (mctrl & TIOCM_RTS) {
                if (tty_port_cts_enabled(&u->state->port))
                        ctrl |=3D AUART_CTRL2_RTSEN;
                else
                        ctrl |=3D AUART_CTRL2_RTS;
        }

	s->ctrl =3D mctrl;

A comment for the diligent reader about the difference between RTSEN an=
d
RTS would be nice. Also I wonder if shadowing mctrl is sensible and use=
d
correctly here.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
