From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Tue, 20 Jun 2006 16:39:49 +0200
Message-ID: <E1FshOP-0000pd-No@be1.lrz>
References: <6pwmi-8mW-1@gated-at.bofh.it> <6px8R-Y7-43@gated-at.bofh.it> <6pxV5-2ci-13@gated-at.bofh.it> <6pz12-3Rg-67@gated-at.bofh.it> <6pzX4-5jE-19@gated-at.bofh.it> <6pA6B-5K8-33@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:58240 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750951AbWFTOkL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jun 2006 10:40:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <lkml@rtr.ca>, Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-06-19 am 17:52 -0400, ysgrifennodd Mark Lord:

>> Eh?  The vast majority of ISA bus devices have open-collector IRQ li=
nes,
>=20
> Not in my experience. In the network work at least very few are, they
> all drive the chip lines all the time. Thats why Don Becker made sure
> such drivers grab the lines at startup. Those which can share IRQ or
> move IRQ grab at open

There are thousands of NE2K-clones, the driver can't know if sharing th=
e IRQ
will be OK for a given card. Is the change for sharing IRQs trivial eno=
ugh
to allow an if/else based on a load-time module parameter?
--=20
Ich danke GMX daf=FCr, die Verwendung meiner Adressen mittels per SPF
verbreiteten L=FCgen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
