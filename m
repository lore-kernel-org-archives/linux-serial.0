From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] RFC: WIP: sc16is7xx [v0.4]
Date: Mon, 10 Mar 2014 14:20:32 +0000
Message-ID: <20140310142032.47e680b5@alan.etchedpixels.co.uk>
References: <1394432777-13005-1-git-send-email-jon@ringle.org>
	<1394434945.519725450@f256.i.mail.ru>
	<alpine.DEB.2.02.1403100744230.23103@jringle-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58338 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbaCJOUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Mar 2014 10:20:50 -0400
In-Reply-To: <alpine.DEB.2.02.1403100744230.23103@jringle-ubuntu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jon Ringle <jon@ringle.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>

On Mon, 10 Mar 2014 07:50:12 -0400 (EDT)
Jon Ringle <jon@ringle.org> wrote:

>=20
> On Mon, 10 Mar 2014, Alexander Shiyan wrote:
>=20
> > =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA,=
 10 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2014, 2:26 -04:00 =D0=BE=D1=82 jon@r=
ingle.org:
> > > From: Jon Ringle <jringle@gridpoint.com>
> > ...
> > > +config SERIAL_SC16IS7XX
> > > +	tristate "SC16IS7xx RS485 serial support"
> > > +	  select SERIAL_CORE
> > > +	  default n
> > > +	  help
> > > +	  This selects support for SC16IS7xx for use as a RS485 serial =
port
> >=20
> > Documentation says:
> > The SC16IS740/750/760 is a slave I=C2=B2C-bus/SPI interface to a si=
ngle-channel
> > high performance UART.
> > ...
> > The SC16IS740/750/760 also provides additional advanced features su=
ch
> > as auto hardware and software flow control, automatic RS-485 suppor=
t...
> >=20
> > So why do you position this chip as RS485 only? Automatic direction=
 for
> > RS485 is just a feature as an addition for standart UART.
>=20
> You're right. This is just how we are using the chip in our board. Wo=
uld a=20
> configuration flag in platform_data make sense to use the auto rs485=20
> direction?

We have interfaces for RS485 runtime configuration so it could be
extended to set a lot of parameters that way, but I think for now it
might not be a bad idea to support rs485 auto direction in/out/off in t=
he
platform data.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
