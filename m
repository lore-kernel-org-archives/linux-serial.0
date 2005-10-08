From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [patch 3/4] new serial flow control
Date: Sun, 9 Oct 2005 00:27:11 +0200
Message-ID: <20051008222711.GA5150__38633.4684830674$1128813490$gmane$org@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailfe14.tele2.fr ([212.247.155.172]:14271 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751164AbVJHXPg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Oct 2005 19:15:36 -0400
Received: from [80.170.13.95] (HELO bouh.famille.thibault.fr)
  by mailfe14.swip.net (CommuniGate Pro SMTP 4.3.4)
  with ESMTPS id 32312261 for linux-serial@vger.kernel.org; Sun, 09 Oct 2005 01:15:32 +0200
Received: from samy by bouh.famille.thibault.fr with local (Exim 4.54)
	id 1EONub-0004uh-97
	for linux-serial@vger.kernel.org; Sun, 09 Oct 2005 01:15:29 +0200
Content-Disposition: inline
In-Reply-To: <20050105235301.B26633@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org

Hi,

I'm re-opening a somewhat old thread about serial flow control methods:

Russell King, le Wed 05 Jan 2005 23:53:01 +0000, a =E9crit :
> we have other people
> who want to use their on-board hardware RS485 flow control options on
> UARTs for their application, which means we need an RS485 flow contro=
l
> method.  (They can't select it without accessing the hardware directl=
y.)
>=20
> So, we now seem to have:
>=20
> 	Standard flow control
> 	CTVB flow control
> 	RS485 RTS flow control

Let's add a new one: Inka braille devices, which uses RTS/CTS as
acknowledge strobes for each character.

> I still believe that flow control should be enabled by CRTSCTS, but
> the flow control personality set by other means.
>=20
> Therefore, I think this requires further discussion, especially with
> Alan (who seems to be the tty layer god now) to work out some sort of
> reasonable interface.

How could this look like in userspace? Something like

#define CRTSCTS_RS232 0
#define CRTSCTS_RS485 1
#define CRTSCTS_TVB 2
#define CRTSCTS_INKA 3
	int method =3D CRTSCTS_RS485;
	ioctl(fd,TIOCMSFLOWCTRL,&method);

(and the converse TIOCMGFLOWCTRL)?

Regards,
Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
