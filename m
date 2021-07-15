Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED351C636C9
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E2C60720
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhGOTxV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:53:21 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60710 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347312AbhGOTwU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 15:52:20 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7C41E92009C; Thu, 15 Jul 2021 21:49:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6E03492009B;
        Thu, 15 Jul 2021 21:49:22 +0200 (CEST)
Date:   Thu, 15 Jul 2021 21:49:22 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk> <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk> <YOyi0cPdIVSCcpmw@surfacebook.localdomain> <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
 <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 13 Jul 2021, Andy Shevchenko wrote:

> > > Please no. We really would like to get rid of that ugly hack. The BOTHER exists
> > > for ages.
> >
> >  I have actually carefully considered it before submission and:
> >
> > 1. it remains a supported user API with a tool included with contemporary
> >    distributions, and
> 
> What supported API?

 The TIOCGSERIAL/TIOCSSERIAL ioctls.  It's not clear to me why you're 
asking; as a serial driver expert you must have been surely aware of their 
existence.

> > 2. with this device you can't set all the possible whole-number baud
> >    rates let alone UART clock frequencies with the BOTHER API, and
> 
> How does SPD_CUST make it different?

 You can program the divider registers directly with any bit pattern 
supported by hardware.  You don't know what use for it has been out there 
in the field for the last ~30 years.

> > 3. it doesn't hurt.
> 
> It hurts development a lot.

 It is there and the presence or absence of the feature for OxSemi devices 
does not affect anything but OxSemi support code.

> > If you'd like to get rid of SPD_CUST, then just do so, but until then I
> > fail to see a point to have it supported with some devices but not other
> > ones.
> 
> It _is_ the current state of affairs. Most of the contemporary drivers
> do not support this "feature" at all.

 It is currently a supported feature for OxSemi devices (and most if not 
all 8250 derivatives), and I don't see a reason to selectively remove it 
with this specifice submission.  There may be installations out there that 
rely on it -- there have been shortcomings in the implementation, which 
are the motivation for this patch series, but mind that we've had support 
for OxSemi Tornado devices since 2008.  That's a lot of time.

 Driver writers for other UART implementations may choose to have it or 
not to with their new code written from scratch.  As a matter of interest 
I've checked zs.c, one of the serial hw drivers I had considerable input 
to and it uses its own ZS_BPS_TO_BRG macro rather than `uart_get_divisor', 
so it does not support this feature (and dz.c only has a set of 15 fixed 
baud rates, which is where the original termio B<rate> macro bit patterns, 
as well as the EXTA and EXTB macros for the externally supplied clock 
chosen by the 16th bit pattern, come from).

 And as I say: if you want to remove it, then do it globally and tell 
people that as from Linux x.y.z this feature is no longer supported, so 
that is clear and unambiguos and some poor IT soul out there does not get 
hit by a random obscure driver feature removal with a kernel upgrade.

 NB in the course of this effort I've learnt the hard way that `setserial' 
is even invoked automatically nowadays in startup/shutdown scripts for 
port state saving and restoration, so a random unannounced feature removal 
here can wreak havoc with people's installations they have configured 
years ago.

> >  NB if you do get to it, then please consider adding an equally flexible
> > API too, e.g. for fractional baud rates (134.5bps haha); I won't mind if
> > it's less hackish though.
> 
> Why do you need fractional baud rates for the small speeds? I do not
> believe we have any good use case for that. And 1/2 from 134 is less
> than 0.5% which is tolerable by UART by definition.

 Just pointing out the incompleteness of the implementation should 
SPD_CUST be removed.

> So, please no, drop it.

 Based on my consideration given above, no, I maintain keeping the feature 
is the right approach, at least for this change concerned.  After all its 
purpose is to correct baud rate setting and not to remove vaguely related 
features.

