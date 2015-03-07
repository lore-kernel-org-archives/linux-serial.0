From: Sylvain Rochet <gradator@gradator.net>
Subject: Re: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
Date: Sat, 7 Mar 2015 11:59:53 +0100
Message-ID: <20150307105953.GC28436@gradator.net>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net> <20150307103939.GA17964@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4355315782724168944=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150307103939.GA17964@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Rutland <mark.rutland@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, Jiri Slaby <jslaby@suse.cz>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Wim Van Sebroeck <wim@iguana.be>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-k
List-Id: linux-serial@vger.kernel.org


--===============4355315782724168944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,


On Sat, Mar 07, 2015 at 11:39:39AM +0100, Pavel Machek wrote:
> On Sat 2015-03-07 11:20:56, Sylvain Rochet wrote:
> > Hello,
> >=20
> > On Sat, Mar 07, 2015 at 10:18:46AM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> > > > If everyone else is happy with this using IRQF_NO_SUSPEND for now t=
hen
> > > > don't let my comments above block this patch.
> > >=20
> > > Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().
> > >=20
> > > I really want that combo to BUG/WARN -- esp. since there's so much ca=
rgo
> > > culted crap out there.
> > >=20
> > > We should make robust interfaces, not randomly toggle flags until it
> > > mostly works by accident rather than by design -- which is what this
> > > feels like.
> > >=20
> > > And while I appreciate the watchdog use-case; I think the easiest
> > > solution for now is to simply disable the wathdog over suspend until
> > > we've come up with something that makes sense.
> > >=20
> > > As it is, you need to 'suspend' the watchdog at some point anyhow; you
> > > don't want that thing to wake you from whatever suspend state you're =
in.
> >=20
> > The Atmel watchdog can't be stopped once it's started. This is actually=
=20
> > very useful so we can reset if suspend or resume failed, the only=20
> > drawback is that you have to wake up from time to time (e.g. by using=
=20
> > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
>=20
> Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> after watchdog kills the system. But you did not ask for dead system,
> you asked for suspend.

Yeah, that's why I'm setting the RTC/RTT in the pm_enter() callback on=20
our products. On wake-up I'm checking if we woke up using the RTC/RTT in=20
the pm_suspend_again() callback, if true we clear the watchdog and we go=20
back to sleep. This can't easily be mainlined because it adds=20
RTC/RTT/WDT calls from PM code, which will not be accepted anyway.


> And while that behaviour is useful for you, I don't think it is
> exactly useful behaviour, nor it is the behaviour user would expect.

I agree, but it still can't be stopped, IMHO users wanting to suspend=20
without being protected by the watchdog during suspend and resume should=20
just don't use the hardware watchdog at all, they are already missing=20
the watchdog in a tricky area where the kernel can fail more than=20
anywhere else, the software watchdog should be fine as well for them.


Sylvain

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlT62ikACgkQDFub3qtEsS/wPQCeOF4qjzwkFNmeJHOyXcEP6TOc
4ywAn3dhXsiUQQrDnEqjIUCMMrAIAf3b
=LBGl
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--


--===============4355315782724168944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4355315782724168944==--
