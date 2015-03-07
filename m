From: Sylvain Rochet <gradator@gradator.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Sat, 7 Mar 2015 11:20:56 +0100
Message-ID: <20150307102056.GA28436@gradator.net>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150307091846.GN23367@worktop.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Wim Van Sebroeck <wim@iguana.be>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@
List-Id: linux-serial@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Mar 07, 2015 at 10:18:46AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> > If everyone else is happy with this using IRQF_NO_SUSPEND for now then
> > don't let my comments above block this patch.
>=20
> Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().
>=20
> I really want that combo to BUG/WARN -- esp. since there's so much cargo
> culted crap out there.
>=20
> We should make robust interfaces, not randomly toggle flags until it
> mostly works by accident rather than by design -- which is what this
> feels like.
>=20
> And while I appreciate the watchdog use-case; I think the easiest
> solution for now is to simply disable the wathdog over suspend until
> we've come up with something that makes sense.
>=20
> As it is, you need to 'suspend' the watchdog at some point anyhow; you
> don't want that thing to wake you from whatever suspend state you're in.

The Atmel watchdog can't be stopped once it's started. This is actually=20
very useful so we can reset if suspend or resume failed, the only=20
drawback is that you have to wake up from time to time (e.g. by using=20
the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.

I am working on safety products and keeping the watchdog running=20
whatever the state is almost mandatory, one of the test on those=20
products is about unsoldering all the crystals live from your product=20
and the product should detect the general fault and power on a buzzer=20
and a yellow fault LED. This is usually done with a watchdog clocked=20
=66rom an internal RC of the =C2=B5C/SoC (so it can't be unsoldered ;-) and=
 a=20
GPIO with a reset state in input/pull-up, the device clamps the GPIO to=20
ground, if the watchdog resets the system the GPIO is going to switch=20
back to input therefore changing its state.

This can of course be done with an external watchdog circuitry, but it=20
costs more and will consume much more than using =C3=A0 1 =C2=B5A RC=20
oscillator/watchdog already present in the =C2=B5C/SoC.

Sylvain

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlT60QgACgkQDFub3qtEsS/NewCeMBqzyALPaZlNeLBf16zLi+sm
VE8AnAg3e1VUru9FutDq3F/4YMdJN4z9
=99rC
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
