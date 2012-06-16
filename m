From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
Date: Sat, 16 Jun 2012 09:59:57 +0800
Message-ID: <20120616015955.GA29663@S2101-09.ap.freescale.net>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
 <20120615160635.GP31565@S2101-09.ap.freescale.net>
 <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:59991
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923Ab2FPB7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 21:59:48 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, snijsure@grid-net.com, rob.herring@calxeda.com, Grant Likely <grant.likely@secretlab.ca>, kernel@pengutronix.de, linux-serial@vger.kernel.org, matt@grid-net.com, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Fri, Jun 15, 2012 at 01:11:12PM -0300, Fabio Estevam wrote:
> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wro=
te:
>=20
> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> > ...
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .id_table =3D mxs_auart_devtype,
> >
> > I do not think we need these.
>=20
> WIthout this, the non-dt kernel does not probe correctly.

Are you sure about that?  I just tried to removed those and still
saw the following with non-DT boot.

[    0.810000] mxs-auart.0: ttyAPP0 at MMIO 0x8006a000 (irq =3D 112) is=
 a mxs-auar t.0
[    0.820000] mxs-auart mxs-auart.0: Found APPUART 3.1.0
[    0.830000] mxs-auart.3: ttyAPP3 at MMIO 0x80070000 (irq =3D 115) is=
 a mxs-auar t.3
[    0.840000] mxs-auart mxs-auart.3: Found APPUART 3.1.0

--=20
Regards,
Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
