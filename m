From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Wed, 13 Dec 2006 00:50:07 +0100
Message-ID: <457F402F.2050901@imap.cc>
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com> <20061211102016.43e76da2@localhost.localdomain> <457D8E35.9050706@imap.cc> <457D9066.1030308@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3F940DA57FFC9604BA8785C8"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:60341 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932568AbWLMAVr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Dec 2006 19:21:47 -0500
In-Reply-To: <457D9066.1030308@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F940DA57FFC9604BA8785C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 11.12.2006 18:07 schrieb Corey Minyard:
> Tilman Schmidt wrote:
>> I was under the impression that line disciplines need a user space
>> process to open the serial device and push them onto it. Is there
>> a way for a driver to attach to a serial port through the line
>> discipline interface from kernel space, eg. from an initialization,
>> module load, or probe function?
>>  =20
> Module initialization functions run in a task context, so that's
> generally not a problem.  The probe function depends on the driver,
> I guess, but most I have seen are in task context.

Could you be a bit more specific? If I write a module implementing a
line discipline, how would I go about having that line discipline
push itself onto a given serial port (specified for example through a
module parameter) immediately, during its own module initialization?
I can't seem to find an in-kernel interface for that.

Also, if I understand correctly, this would only work if the driver
is compiled as a module, but such a limitation seems to be frowned
upon within the kernel community. Any way around that?

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig3F940DA57FFC9604BA8785C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFf0A3MdB4Whm86/kRAgm1AJ9o4VAfQXtK4vUZ+fRTxK/shmdJ9wCeOvi8
0OnO+d2TiT4l6YquYMCr5EM=
=Ae5U
-----END PGP SIGNATURE-----

--------------enig3F940DA57FFC9604BA8785C8--
