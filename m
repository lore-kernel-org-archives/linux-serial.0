From: Peter Astrand <peter@cendio.se>
Subject: Re: Serial port redirection
Date: Fri, 5 Dec 2003 10:11:48 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312051007200.11858-100000@maggie.lkpg.cendio.se>
References: <3FCDE5CB.4090303@acm.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1;
	FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:242 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S263448AbTLEJLu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Dec 2003 04:11:50 -0500
In-Reply-To: <3FCDE5CB.4090303@acm.org>
Content-ID: <Pine.LNX.4.44.0312051007202.11858@maggie.lkpg.cendio.se>
List-Id: linux-serial@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: linux-serial@vger.kernel.org


> I've attached a ser2net patch for this.  Could you try it out?

It's a good start, but it's not enough. cyclades-ser-cli doesn't finish=
ed=20
the initialization; it seems to be waiting for ACKs for the=20
SET-MODEMSTATE-MASK op.=20


> >* ser2net is totally incompatible with cyclades-serial-client. This =
is
> >because ser2net interprets RFC2217 a bit differently. sredird sends
> >command "101" as ack for command "1", while ser2net sends "1". RFC22=
17 is
> >not very explicit about which way is most correct. The ser2net appro=
ach
> >looks better to me, but the sredird one is probably more widely used
> >(since Cyclades terminal server uses it, for example.) Probably, RFC=
2217
> >software needs to handle both cases.


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
