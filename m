From: Oliver Neukum <oneukum@suse.de>
Subject: Re: serial device name for smart card reader that is integrated to Anysee DVB USB device
Date: Wed, 5 Oct 2011 08:15:17 +0200
Message-ID: <201110050815.17949.oneukum@suse.de>
References: <4E8B7901.2050700@iki.fi> <20111005045917.GB4700@kroah.com> <4E8BF21B.4010907@iki.fi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50272 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933898Ab1JEGPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Oct 2011 02:15:07 -0400
In-Reply-To: <4E8BF21B.4010907@iki.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Antti Palosaari <crope@iki.fi>
Cc: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, linux-media@vger.kernel.org, linux-usb@vger.kernel.org, =?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>, James Courtier-Dutton <james.dutton@gmail.com>, HoP <jpetrous@gmail.com>, =?iso-8859-1?q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>

Am Mittwoch, 5. Oktober 2011, 07:58:51 schrieb Antti Palosaari:
> On 10/05/2011 07:59 AM, Greg KH wrote:

> > Why not just use the usb-serial core and then you get a ttyUSB* dev=
ice
> > node "for free"?  It also should provide a lot of the basic tty
> > infrastructure and ring buffer logic all ready to use.
>=20
> Since I don't see how I can access same platform data from DVB USB  a=
nd=20
> USB-serial driver (usb_set_intfdata). I asked that earlier, see:=20
> http://www.mail-archive.com/linux-media@vger.kernel.org/msg36027.html

Yes, and I'll have to give you the same answer as then.

But, Greg, Antti makes a very valid point here. The generic code assume=
s that
it owns intfdata, that is you cannot use it as is for access to anythin=
g that lacks
its own interface. But this is not a fatal flaw. We can alter the gener=
ic code to use
an accessor function the driver can provide and make it default to get/=
set_intfdata

What do you think?

	Regards
		Oliver
--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
