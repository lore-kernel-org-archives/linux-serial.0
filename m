From: Peter Astrand <peter@cendio.se>
Subject: Re: sredird fork: sercd
Date: Wed, 4 Aug 2004 20:44:59 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0408042040400.6660-100000@maggie.lkpg.cendio.se>
References: <20040804140225.A6598@shire.hbsrx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cheddar.cendio.se ([193.12.253.77]:44789 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S267372AbUHDSpA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Aug 2004 14:45:00 -0400
In-Reply-To: <20040804140225.A6598@shire.hbsrx.com>
List-Id: linux-serial@vger.kernel.org
To: Thomas J Pinkl <tom@hbsrx.com>
Cc: Jeffrey Altman <jaltman@columbia.edu>, linux-serial@vger.kernel.org

> > This sounds interesting. How is it possible to support multiple mod=
ems? Is=20
> > this supported per-se in RFC2217?
>=20
> I can't think of anything in RFC2217 that dictates how many modems=20
> a server can support.  It is my understanding that Cisco access=20
> servers, for example, provide a pool of modems behind a single=20
> TCP/IP server port.  Note, however, that I've never seen or used a=20
> Cisco access server.  :-)
>=20
> At any rate, that is the model that I implemented in telnetcpcd: a=20
> single TCP/IP listener that fork()'s a child process to handle the=20
> client.  The child process allocates a modem from the pool by=20
> selecting one at random and trying to UUCP lock it.  It repeats that

Aha, now I get it. I thought you had some mechanism to select which mod=
em=20
to use. For our purposes, we are using the protocol to make the serial=20
ports on thin clients available at the server. If the client has multip=
le=20
serial ports, it's awkward to have to run multiple servers on multiple =
TCP=20
ports. It would be nice if it was possible to use a single 2217-server,=
=20
and tell it which port we'd like to use.=20

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
