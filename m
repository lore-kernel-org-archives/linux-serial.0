From: "Lewis Brown" <lewisb@denveronline.com>
Subject: RE: Best way to detect received call on dumb modem ...
Date: Sat, 1 Nov 2003 21:15:38 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <000801c3a0f7$fbd98a10$0200000a@francois>
References: <20031101211402.GV31376@lug-owl.de>
Reply-To: <lewisbrown@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail2.firstlink.com ([66.37.141.26]:51910 "EHLO
	mail1.firstlink.com") by vger.kernel.org with ESMTP id S261411AbTKBEPx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Nov 2003 23:15:53 -0500
Received: from francois (lewis.brown [66.37.132.7])
	by mail1.firstlink.com (Postfix) with ESMTP id CB67A12B738
	for <linux-serial@vger.kernel.org>; Sat,  1 Nov 2003 21:15:51 -0700 (MST)
In-Reply-To: <20031101211402.GV31376@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Sorry for not being more specific.

I thought a 'dumb' modem was one that had been taken out of command mod=
e
and thus does not respond to AT commands; at least that's what I meant.


I should say that this is an old problem that I haven't worked on in
over 9 months, so I've forgotten some of the details of my problem.  I
think that in dumb state, the modem can't send RING, CONNECT, etc., so
one must detect DSR, DTR, RNG, etc.  At least that's what I want to do.

When I wrote this program the first time, it worked great and was reall=
y
fast.  Then I moved it to the real hardware, a DIGI RAS box, which
didn't have all the standard IOCTLs.  The program now requires the
modems to be in command mode; I have to parse the stream for RING,
CONNECT, OK, etc;  and it is slow and very prone to error.  Seems the
modems are always going haywire this way.  I want to go back to dumb
mode and work as close as possible to the hardware.  I need speed and
reliability.

Any suggestions are much appreciated.
lb

-----Original Message-----
=46rom: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Jan-Benedict
Glaw
Sent: Saturday, November 01, 2003 2:14 PM
To: linux-serial@vger.kernel.org
Subject: Re: Best way to detect received call on dumb modem ...


On Sat, 2003-11-01 13:43:23 -0700, Lewis Brown <lewisb@denveronline.com=
>
wrote in message <000001c3a0b8$ce82efa0$0200000a@francois>:
> Hello,
>=20
> I'm trying to detect incoming calls on a dumb modem but dealing with =
a
> driver that doesn't implement TIOCMIWAIT or TIOCGICOUNT. I'm puzzled
how
> best to go forward in an efficient way.

select() on the fd and wait until you receive "RING"? However, what's a
"dumb" modem?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen
Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im
Irak!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM =
|
TCPA));


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
