From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 16:29:02 -0700
Message-ID: <20110429232902.GA24864@kroah.com>
References: <20110429211434.GA1355@kroah.com>
 <1369027353.2095897.1304114559625.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46773 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab1D2XeQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Apr 2011 19:34:16 -0400
Content-Disposition: inline
In-Reply-To: <1369027353.2095897.1304114559625.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, michal simek <michal.simek@petalogix.com>, joe@perches.com, grant likely <grant.likely@secretlab.ca>, John Linn <john.linn@xilinx.com>

On Fri, Apr 29, 2011 at 10:02:39PM +0000, johnlinn@comcast.net wrote:
>=20
> > On Wed, Apr 27, 2011 at 12:17:36PM -0600, johnlinn@comcast.net wrot=
e:
> > > From: John Linn <john.linn@xilinx.com>
> > >=20
> > > The Xilinx PS Uart is used on the new ARM based SoC. This
> > > UART is not compatible with others such that a seperate
> > > driver is required.
> > >=20
> > > Signed-off-by: John Linn <john.linn@xilinx.com>
> >=20
> > I get build failures with this patch:
> >=20
> >   CC [M]  drivers/tty/serial/xilinx_uartps.o
> > drivers/tty/serial/xilinx_uartps.c: In function =E2=80=98xuartps_ge=
t_port=E2=80=99:
> > drivers/tty/serial/xilinx_uartps.c:785:14: error: =E2=80=98NO_IRQ=E2=
=80=99 undeclared
> > (first use in this function)
> > drivers/tty/serial/xilinx_uartps.c:785:14: note: each undeclared
> > identifier is reported only once for each function it appears in
> > make[1]: *** [drivers/tty/serial/xilinx_uartps.o] Error 1
> >=20
> > Care to fix this up so it's in a state I can properly apply it to t=
he
> > tree?
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Done and sent out as V5 of patch.
>=20
> Just for future reference (and maybe I should know this).  How should=
 I=20
> have prevented this problem? I guess I would need to build the kernel=
=20
> for other architectures and I don't normally do that.

Yes, you should at the very least, build the code for x86 as that's wha=
t
we use for development and applying the patches on.

You can use cross-compliers to build for other architectures as well if
you want.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
