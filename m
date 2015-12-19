From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Sun, 20 Dec 2015 00:42:15 +0300
Message-ID: <1450561335.15911.17.camel@gmail.com>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com>
	 <1450213494-21884-1-git-send-email-ynvich@gmail.com>
	 <1970812.j9fZPC5F1b@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1970812.j9fZPC5F1b@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>open list:
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-12-15 at 22:51 +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 00:04:45 Sergei Ianovich wrote:
> > +Examples (from pxa27x-lp8x4x.dts):
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0uart@9050 {
>=20
> By convention, the name should be 'serial', not 'uart'.
>=20

arch/arm/boot/dts/pxa2xx.dtsi uses 'uart'. Should I change the names in
the patch with dts file for LP-8xx?