> >  The relevant stuff has been included as comments along with actual code
> > already, and the rest is the usual submission-time rationale.  This will
> > be the initial source of information when someone studies the history of
> > this code (`git log').
> 
> I do not object to this, but perhaps in the form of documentation it
> would serve a better job (no-one will need to go deep into the Git
> history for this, especially non-developer people who just got a
> tarball, for example).

 Why would a non-developer need to dive into it while also hesitating to 
go through the git log?  Moreover, why would a developer hesitate digging 
through the git log while trying to understand code?

 Maybe I'm old-fashioned, but coming from long before we had any sensible 
repository (umm, the MIPS port and I believe m68k had CVS in the old days, 
but try to find anything with CVS!) let alone git I can't overrate my 
appreciation for its features, and our requirement for sensible change 
descriptions is not there for nothing.  So looking through `git log' is 
the first thing I do when I want to understand why a piece of code unknown 
to me looks like it does.

> >  I don't consider it cast in stone however, so if there's any particular
> > piece you'd like to see elsewhere, then please point out to me what to
> > move and where.  Or give any guidance other than just: "Rewrite it!"
> 
> At least that table with divisors and deviation with accompanying
> text. But I dare to say 90-95% of the commit message and leave
> something like "Here is a new driver. documentation is there." To
> where? Documentation/admin-guide seems most suitable right now
> (looking at the presence of auxdisplay folder), however I think that
> maybe dedicated folder like Documentation/hardware-notes maybe better.

 Not a new driver really, but a bug fix for the broken calculation we 
currently have given how inaccurately the particular input clock rate 
chosen by the designer of the ASIC gets divided at least for some of our 
standard baud rates.  You may have seen with my previous fix that the 
original submitter for the OxSemi handlers didn't even get the base baud 
rate right (and that stuff has been included as vendor-supplied drivers 
with various OxSemi-based serial port card manufacturers!), so I can't 
really tell what happened there.

 It looks to me like nice if not ultimate UART hardware ruined by broken 
software, sigh.  Which may have contributed to the withdrawal of the ASICs 
from manufacturing as with the extra quality stripped by missing software 
support obviously they may not have been able to compete solely by price 
with cheap UARTs made elsewhere that provide a basic feature set only (and 
no documentation).

 NB it does DMA as one would expect especially at the higher baud rates, 
and earlier OxSemi PCI or discrete UARTs have similar features (including 
the clock prescaler), none of which we handle.  If we started, only then I 
guess we could call it a new driver.  I have the datasheets, but I can't 
dedicate more time I'm afraid beyond what is absolutely necessary to get 
the broken PCIe stuff right.

 OK though, you've convinced me.

> +Cc: Mauro. What do you think about this? We need a folder where we
> rather describe hardware features and maybe some driver implementation
> details.

 Not for serial hardware drivers, but a while ago I committed what now 
lives at Documentation/networking/device_drivers/fddi/defza.rst along with 
several other networking driver notes, so I imagine we can have a similar 
collection for 8250 stuff and the like.

> >  I have found it unclear where the line is drawn between having support
> > code included with 8250_pci.c proper and having it split off to a separate
> > file.  All the device-specific files seem to provide complex handling,
> > well beyond just calculating the clock.
> 
> Lines of code in the current 8250_pci in conjunction with expansion.
> To me 331 (okay, it's something like 280?) LOC + sounds like a very
> good justification to split.

 OK, the size argument alone makes some sense to me, though OTOH splitting 
sources into many files prevents the compiler from doing interprocedural 
optimisations, which can only be partially compensated by LTO (if enabled 
in the first place).

 I'll see what I can do here anyway.  Mind that non-PCIe OxSemi stuff 
remains incomplete, as I noted above, so it'll be a partial driver anyway.

> > > > + * We iterate over the table and choose the product of an oversampling
> > > > + * rate and a clock prescaler that gives the lowest integer division
> > > > + * result deviation, or if an exact integer divider is found we stop
> > > > + * looking for right away.  We do some fixup if the resulting clock
> 
> for it right

 Fixed, thanks!

> >  Essentially we need to find such three integers (with extra constraints)
> > the product of which is closest to (500000000 / baud_rate) -- which IMHO
> > amounts to factorisation, an NP-complete problem as you have been surely
> > aware (and the whole world relies on), and I have decided that this simple
> > table-driven approximation is good enough to handle the usual baud rates,
> > especially the higher ones.  For several baud rates it gives more accurate
> > results (lower deviation) than the factors proposed in the manufacturer's
> > datasheets.
> 
> And my point is to calculate is always based on the asked baud rate.
> Yes. I understand what you wrote above and sometimes only brute force
> can be used, but in the kernel we have integer arithmetics which helps
> a lot besides the fact of bits twiddlings.

 Well, the algorithm is for finding the closest rational number expressed 
by a numerator and a denominator to the required one.  We have no problem 
with that, because the divisor is integer (which is of course a rational 
number too, but finding the numerator where the denominator if constant 1 
is trivial).

> >  I just fail to see how your proposed algorithm could be factored in here,
> > but I'll be happy to be proved wrong, so I'll appreciate guidance.
> 
> It's possible that it doesn't fit in the current form or for all three
> integers. Just give some time and think about it. Maybe you can come
> up with a better idea. I usually point to one case I have solved [1]
> to show that ugly tables can be dropped (in some cases it makes sense
> to leave them, though).
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-pxa2xx.c?id=9df461eca18f5395ee84670cdba6755dddec1898

 Well, I considered a naïve algorithm, but it would be quadratic, it would 
make a lot of redundant calculations, and division is not exactly a fast 
operation; some targets we support have no hardware division instruction 
even.  Needless to say it would still have to encode the ranges supported.  
And any code size gain from the naïve algorithm might still not match the 
268 bytes the table consumes, especially with RISC targets.

 I think my proposal is a reasonable compromise that addresses the problem 
at hand, and if you or anyone else finds a better solution sometime, then 
you are free to improve it.  Perfect is the enemy of good enough, so the 
potential existence of an ultimate solution that hasn't been discovered 
yet shouldn't block progress in a hope that the solution gets found soon 
enough.

 I'll repost the outstanding pieces of the series with the adjustments I 
have agreed to make.

  Maciej
