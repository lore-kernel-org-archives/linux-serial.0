From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Fri, 5 Dec 2003 16:43:46 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312051640490.18618-100000@maggie.lkpg.cendio.se>
References: <3FD0A538.8000400@columbia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:32496 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S264258AbTLEPnr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Dec 2003 10:43:47 -0500
In-Reply-To: <3FD0A538.8000400@columbia.edu>
List-Id: linux-serial@vger.kernel.org
To: Jeffrey Altman <jaltman@columbia.edu>
Cc: Corey Minyard <minyard@acm.org>, d.sbragion@infotecna.it, linux-serial@vger.kernel.org

On Fri, 5 Dec 2003, Jeffrey Altman wrote:

> >Perhaps we should make a new, updated RFC? It could include this vit=
al=20
> >information, as well as give advice on how to handle the different c=
ases.=20
> > =20
> >
>=20
> I am willing to do so.  I have a list of other Telnet RFCs which need=
 to
> be updated.  Unfortunately, the IETF has very little interest these d=
ays
> in updating the Telnet protocol.  Now that SSH is around the feeling =
is
> that Telnet should fade away and people who want this type of
> functionality should implement a new protocol on top of SSH.

Actually, we are using telnet+RFC2217 over an SSH TCP tunnel. I think t=
his=20
is a pretty clean solution. How could a "better" solution look like?


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
