From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] imx: Add save/restore functions for UART control regs
Date: Mon, 19 Dec 2011 11:10:23 +0100
Message-ID: <20111219101023.GE27267@pengutronix.de>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
 <20111219034902.GC4962@S2100-06.ap.freescale.net>
 <4EEEDE94.3080804@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36987 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab1LSKKb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Dec 2011 05:10:31 -0500
Content-Disposition: inline
In-Reply-To: <4EEEDE94.3080804@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>

On Mon, Dec 19, 2011 at 07:49:56AM +0100, Dirk Behme wrote:
> On 19.12.2011 04:49, Shawn Guo wrote:
> >On Sun, Dec 18, 2011 at 06:34:14PM +0100, Dirk Behme wrote:
> >>Factor out the uart save/restore functionality instead of
> >>having the same code several times in the driver.
> >>
> >>Signed-off-by: Dirk Behme<dirk.behme@gmail.com>
> >>CC: Saleem Abdulrasool<compnerd@compnerd.org>
> >>CC: Sascha Hauer<s.hauer@pengutronix.de>
> >>CC: Fabio Estevam<festevam@gmail.com>
> >>CC: Uwe Kleine-K=F6nig<u.kleine-koenig@pengutronix.de>
> >>CC: linux-serial@vger.kernel.org
> >>---
> >>  drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++++++++++--=
-----
> >>  1 files changed, 31 insertions(+), 7 deletions(-)
> >>
> >>diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >>index 163fc90..6a01c2a 100644
> >>--- a/drivers/tty/serial/imx.c
> >>+++ b/drivers/tty/serial/imx.c
> >>@@ -260,6 +260,31 @@ static inline int is_imx21_uart(struct imx_por=
t *sport)
> >>  }
> >>
> >>  /*
> >>+ * Save and restore functions for UCR1, UCR2 and UCR3 registers
> >>+ */
> >>+static void imx_console_mode(struct uart_port *port,
> >
> >Function name imx_console_mode seems not like a couple with
> >imx_console_restore.  And I guess something like
> >imx_port_ucrs_save[restore] would be better?
> >
> >>+			     unsigned int *ucr1,
> >>+			     unsigned int *ucr2,
> >>+			     unsigned int *ucr3)
> >
> >Can we define something like 'struct imx_port_ucrs' to contains thes=
e?
>=20
> Yes, we could have different function names above and use a struct.
>=20
> I implemented what Sascha asked for in
>=20
> http://www.spinics.net/lists/arm-kernel/msg144960.html
>=20
> though:
>=20
> -- Sascha wrote: --
> I'm thinking about:
>=20
> imx_console_mode(struct uart_port *port, u32 *ucr1, u32 *ucr2, u32 *u=
cr2);
> imx_console_restore(struct uart_port *port, u32 ucr1, u32 ucr2, u32 u=
cr3);
> -- Sascha end --
>=20
> It seems Shawn proposes
>=20
> imx_port_ucrs_save(struct uart_port *port, struct *imx_port_ucrs);
> imx_port_ucrs_restore(struct uart_port *port, struct *imx_port_ucrs);
>=20
> (?)
>=20
> Sascha, Shawn: Could you agree on what we should use?

I think save/restore are better names.
Maybe I thought about a function which saves the current values *and*
sets ucrx to other values. In that case imx_port_ucrs_save() would be
the wrong name.

>=20
> Once you agreed, I will send an update of both two patches.

+1 for save/restore

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
