From: Peter Astrand <peter@cendio.se>
Subject: Re: sredird fork: sercd
Date: Wed, 4 Aug 2004 18:17:11 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0408041809001.6038-100000@maggie.lkpg.cendio.se>
References: <20040804110755.A17278@shire.hbsrx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cheddar.cendio.se ([193.12.253.77]:48628 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S267333AbUHDQRP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Aug 2004 12:17:15 -0400
In-Reply-To: <20040804110755.A17278@shire.hbsrx.com>
List-Id: linux-serial@vger.kernel.org
To: Thomas J Pinkl <tom@hbsrx.com>
Cc: Jeffrey Altman <jaltman@columbia.edu>, linux-serial@vger.kernel.org


> Unfortuneately, sredird 1.1.8 had some bugs that prevented it from=20
> working with C-Kermit.  It also had some design limitations, such as=20
> supporting one modem per server/port, that I couldn't live with.

This sounds interesting. How is it possible to support multiple modems?=
 Is=20
this supported per-se in RFC2217?

> Jeff quickly fixed the bugs in sredird.  But I had already decided=20
> to write my own server.  By February 2002, I had a version working=20
> (mostly) in-house.  By December 2002, nearly all of the wrinkles had=20
> been ironed out of C-Kermit and telnetcpcd.  In August 2003, I=20
> received offical permission from HBS management to release telnetcpcd=
=20
> under an open source license.

I do appreciate this; the more open source the better.=20

> year.  I expect that to change, soon.  One of the things on the TODO=20
> list is to autoconf-ize the build process.  Pointers to a resource=20
> that could help with that process would be most welcome.

seul.org/docs/autotut is recommended in ESRs TAOUP, but there are many=20
more.=20

> Peter, you mention that there are 4 open source RFC2217 servers for=20
> UNIX.  I know of sredird and telnetcpcd.  Can you tell me about sercd
> and the fourth one?

When thinking about it, there are at least five:

1. sredird
2. msredird
3. telnetcpcd
4. ser2net
5. sercd

> Why was sredird forked to create sercd?

I've explained this recently on this list: Is there an archive somewher=
e,=20
perhaps?=20

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
