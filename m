From: Peter Astrand <peter@cendio.se>
Subject: Re: sredird fork: sercd
Date: Sun, 1 Aug 2004 19:18:20 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0408011907440.14207-100000@maggie.lkpg.cendio.se>
References: <410D1DF7.8080201@columbia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cheddar.cendio.se ([193.12.253.77]:42736 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S265977AbUHARSW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Aug 2004 13:18:22 -0400
In-Reply-To: <410D1DF7.8080201@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>, Thomas Pinkl <tom@hbsrx.com>
Cc: linux-serial@vger.kernel.org


> A much better implementation of Telnet CPC, "telnetcpcd", was put
> together by Thomas Pinkl <tom@hbsrx.com>. He has open sourced it and =
the
> code quality is quite high. =20

What does "better" mean? This software looks much younger than
sredird/sercd, which probably means more bugs. I cannot find a home pag=
e,
CVS repository, mailing list, freshmeat entry or documentation. The bui=
ld
system is not Autoconfized. The tarball unpacks all the files in the
current directory...

Tell me, in what way was sredird so fundamentally broken that a complet=
e
rewrite was necessary?

Now we have *four* Open Source RFC2217 servers for UNIX...


--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
