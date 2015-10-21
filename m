From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: console vs earlycon ?
Date: Wed, 21 Oct 2015 21:00:24 +0200
Message-ID: <3890353.0icCv0Zeuq@wuerfel>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com> <4963882.HSXu6hF7zO@wuerfel> <5627AFFF.6060900@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5627AFFF.6060900@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wednesday 21 October 2015 11:32:15 Peter Hurley wrote:
> On 10/21/2015 10:13 AM, Arnd Bergmann wrote:
> > On Wednesday 21 October 2015 09:53:47 Peter Hurley wrote:
> > 
> > Ah, I had no idea we were moving in this direction.
> 
> I would not say this was a conscious design decision, but rather an
> outcome of getting-something-working-without-breaking-existing-usage.
> 
> My main focus with earlycon/console has been to try to reduce and
> generalize the existing code.

Ok.

> >> I'm assuming the issue with trying to get console_init() working
> >> is because the dummy color console causes the earlycon to be disabled?
> > 
> > I don't think so.
> > 
> > My line of thinking was more about usability: earlycon requires that
> > you edit the kernel command line at the moment, while console_init()
> > doesn't require any user interaction and just uses the stdout-path.
> > 
> > I guess we could enable earlycon using a Kconfig symbol if we want
> > to, or make it a per-architecture decision whether it's enabled even
> > in the absence of the command line flag.
> 
> Ah, I see. You want to start the stdout-path console at console_init()
> time.

Yes, I see this as a tradeoff: we want the console to be as early as
possible in order to report boot-time errors to the user, but not so early
to require hacks that can cause problems themselves. earlycon has to
do some scary stuff and is relatively recent, while the hacks
necessary for console_init() are much older and better tested.

	Arnd
