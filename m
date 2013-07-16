From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts is
 enabled
Date: Tue, 16 Jul 2013 09:33:05 +0200
Message-ID: <20130716073305.GP12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de>
 <51E3B5B5.1030706@freescale.com>
 <20130715090755.GN12139@pengutronix.de>
 <51E3D499.3060902@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3GPHdJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 03:33:09 -0400
Content-Disposition: inline
In-Reply-To: <51E3D499.3060902@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jul 15, 2013 at 06:53:13PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8815=E6=97=A5 17:07, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
> >Hello,
> >
> >On Mon, Jul 15, 2013 at 04:41:25PM +0800, Huang Shijie wrote:
> >>=E4=BA=8E 2013=E5=B9=B407=E6=9C=8815=E6=97=A5 16:27, Uwe Kleine-K=C3=
=B6nig =E5=86=99=E9=81=93:
> >>>do you want to say that the driver fails to only enable DMA when R=
TS/CTS
> >>>are available; or that today the driver can handle DMA just fine e=
ven
> >>>without RTS/CTS? I interpret your commit log as the latter, your p=
atch
> >>>implements the former however.
> >>in the mxs-auart, if the RTS/CTS is not invalid, the DMA should be
> >>not enabled.
> >>
> >>But current code lost the limit, a uart without the RTS/CTS may als=
o
> >>enables the DMA in which case the uart
> >>may does not run or run in a abnormal way.
> >So this sounds like a fix that should go into stable and so preferab=
ly
> >should be the first patch in your series.
> This patch depends on the first patch. :)
But it's not a hard dependency.

> >Something like:
> >
> >	serial: mxs-auart: DMA unreliable without RTS/CTS
> >
> >	According to [add some document name here] DMA doesn't work
> >	reliable without hardware handshaking. So make DMA dependant on
> >	a newly introdused property "fsl,uart-has-rtscts".
> >
> >	Cc: stable@kernel.org # [first affected version]
> >
> >The flag is only used to decide if dma should be enabled. So I think=
 an
> >in-code comment would be nice, too. Is it still correct to set
> ok.
> >AUART_CTRL2_RTSEN and AUART_CTRL2_RTS and read AUART_STAT_CTS when
> >fsl,uart-has-rtscts is not provided?
> i think it's correct. (if i have a imx28-evk board, i can test it.)
>=20
> If you enable the RTS/CTS from the application, the
> tty_port_cts_enabled() will be true.
> we will set the AUART_CTRL2_RTSEN in the end when the
> "fsl,uart-has-rtscts" is enabled.
>=20
>=20
> >(BTW, mxs_auart_set_mctrl has:
> >
> >	u32 ctrl =3D readl(u->membase + AUART_CTRL2);
> >
> >	ctrl&=3D ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >         if (mctrl&  TIOCM_RTS) {
> >                 if (tty_port_cts_enabled(&u->state->port))
> >                         ctrl |=3D AUART_CTRL2_RTSEN;
> >                 else
> >                         ctrl |=3D AUART_CTRL2_RTS;
> >         }
> >
> >	s->ctrl =3D mctrl;
> >
> >A comment for the diligent reader about the difference between RTSEN=
 and
> >RTS would be nice. Also I wonder if shadowing mctrl is sensible and =
used
> Please see the spec about the RTSEN and RTS.
Right, it's not hard for me. Other might not have the manual handy, so
a comment telling:

> RTSEN enable the flow control by the hardware;
> RTS enable the flow control by the software.

would be nice.

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
