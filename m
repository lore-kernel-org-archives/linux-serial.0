From: Daniel Kreischer <3kreisch@informatik.uni-hamburg.de>
Subject: Initialization Packet in Serial Communication?!
Date: Thu, 22 May 2008 17:01:06 +0200
Message-ID: <48358AB2.2070602@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:63233 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbYEVPKs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 May 2008 11:10:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 0A3645AE
	for <linux-serial@vger.kernel.org>; Thu, 22 May 2008 16:59:59 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aEIKLnBgVpv4 for <linux-serial@vger.kernel.org>;
	Thu, 22 May 2008 16:59:58 +0200 (CEST)
Received: from [127.0.0.1] (rzdspc10.informatik.uni-hamburg.de [134.100.9.63])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPS id BACA669C
	for <linux-serial@vger.kernel.org>; Thu, 22 May 2008 16:59:57 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hey guys,

we are trying to make a small embedded sensor device (Crossbow's TelosB mote)[1] talk to a SmartCard reader
via a serial connection.
To do so, we checked which packets are being sent by a open source linux driver to the reader and successfully
replicated the behaviour manually with cutecom[2].
We then implemented a stripped down version of the driver on the mote, but when we attach the reader to it, it
won't answer to the commands sent by the mote.

We recognized a kind of initialization packet received by cutecom and even cat everytime we open a connection:
	00 00 80 00 00 00 80 00 80 80 80 80 80 80 80 80 80 80 80
        80 00 80 80 80 00 00 80 00 00 00 00 80 00 00 80 00 00

We don't seem to receive that packet when connecting the reader to the mote, though.
Connecting the mote via a null modem cable to the PC and imitating the reader's responses with cutecom does
work, so the driver on the mote is ok.

We have already debugged the 8250.c serial kernel driver with printk()s before every outb() and inb() to the
UART's registers and started writing a miniature user space driver to find out what causes the packet, but we
can't exactly replicate the behaviour manually, yet.

The question is: Does anybody of you know what that packet is about, and what triggers it?

Thanks for your help
Daniel



[1] http://www.xbow.com/Products/Product_pdf_files/Wireless_pdf/TelosB_Datasheet.pdf
[2] http://cutecom.sourceforge.net/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBSDWKok5eU1rRPXMNAQjXJw//fqsHKntQv9aVyHUF5WSuyE3ZhLHhT6qK
NoOVSJRqFr7iml7sQV/dvLJt3ZWlfWGlhV+N2i3Gg8zGVMrqtwdjV+CwE9tfTRUR
d6EmU17VIAb6Qa0WhSlIb6Ttns6kZwRihSVBK9CoiqAWp9J/dg1RH3Bvc9ZBJ9u2
WEtarWa6PA0zlb9VQ67sgcv640fpGGR910K5EDNEW2TXz2Mm+xXEId5cI0eWlUle
iURG13U9gzjKB2cAPXzTTLy+y+FoLeUHo7N1tUPzQXLkhSzEMWk7uD+4zTeKALC0
pJznBR7lF5lNk+XQLXJq4vHUETwLgs0wR5mptPBIuH/tGWyRrwtrbxp9c52fEbqh
3WZio5w9PdhsZTvDo1Q0zy3QDc/bPIrF2+6cJg+Q/dCjS2grKr5FtYuj9jyd61QU
2Bzvp5Ll1jPX3j1LAIYUKf/Vod9cyGMJPIm/qBdeAl/I/EugS7OolcLVbOnz5g/m
lfMeYj3IBG4UeU0IJ1Quv3l4T+FZTz4yFHS/d/e/y9GpTTSiaT6h3taamJWaAvqS
4EyJx6ekLQBzgqTwGbhAPZMuDRUGJsbdQO3dbdNsOEvpGPyN7XL2vvRpISQyYOC9
zGkyURDHFJPaObX/rVUZLk3PeYaKiJX5xc+PB+m6zyHH8e4B1GLrUylaRp/27DO+
6HahuHOW2jo=
=3lL/
-----END PGP SIGNATURE-----
