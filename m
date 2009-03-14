From: Adam Goode <adam@spicenitz.org>
Subject: TIOCMIWAIT hopelessly broken?
Date: Fri, 13 Mar 2009 22:13:30 -0400
Message-ID: <49BB12CA.9000604@spicenitz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E7C8F991DA29CCAB02502FA"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45323 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbZCNCNg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Mar 2009 22:13:36 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 97ABA2EFAEA
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2009 22:13:34 -0400 (EDT)
Received: from [192.168.1.125] (c-71-236-65-235.hsd1.pa.comcast.net [71.236.65.235])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3053C183DE
	for <linux-serial@vger.kernel.org>; Fri, 13 Mar 2009 22:13:34 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E7C8F991DA29CCAB02502FA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

The ioctl TIOCMIWAIT seems to be inadequate for tracking changes in the
modem status lines. The main problem is that it cannot be used without
racing: if the status change you are waiting for happens before your
ioctl, you will wait forever.

A solution would be one like a eventfd, something that can be put to
poll(), epoll(), or select(), and where you read the status changes with
read().

Any ideas on how to do this? Would it be a new syscall, something in
/sys, a flag to open() ?


Thanks,

Adam


--------------enig6E7C8F991DA29CCAB02502FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkm7Es0ACgkQlenB4PQRJazjAACfRfZN5ujYgFQuyMxOHOKMZ6Uv
IbEAnisiPu+DFZrJiCJH/6PV3Y9x1yhp
=zvlX
-----END PGP SIGNATURE-----

--------------enig6E7C8F991DA29CCAB02502FA--
