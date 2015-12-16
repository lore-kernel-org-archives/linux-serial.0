From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Wed, 16 Dec 2015 11:26:38 +0100
Message-ID: <3230140.YE724HtqOd@wuerfel>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com> <1970812.j9fZPC5F1b@wuerfel> <1450253097.21989.78.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450253097.21989.78.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>open list:
List-Id: linux-serial@vger.kernel.org

On Wednesday 16 December 2015 11:04:57 Sergei Ianovich wrote:
> On Tue, 2015-12-15 at 22:51 +0100, Arnd Bergmann wrote:
> > On Wednesday 16 December 2015 00:04:45 Sergei Ianovich wrote:
> > > index 0000000..5f9a4c1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
> > > @@ -0,0 +1,35 @@
> > > +UART ports on ICP DAS LP-8x4x
> > > +
> > > +ICP DAS LP-8x4x contains three additional serial ports interfaced
> > > via
> > > +Analog Devices ADM213EA chips in addition to 3 serial ports on PXA
> > > CPU.
> > > +
> > > +Required properties:
> > > +- compatible : should be "icpdas,uart-lp8x4x"
> > 
> > Compatible strings should not include a 'x' wildcard like this, better
> > use
> > the specific chip name.
> > 
> > Also, it sounds like you named them after the board vendor, which
> > sounds
> > wrong as the vendor part of the compatible string should be the
> > whoever
> > made that part (analog?)
> 
> The chips themselves are standard, they would work with 8250_core if
> properly connected. However, they are not connected normally. Al least
> some of their config pins are wired to a different address region. So
> the driver is board-specific.

Ok, I see.

> 'x' wildcards in the name of the board seem important. There are devices
> made by the same vendor without 8 or 4 in their name. Those devices
> either are not shipped with linux or are base on a x86 platform.
> 
> Does this justify the choice of the compatible string?

What I meant was that you should use the specific numbers of one machine,
precisely for the reason you list above.

If there is e.g. a LP-8040 and a LP-8141 today, and you use lp8x4x in
the compatible string to cover both, this will no longer work when the
vendor comes out with a LP8047 that is completely different.

Instead, what you should do is to use the compatible string to identify
one particular board (e.g. the first one that used this setup), and
then list the other ones as compatible with this. You can also add the
other board names in addition, e.g.

compatible = "icpdas,uart-lp8041", "icpdas,uart-lp8040";

for a lp8041 that is compatible with the lp8040. If it turns out later
that they are not entirely compatible, we can work around this in the
driver by checking for the lp8041 string that will be matched first, while
the lp8040 can be used by the driver to match the entire family of
compatible machines (no need to list every one in the driver).

	Arnd
