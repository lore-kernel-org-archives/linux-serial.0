From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH] drivers/isdn/gigaset: new M101 driver
Date: Tue, 13 Feb 2007 00:49:58 +0100
Message-ID: <45D0FD26.9030804@imap.cc>
References: <200702012112.l11LCOO4016557@lx1.pxnet.com> <20070201171345.bd98ce30.akpm@osdl.org> <20070203160932.GA32523@kroah.com> <45C52848.50705@imap.cc> <20070212184712.GC32607@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig416C1B2D87FC86DBF3955FA2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030531AbXBLXtQ@vger.kernel.org>
In-Reply-To: <20070212184712.GC32607@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Karsten Keil <kkeil@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i4ldeveloper@listserv.isdn4linux.de, linux-serial@vger.kernel.org, Hansjoerg Lipp <hjlipp@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig416C1B2D87FC86DBF3955FA2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.02.2007 19:47 schrieb Greg KH:

>>>>> +static void gigaset_device_release(struct device *dev)
>>>>> +{
>>>>> +	//FIXME anything to do? cf. platform_device_release()
>>>>> +}

> The memory of the platform device itself needs to be freed here,
> otherwise, to do it earlier would cause race conditions and oopses.

I don't do it earlier. I do it later. My platform_device structure
is part of my driver's device state structure which is freed
explicitly later after the call to platform_device_unregister().
Is that bad?

> Look at how the other platform drivers do things.

They do things differently from each other as well as from mine.
block/floppy.c, for example, just has a call to complete() there.

Anyway, in the latest version of my driver, its platform_device
release function finally does something, too: it frees
dev->platform_data and pdev->resource just in case something
might have materialized there. I hope that's ok.

Regards,
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig416C1B2D87FC86DBF3955FA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0P0uMdB4Whm86/kRAtUuAJ4/66YsinszZR3vd9tjFQD5xKzJigCdHE9w
lBfcHwSZT9mBjjsUgBBmShQ=
=q1e5
-----END PGP SIGNATURE-----

--------------enig416C1B2D87FC86DBF3955FA2--
