From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Fri, 5 Dec 2003 10:19:05 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312051016290.11858-100000@maggie.lkpg.cendio.se>
References: <3FCF7026.6070109@columbia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:11506 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S263468AbTLEJTI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Dec 2003 04:19:08 -0500
In-Reply-To: <3FCF7026.6070109@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>
Cc: Corey Minyard <minyard@acm.org>, d.sbragion@infotecna.it, linux-serial@vger.kernel.org


> The reality is RFC is experimental and not authoritative.  The only=20
> thing that really counts is what Cisco actually shipped in their IOS=20
> implementation.  Lucky me I actually have a terminal
> server that implements it.  If you look at the C-Kermit sources you w=
ill=20
> see that the client is written to accept both values from the server.=
 =20
> You will also find that Cisco does not send the baudrates as specifie=
d=20
> in the RFC but instead uses an enumeration.
>=20
> With regards to the comment about the use of separate codes to indica=
te=20
> direction, this was written without a good understanding of the Telne=
t=20
> Option negotiation.  The reality is that there is no need for a telne=
t=20
> protocol option to have separate commands for each direction as the=20
> option itself must be negotiated separately in each direction. =20
> Therefore, there is no possibility of confusion.

Perhaps we should make a new, updated RFC? It could include this vital=20
information, as well as give advice on how to handle the different case=
s.=20


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
