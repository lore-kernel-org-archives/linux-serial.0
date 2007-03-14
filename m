From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 14 Mar 2007 12:07:58 +0100
Message-ID: <001d01c76629$06da71a0$2e01a8c0@acksys.local>
References: <m34poq39dg.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp25.msg.oleane.net ([62.161.4.25]:48983 "EHLO
	smtp25.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161107AbXCNLIH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Mar 2007 07:08:07 -0400
In-Reply-To: <m34poq39dg.fsf@maximus.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Krzysztof Halasa' <khc@pm.waw.pl>
Cc: linux-serial@vger.kernel.org

Krzysztof Halasa wrote:

> > It has always been the standard for all modems.
>
> Look, I've been using various modems for many years, starting with
> self-made 300 bps one and there were basically 3 options:
> - no flow control at all (no buffering etc), RTS/CTS disabled/missing=
,
> - XON/XOFF flow control, RTS/CTS disabled/missing,
> - RTS/CTS handshaking with RTS =3D modem can send to computer (with
>   option to ignore RTS) and CTS =3D computer can send to modem.

Well, I know well that nowadays all modems use RTS for RX handshake or =
dont
use it altogether.
But the original meaning was not this (see below), and there are still
devices out there that rely on the original meaning. Should Linux ignor=
e
them ?

>
> > The mistake comes from the
> > fact that the serial ports has been used extensively to
> drive things which
> > are *not* modems (say, printers and VT100 consoles on Unix
> systems). Such
> > devices did not need the standard-specified RTS function.
>
> VT100 and printers are DTE, connections between DTE (without help
> of DCE) are obviously non-standard.

Yes.

>
> > CCITT V24 says about RTS: "...this signal drives the DCE
> and sets it to
> > transmit data..." (translated from french)
> > CCITT V24 does not constraint the DCE to being half or full duplex.
> > CCITT V24 says nothing about using RTS to handle flow control.
>
> Circuit 105 - Request to send
> Direction: To DCE
> Signals on this circuit control the data channel transmit function
> of the DCE. The ON condition causes the DCE to assume the data channe=
l
> transmit mode. The OFF condition causes the DCE to assume the data
> channel non-transmit mode, when all data transferred on circuit=A0103
> have been transmitted.

Thank you for pointing out the correct text.
You can see that in this text, RTS is used for the transmit function, n=
ot
receive. So RX handshake with RTS is nonstandard. But I agree it is in =
wide
use.

>
> What do you think are "data channel transmit mode" and "non-transmit"
> mode? Obviously the standard doesn't know if it's a radiomodem, RS-48=
5
> style multipoint bus or something else but it's clearly half-duplex -
> full-duplex devices are always in "transmit" and "receive" mode
> simultaneously.

If the standard assumed half-duplex, it would say so.
In fact, in its paragraph 1.3 the standard says explicitely that it can=
 be
used for 4-wires lines. Do you think you need four wires for half-duple=
x
operation ?

The standard specifies a behaviour that works in both cases (half and f=
ull
duplex).

I agree that nowadays, it's important only for half-duplex. But half-du=
plex
devices *do* exist ! And they rely on this use of RTS.

>
> Does your modem drop carrier when RTS goes?
>
> V.24 assumes DTE is always able to receive data. While it's probably
> the case with PC and Linux, it may not be true with all DTE. With
> strict V.24 DTE has not way to say "I can't take data, stop
> transmitting". Now imagine connecting a serial printer to a PC
> with a pair of DCE.

That is true, I agree that V.24 does not address flow control: this is
because V.24 is a DTE-to-DCE interface (part of layer 1), not a DTE-to-=
DTE
interface. This is why XON-XOFF has been designed.
It is assumed (remember that the standard is old) that the modem does n=
ot
have significant buffering. So it does not need flow control by itself.=
 This
is not the case for the modems which compress data, for example.

>
> >> I've seen such devices quite recently, perhaps ~ 10 years ago.
> >> OTOH I think even "current" PC BIOSes use such signaling.
> >
> > Even Windows implements the CCITT view of RTS, via a flag
> named "RTS_TOGGLE"
>
> Great, meanwhile we don't have it here, but that only means nobody
> is really interested in it.

In fact, there where many requests in the past to handle this, but they=
 did
not make it to the drivers/serial sources.
	For example there is a ioctl TIOCSERSETRS485 in the architecture that =
does
exactly this.
	Also I saw several people asking questions as to how to handle this fr=
om
user space in a reliable way and the answers were always unsatisfactory
(because of scheduling delays).
	Also, recent OXFORD UART components added this in the hardware. Do you
think OXFORD would add hardware features that nobody care about ? We ha=
ve
customers that care about a lot. Unfortunately there is not way in the =
Linux
8250 driver to activate this feature. And when I offered to add it, I w=
as
put off by the serial maintainer, for the (bad) reason below.

>
> >> For such signaling, it would perhaps be better to invent
> another flag,
> >> similar to CRTSCTS. The driver would, of course, need some
> real code
> >> for that.
> >
> > Another flag would help to drive modems, yes.
>
> Which modems, exactly? Normal modems work perfectly fine with current
> CRTSCTS and this RTS toggling could only confuse them.

All the bunch of half-duplex serial devices, like radio modems and
pseudo-modems driving an half duplex bus (which are in *wide* use in th=
e
industry)

> A flag alone is no help for half-duplex devices, they would need
> a complete handshaking code.

Not true.
This is also the view of the former maintainer of drivers/serial. But
obviously neither of you used half duplex devices before.
There is no need for handshake, since half duplex is used in master/sla=
ve
situations. And I can insure you, that Windows handles this very well, =
using
only the above-mentioned RTS_TOGGLE flag.

> --
> Krzysztof Halasa
>

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
