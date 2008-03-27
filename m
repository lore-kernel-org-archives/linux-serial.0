From: Tilman Schmidt <tilman@imap.cc>
Subject: struct termios/termios2 rationale and usage
Date: Thu, 27 Mar 2008 12:23:08 +0100
Message-ID: <47EB839C.8070605@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3F1510D7D1A7C5B57634EB22"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757005AbYC0LXW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F1510D7D1A7C5B57634EB22
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

I'm currently trying to conceive of a way to portably use the "new"
(relatively) way of setting serial line bit rates via BOTHER and
c_ispeed/c_ospeed from a userspace utility. (ldattach(1), to be
included in the next release of util_linux_ng, in case you're
interested.) I notice that most architectures have introduced
new ioctls (TCGETS2 etc.) and struct termios2 for that, while some
(eg. powerpc) have integrated the c_ispeed/c_ospeed fields in
struct termios and supposedly get/set them via the old "non-2"
ioctls.

What's the rationale behind this? What is the recommended usage
for a Linux userspace program wanting to use the BOTHER speed
setting mechanism on a variety of architectures?

Thanks,
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig3F1510D7D1A7C5B57634EB22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH64OcQ3+did9BuFsRAhX7AJ99jD9gZBfz4jMi6TyjeNwvJEtWvwCfd3iU
EMveIuIZ8TDfqFl+VhiUpYE=
=bd46
-----END PGP SIGNATURE-----

--------------enig3F1510D7D1A7C5B57634EB22--
