From: Harald Welte <laforge@gnumonks.org>
Subject: Fix compilation of serial driver (AFAVLAB serial fix) [akpm@osdl.org: Re: Missing declaration in BK head...]
Date: Sat, 6 Mar 2004 10:33:37 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040306093337.GX1105@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUq9BFDytUJq8bQY"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:61382 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261160AbUCFJmu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Mar 2004 04:42:50 -0500
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org
Cc: rmk+serial@vger.kernel.org, linux-serial@vger.kernel.org


--cUq9BFDytUJq8bQY
Content-Type: multipart/mixed; boundary="bqPh76xD3yWylqqJ"
Content-Disposition: inline


--bqPh76xD3yWylqqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus, Russell:

Please apply Andrew Morton's fix (Cc'ed in attachment), it is obviously
correct.  My patch was somehow missing the #define, though my local tree
has the change :(

Sorry for the confusion.

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--bqPh76xD3yWylqqJ
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: Received: from ganesha.gnumonks.org ([unix socket])
	by ganesha (Cyrus v2.1.15-IPv6-Debian-2.1.15-0woody.1.0) with LMTP; Sat, 06 Mar 2004 02:50:47 +0100
X-Sieve: CMU Sieve 2.2
Return-path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by ganesha.gnumonks.org with esmtp (Exim 4.30)
	id 1AzQxi-0002KS-MF
	for laforge@gnumonks.org; Sat, 06 Mar 2004 02:50:46 +0100
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i261oeE24383;
	Fri, 5 Mar 2004 17:50:40 -0800
Date: Fri, 5 Mar 2004 17:52:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osdl.org, laforge@gnumonks.org
Subject: Re: Missing declaration in BK head...
Message-Id: <20040305175241.68d2466c.akpm@osdl.org>
In-Reply-To: <1078537117.4847.37.camel@nidelv.trondhjem.org>
References: <1078537117.4847.37.camel@nidelv.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.4 (----)

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> PCI_DEVICE_ID_AFAVLAB_P030 is not declared in pci_ids.h, so the patch 
> laforge@org.rmk.(none)|ChangeSet|20040305204131|29467
> is causing a compile error.
> 
> drivers/serial/8250_pci.c:1896: error: `PCI_DEVICE_ID_AFAVLAB_P030'
> undeclared here (not in a function)

Fix is straightforward:


diff -puN include/linux/pci_ids.h~afavlab-fix include/linux/pci_ids.h
--- 25/include/linux/pci_ids.h~afavlab-fix	Fri Mar  5 17:50:49 2004
+++ 25-akpm/include/linux/pci_ids.h	Fri Mar  5 17:51:03 2004
@@ -1808,6 +1808,7 @@
 
 #define PCI_VENDOR_ID_AFAVLAB		0x14db
 #define PCI_DEVICE_ID_AFAVLAB_P028	0x2180
+#define PCI_DEVICE_ID_AFAVLAB_P030	0x2182
 
 #define PCI_VENDOR_ID_BROADCOM		0x14e4
 #define PCI_DEVICE_ID_TIGON3_5700	0x1644

_


--bqPh76xD3yWylqqJ--

--cUq9BFDytUJq8bQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFASZrxXaXGVTD0i/8RAhTdAKCKoz2HdM9UiaH544Pn6v3jAkpvuQCgj1Db
Hao9SKw7tPgmIuP7evycQyc=
=J0hK
-----END PGP SIGNATURE-----

--cUq9BFDytUJq8bQY--
