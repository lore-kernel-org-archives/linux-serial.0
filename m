From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Mon, 8 Dec 2003 11:11:12 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312081107080.17608-100000@maggie.lkpg.cendio.se>
References: <Pine.LNX.4.44.0312081047190.10908-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:28413 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S265362AbTLHKLO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Dec 2003 05:11:14 -0500
In-Reply-To: <Pine.LNX.4.44.0312081047190.10908-100000@maggie.lkpg.cendio.se>
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-serial@vger.kernel.org

> > Here's another patch, relative to 2.0 of ser2net.  Hopefully it fix=
es=20
> > this problem.
>=20
> I've tried the latest CVS now. It works better: cyclades-ser-cli now=20
> initializes correctly. However, I'm not able to sync with pilot-xfer:=
=20
> pilot-xfer does not detect when I'm pressing the sync button. With=20
> sredird, this works (but the communication stops after listing four=20
> databases.)

I've tested photopc as well, with cyclades-ser-cli:

* With sredird, commands like "query" works, but "list" fails.=20

* With ser2net, "query" fails after getting the first parameter.=20


--=20
Peter =C5strand		www.thinlinc.com
Cendio			www.cendio.se
Teknikringen 3		Phone: +46-13-21 46 00
583 30 Link=F6ping


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
