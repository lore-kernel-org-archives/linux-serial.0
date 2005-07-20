From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] 8250 PCI Serial driver not always disabling PCI device
Date: Wed, 20 Jul 2005 10:24:29 +0200
Message-ID: <200507201024.36611@bilbo.math.uni-mannheim.de>
References: <200507200927.06500@bilbo.math.uni-mannheim.de> <20050720090323.A1864@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3912765.rQhTy53zk2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:13707 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261267AbVGTIUX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jul 2005 04:20:23 -0400
In-Reply-To: <20050720090323.A1864@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

--nextPart3912765.rQhTy53zk2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 20. Juli 2005 10:03 schrieb Russell King:
>On Wed, Jul 20, 2005 at 09:27:05AM +0200, Rolf Eike Beer wrote:
>> I found that pciserial_remove_one() only disables the device if it finds
>> private data. This looks suspicious to me. Patch attached.
>
>Makes no difference.  If we don't have the private data set, then
>we have errored out during the initialisation, and we disabled the
>device on the way out.  Moreover, the exit function won't even be
>called.
>
>So we actually have the guarantee that there will always be private
>data here.

In this case we should just kill the test if the private data is present. I=
f=20
something is seriously wrong this will oops and not hide the bug. This is=20
done in other places the same way.

Eike

--nextPart3912765.rQhTy53zk2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC3gpEXKSJPmm5/E4RAiuOAJ463fKh3J/6lQSVca3uIDhjDMrHPACfSiDI
4/jxz4hU+Y2f3IdewvAl39Q=
=gZOa
-----END PGP SIGNATURE-----

--nextPart3912765.rQhTy53zk2--
