From: Gerald Emig <gme@emig-software.de>
Subject: Re: Update on problems with UPS
Date: Fri, 21 Feb 2003 11:41:36 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030221114136.7a8ec96a.gme@emig-software.de>
References: <20030221063220.GF5567@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030221063220.GF5567@wheat.boylan.org>
List-Id: linux-serial@vger.kernel.org
To: Ross Boylan <RossBoylan@stanfordalumni.org>, linux serial <linux-serial@vger.kernel.org>


Hi Ross,

you write that your modem card is ISA, that means it is a little bit ou=
t
of date.
I remember there were such cards that neither had jumpers nor
weren't PNP. Instead they had to be configured with a special SETUP
program, most often a DOS program. I still have a sound card that must
be handled in that manner. To make it work under Linux, I had to insert
the card in a DOS PC and confiure it there.

If this is the case with your card and you do not have the config
utility, you can try the website of the manufacturer (silly to note).

If nothing helps, try to set your parallel port to use IRQ 7 in the
BIOS.

Gerald

On Thu, 20 Feb 2003 22:32:20 -0800
Ross Boylan <RossBoylan@stanfordalumni.org> wrote:

> I wrote a few weeks ago about some problems using an APC UPS with the
> serial port.
>=20
> I've made some progress, but things are still not quite working right=
=2E
>=20
> Originally, I got "LSR safety check engaged" on ttyS1 where the APC
> was connected.  This went away when I disabled COM1 (aka ttyS0) in
> BIOS, since I no longer use it.  However, I am still sharing an IRQ
> between ttyS2 (from my ISA modem card) and the parallel printer.
>=20
> It's not clear the sharing is causing trouble--both seem to be workin=
g
> OK.  Does anyone know if it's a problem?
>=20
> At any rate, it is puzzling to me that I can't control the IRQ for th=
e
> modem.  Only COM1/2 are configurable from BIOS.  I can also control
> the parallel port from the BIOS, and I though putting it to IRQ5 woul=
d
> force COM3 elsewhere.  It doesn't seem to.  I can reprogram the modem
> through isapnp, but unless I put it to the IRQ 5 that ttyS2 gets on
> startup, it doesn't work.  (Some people suggested the card might be
> set through jumpers, but it's not).  I've also tried restarting after
> reprogramming the modem, in hopes the new IRQ would stick, but it
> doesn't.
>=20
> Can anyone clarify what is going on with COM3?  I thought the modem
> serial port was actually part of the card, and that reseting the card
> through pnp would change the modem and the serial port.  The behavior
> I'm seeing looks more like the serial port and the modem are distinct
> devices, and pnp only affects the modem.  (My other theory is that pn=
p
> affects both, but the serial driver doesn't know what's going on if I
> move the location after startup.  This would also explain why the
> modem doesn't work after I move the IRQ, but I thought I understood
> someone on this list saying the serial driver could cope with such
> moves.)=20
>=20
>=20
> On the original problem with the UPS, there is progress too.  It is n=
o
> longer disabled by the system.  I believe the cause is the the apcups=
d
> demon can now talk to the port, and puts more appropriate values out
> to it.
>=20
> Things aren't quite right at this level either, because the demon is
> not responding, or responding properly, to power out signals.  I have
> not yet had time to triple check my configuration settings for the
> software; they might be off.  Or the software may not be quite right
> for the cable I have, which has a slightly different model number tha=
n
> any listed in the apcupsd software description.
>=20
> Thanks for taking the time to read this.  If you have any thoughts,
> answers or suggestions, I'd love to hear them.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Gerald Emig

--
EMIG Software           Tel. 06858-6197, Mobil: 0163-4751706
Engelstr. 17            Fax. 0721-151-348672
66564 Ottweiler-F=FCrth   http://www.emig-software.de
Germany                 e-mail: gme@emig-software.de

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
