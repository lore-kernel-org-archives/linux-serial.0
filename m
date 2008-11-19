From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: [PATCH v2] serial: set correct baud_base for Oxford Semiconductor
 Ltd EXSYS EX-41092 Dual 16950 Serial adapter
Date: Wed, 19 Nov 2008 14:11:54 +0100
Message-ID: <4924109A.4060202@wincor-nixdorf.com>
References: <48D79977.30403@wincor-nixdorf.com> <20080922141550.6e043f44@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20C42DBDC60F7F7BCE2EF613"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mxpdbe1.wincor-nixdorf.com ([80.154.98.129]:54529 "EHLO
	mxpdbe1.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752924AbYKSNWv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Nov 2008 08:22:51 -0500
Received: from cfpdbx1.wincor-nixdorf.com (unknown [10.254.32.9])
	by mxpdbe1.wincor-nixdorf.com (Postfix) with ESMTP id 7EB742A4044
	for <linux-serial@vger.kernel.org>; Wed, 19 Nov 2008 13:14:09 +0000 (GMT)
In-Reply-To: <20080922141550.6e043f44@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20C42DBDC60F7F7BCE2EF613
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Alan Cox wrote:
> On Mon, 22 Sep 2008 15:11:19 +0200
> Niels de Vos <niels.devos@wincor-nixdorf.com> wrote:
>=20
>> The PCI-card identified as "Oxford Semiconductor Ltd EXSYS EX-41092
>> Dual 16950 Serial adapter" is only usable with other devices (i.e.
>> not the same card) after doing a "setserial /dev/ttyS<n> baud_base
>> 115200". This baud_base should be default for this card.
>>
>> Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>
>=20
> Ok we'll give that one a go and hopefully it won't clash with
> anything else this time. Queued for the ttydev tree

I'm unable to find this change (http://lkml.org/lkml/2008/9/22/143) in
2.6.28-rc5, linux-next or http://www.linux.org.uk/~alan/ttydev/. Do I
miss something?

Thanks,
Niels



--------------enig20C42DBDC60F7F7BCE2EF613
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJJBCa5KAkGQPO/QoRAgrpAJsFFlR4Z7TTMRNHyrGctXLiGK+t4ACgkQhs
XLuZjopxH+Y67ABwPpiaAPo=
=msdE
-----END PGP SIGNATURE-----

--------------enig20C42DBDC60F7F7BCE2EF613--
