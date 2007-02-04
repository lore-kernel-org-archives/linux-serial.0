From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH] drivers/isdn/gigaset: new M101 driver
Date: Sun, 04 Feb 2007 01:26:48 +0100
Message-ID: <45C52848.50705@imap.cc>
References: <200702012112.l11LCOO4016557@lx1.pxnet.com> <20070201171345.bd98ce30.akpm@osdl.org> <20070203160932.GA32523@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCC966A4BBE90478EA21E2D6A"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751395AbXBDA0Q@vger.kernel.org>
In-Reply-To: <20070203160932.GA32523@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Karsten Keil <kkeil@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i4ldeveloper@listserv.isdn4linux.de, linux-serial@vger.kernel.org, Hansjoerg Lipp <hjlipp@web.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC966A4BBE90478EA21E2D6A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.02.2007 17:09 schrieb Greg KH:
> On Thu, Feb 01, 2007 at 05:13:45PM -0800, Andrew Morton wrote:
>>> +/* dummy to shut up framework warning */
>>> +static void gigaset_device_release(struct device *dev)
>>> +{
>>> +	//FIXME anything to do? cf. platform_device_release()
>>> +}
>> Ask Greg ;)
>=20
> Oh come on people.  Don't provide an empty function because the kernel
> is complaining that you don't provide a release function.  Yes it will
> shut the kernel up but did you ever think _why_ the kernel was
> complaining?

Actually, I did. Just guess how that FIXME came to be.
Hint: the kernel shuts up just as well without it.

>  Did you think it did it just for fun?

No, that was not among the explanations I considered. Although,
come to think of it ... nah, that would really be too weird.

> Think people, think...

Ahem.

> You need to free your memory here, don't just provide an empty function=
,
> that shows the driver is broken.

Call me silly and incapable of thinking, but to me it's far from
clear _what_ memory I am supposed to free there. Certainly neither
memory I will still be needing after platform_device_unregister()
nor memory that's being taken care of elsewhere. Between the two,
in my case there's nothing left, so the release function is empty.
If that shows my driver is broken, please explain in what way.

Thanks,
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigCC966A4BBE90478EA21E2D6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFxShPMdB4Whm86/kRAkcPAJ9UaOGHq2tMIcoAck/DL93oj+QNFwCggAAo
0U5RiYo8F7VJFQo3WMSaGwU=
=13DM
-----END PGP SIGNATURE-----

--------------enigCC966A4BBE90478EA21E2D6A--
