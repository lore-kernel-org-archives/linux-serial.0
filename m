Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4944AC07E9B
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1D61002
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhGSOPC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbhGSOPC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jul 2021 10:15:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8DCC061574;
        Mon, 19 Jul 2021 07:24:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u14so19207699pga.11;
        Mon, 19 Jul 2021 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dt+yHf/YOpOWPLO6F+kkucPvjJAluwje+RhgrbXXDt0=;
        b=IydYWTn+miiQgF8g3CKqhdKYkIZDLpgv0NChVDKgspfKGTyoVmeEdAQfzLoRdFm9sH
         q4d4xDJaDE+92S37rb/ahBvv1p/4qRjp2GlAaQpuXakqUWUG8Mj1Lsye8QZUkbTSb1os
         irQoScV9avQ5YtQJ64Aq5Y6mDmIOGMVBtGU7MoDl4HlnfxxsKbCNYeopzhn56b7SNg5w
         0T4u3nSk33OP0Hmc7y+OiKcwYQCGk+4j76BoRQ+q092spbvzBB+LpnbVnwfpWLWk/vRR
         w6YaHdgo+dmA59oxpfLAJEoiLo0pcVTP1RlzOYjRiTonISJVGQHeEEoNBvv+s1lra6AF
         B3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dt+yHf/YOpOWPLO6F+kkucPvjJAluwje+RhgrbXXDt0=;
        b=ndjAsSYObqG3LVSkE28fmV1N77p+XuIMjyE5HLJAPremK131DjkZcKxnMivmgLUTCv
         QqRx09TiIScqUhnprsCqNngnnSluE4DCsK6EdrMMORL5A61HMw52DTSd3j7GFvOgIwL2
         WdduZRWaJtNGa3DBJ0p26FylbJ8dfusv9hwfa75baWCR2YNRzOYU9B/ULZ76WpXgi3FT
         yRXNHHbaF/luV1zqLm1fbS3UYT+AucpOX+k+r319h9gFpsU7E9vgmkRJbAPWkafWyYcy
         Id19VIab6g8iKYcsshuFhikIHRyjQ/5Z6PlDiRCLvLAAvdXR6zRCL6qC3bcdySFti9mj
         OYhQ==
X-Gm-Message-State: AOAM532mcuJpa2dEFSoIx+oV3i0S2GqvP9ch/hNNbarYKhtvx1F+Rbgf
        cqNFJw1p8uMylUjn6xr7RTGEEF7E5fvdiaDGZIA=
X-Google-Smtp-Source: ABdhPJyK5q/J1OCOeO1rpWwv5xKlikc0f30U7zjnQOlbo4xD5WKsEPgwrAxxa74cJ+dE4YEnnP8bVyE6iPoaCkp2vCs=
X-Received: by 2002:a65:434a:: with SMTP id k10mr25892210pgq.4.1626706541384;
 Mon, 19 Jul 2021 07:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
 <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk> <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
 <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk> <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
 <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 17:55:01 +0300
Message-ID: <CAHp75VeS3UdK5o4cEKuT=nz+Yob9FBv6RNJ-i116pFZQTGuyuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 15, 2021 at 10:49 PM Maciej W. Rozycki <macro@orcam.me.uk> wrot=
e:
> On Tue, 13 Jul 2021, Andy Shevchenko wrote:
>
> > > > Please no. We really would like to get rid of that ugly hack. The B=
OTHER exists
> > > > for ages.
> > >
> > >  I have actually carefully considered it before submission and:
> > >
> > > 1. it remains a supported user API with a tool included with contempo=
rary
> > >    distributions, and
> >
> > What supported API?
>
>  The TIOCGSERIAL/TIOCSSERIAL ioctls.  It's not clear to me why you're
> asking; as a serial driver expert you must have been surely aware of thei=
r
> existence.

Yes, I know how it's used. It's the ugliest hack in the serial support in L=
inux.
Telling that baud rate is 38400 and supplying something completely differen=
t,
non-standard stuff.

> > > 2. with this device you can't set all the possible whole-number baud
> > >    rates let alone UART clock frequencies with the BOTHER API, and
> >
> > How does SPD_CUST make it different?
>
>  You can program the divider registers directly with any bit pattern
> supported by hardware.

And again, how does it differ from BOTHER paths (except being a hack)?
You supply baud rate with 1 baud granularity and program hardware
registers accordingly. (Yes, I remember you pointed out the sub-HZ
frequencies, but I don't buy it as a very good argument because the
only significant error can be achieved at baud rates under the 100).

>  You don't know what use for it has been out there
> in the field for the last ~30 years.

Is it a question or statement?

> > > 3. it doesn't hurt.
> >
> > It hurts development a lot.
>
>  It is there and the presence or absence of the feature for OxSemi device=
s
> does not affect anything but OxSemi support code.

It's a pity. But what support code needs the SPD_CUST nowadays?

> > > If you'd like to get rid of SPD_CUST, then just do so, but until then=
 I
> > > fail to see a point to have it supported with some devices but not ot=
her
> > > ones.
> >
> > It _is_ the current state of affairs. Most of the contemporary drivers
> > do not support this "feature" at all.
>
>  It is currently a supported feature for OxSemi devices (and most if not
> all 8250 derivatives), and I don't see a reason to selectively remove it
> with this specifice submission.  There may be installations out there tha=
t
> rely on it -- there have been shortcomings in the implementation, which
> are the motivation for this patch series, but mind that we've had support
> for OxSemi Tornado devices since 2008.  That's a lot of time.
>
>  Driver writers for other UART implementations may choose to have it or
> not to with their new code written from scratch.  As a matter of interest
> I've checked zs.c, one of the serial hw drivers I had considerable input
> to and it uses its own ZS_BPS_TO_BRG macro rather than `uart_get_divisor'=
,
> so it does not support this feature (and dz.c only has a set of 15 fixed
> baud rates, which is where the original termio B<rate> macro bit patterns=
,
> as well as the EXTA and EXTB macros for the externally supplied clock
> chosen by the 16th bit pattern, come from).
>
>  And as I say: if you want to remove it, then do it globally and tell
> people that as from Linux x.y.z this feature is no longer supported, so
> that is clear and unambiguos and some poor IT soul out there does not get
> hit by a random obscure driver feature removal with a kernel upgrade.

I had had this in my plans [2] but suddenly I had no time to accomplish it.=
 :-(

>  NB in the course of this effort I've learnt the hard way that `setserial=
'
> is even invoked automatically nowadays in startup/shutdown scripts for
> port state saving and restoration, so a random unannounced feature remova=
l
> here can wreak havoc with people's installations they have configured
> years ago.

I believe that for these years spd_cust shouldn't be used at all. OK,
it seems the first thing we may do is to patch the user space to give
a fat warning that spd_cust is deprecated and should be avoided.
And... it seems already there [3].

> > >  NB if you do get to it, then please consider adding an equally flexi=
ble
> > > API too, e.g. for fractional baud rates (134.5bps haha); I won't mind=
 if
> > > it's less hackish though.
> >
> > Why do you need fractional baud rates for the small speeds? I do not
> > believe we have any good use case for that. And 1/2 from 134 is less
> > than 0.5% which is tolerable by UART by definition.
>
>  Just pointing out the incompleteness of the implementation should
> SPD_CUST be removed.
>
> > So, please no, drop it.
>
>  Based on my consideration given above, no, I maintain keeping the featur=
e
> is the right approach, at least for this change concerned.  After all its
> purpose is to correct baud rate setting and not to remove vaguely related
> features.

I see your point. My question here, does this series extend SPD_CUST
to additional (newly supported?) baud rates? If so, I would be against
that extension. Supporting deprecated stuff is okay for a while.

To the end of the discussion may be good to read also these [4] and [5]


> > >  The relevant stuff has been included as comments along with actual c=
ode
> > > already, and the rest is the usual submission-time rationale.  This w=
ill
> > > be the initial source of information when someone studies the history=
 of
> > > this code (`git log').
> >
> > I do not object to this, but perhaps in the form of documentation it
> > would serve a better job (no-one will need to go deep into the Git
> > history for this, especially non-developer people who just got a
> > tarball, for example).
>
>  Why would a non-developer need to dive into it while also hesitating to
> go through the git log?  Moreover, why would a developer hesitate digging
> through the git log while trying to understand code?
>
>  Maybe I'm old-fashioned, but coming from long before we had any sensible
> repository (umm, the MIPS port and I believe m68k had CVS in the old days=
,
> but try to find anything with CVS!) let alone git I can't overrate my
> appreciation for its features, and our requirement for sensible change
> descriptions is not there for nothing.  So looking through `git log' is
> the first thing I do when I want to understand why a piece of code unknow=
n
> to me looks like it does.

Tell me how to look into git logs without cloning a repository (I
think it's possible through some borken web UI somehow, but never
heard about it). In any case, either in the commit message or in the
code it will be in the repo, so not a big deal to me after all.

> > >  I don't consider it cast in stone however, so if there's any particu=
lar
> > > piece you'd like to see elsewhere, then please point out to me what t=
o
> > > move and where.  Or give any guidance other than just: "Rewrite it!"
> >
> > At least that table with divisors and deviation with accompanying
> > text. But I dare to say 90-95% of the commit message and leave
> > something like "Here is a new driver. documentation is there." To
> > where? Documentation/admin-guide seems most suitable right now
> > (looking at the presence of auxdisplay folder), however I think that
> > maybe dedicated folder like Documentation/hardware-notes maybe better.
>
>  Not a new driver really, but a bug fix for the broken calculation we
> currently have given how inaccurately the particular input clock rate
> chosen by the designer of the ASIC gets divided at least for some of our
> standard baud rates.  You may have seen with my previous fix that the
> original submitter for the OxSemi handlers didn't even get the base baud
> rate right (and that stuff has been included as vendor-supplied drivers
> with various OxSemi-based serial port card manufacturers!), so I can't
> really tell what happened there.

Yeah, it seems it has never worked before.

>  It looks to me like nice if not ultimate UART hardware ruined by broken
> software, sigh.  Which may have contributed to the withdrawal of the ASIC=
s
> from manufacturing as with the extra quality stripped by missing software
> support obviously they may not have been able to compete solely by price
> with cheap UARTs made elsewhere that provide a basic feature set only (an=
d
> no documentation).
>
>  NB it does DMA as one would expect especially at the higher baud rates,
> and earlier OxSemi PCI or discrete UARTs have similar features (including
> the clock prescaler), none of which we handle.  If we started, only then =
I
> guess we could call it a new driver.  I have the datasheets, but I can't
> dedicate more time I'm afraid beyond what is absolutely necessary to get
> the broken PCIe stuff right.
>
>  OK though, you've convinced me.
>
> > +Cc: Mauro. What do you think about this? We need a folder where we
> > rather describe hardware features and maybe some driver implementation
> > details.
>
>  Not for serial hardware drivers, but a while ago I committed what now
> lives at Documentation/networking/device_drivers/fddi/defza.rst along wit=
h
> several other networking driver notes, so I imagine we can have a similar
> collection for 8250 stuff and the like.

To me any folder is more or less okayish as long as it's there, under
the Documentation :-)

> > >  I have found it unclear where the line is drawn between having suppo=
rt
> > > code included with 8250_pci.c proper and having it split off to a sep=
arate
> > > file.  All the device-specific files seem to provide complex handling=
,
> > > well beyond just calculating the clock.
> >
> > Lines of code in the current 8250_pci in conjunction with expansion.
> > To me 331 (okay, it's something like 280?) LOC + sounds like a very
> > good justification to split.
>
>  OK, the size argument alone makes some sense to me, though OTOH splittin=
g
> sources into many files prevents the compiler from doing interprocedural
> optimisations, which can only be partially compensated by LTO (if enabled
> in the first place).
>
>  I'll see what I can do here anyway.  Mind that non-PCIe OxSemi stuff
> remains incomplete, as I noted above, so it'll be a partial driver anyway=
.

Thanks for doing that anyway!

> > > > > + * We iterate over the table and choose the product of an oversa=
mpling
> > > > > + * rate and a clock prescaler that gives the lowest integer divi=
sion
> > > > > + * result deviation, or if an exact integer divider is found we =
stop
> > > > > + * looking for right away.  We do some fixup if the resulting cl=
ock
> >
> > for it right
>
>  Fixed, thanks!
>
> > >  Essentially we need to find such three integers (with extra constrai=
nts)
> > > the product of which is closest to (500000000 / baud_rate) -- which I=
MHO
> > > amounts to factorisation, an NP-complete problem as you have been sur=
ely
> > > aware (and the whole world relies on), and I have decided that this s=
imple
> > > table-driven approximation is good enough to handle the usual baud ra=
tes,
> > > especially the higher ones.  For several baud rates it gives more acc=
urate
> > > results (lower deviation) than the factors proposed in the manufactur=
er's
> > > datasheets.
> >
> > And my point is to calculate is always based on the asked baud rate.
> > Yes. I understand what you wrote above and sometimes only brute force
> > can be used, but in the kernel we have integer arithmetics which helps
> > a lot besides the fact of bits twiddlings.
>
>  Well, the algorithm is for finding the closest rational number expressed
> by a numerator and a denominator to the required one.  We have no problem
> with that, because the divisor is integer (which is of course a rational
> number too, but finding the numerator where the denominator if constant 1
> is trivial).
>
> > >  I just fail to see how your proposed algorithm could be factored in =
here,
> > > but I'll be happy to be proved wrong, so I'll appreciate guidance.
> >
> > It's possible that it doesn't fit in the current form or for all three
> > integers. Just give some time and think about it. Maybe you can come
> > up with a better idea. I usually point to one case I have solved [1]
> > to show that ugly tables can be dropped (in some cases it makes sense
> > to leave them, though).
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/drivers/spi/spi-pxa2xx.c?id=3D9df461eca18f5395ee84670cdba6755dddec1=
898
>
>  Well, I considered a na=C3=AFve algorithm, but it would be quadratic, it=
 would
> make a lot of redundant calculations, and division is not exactly a fast
> operation; some targets we support have no hardware division instruction
> even.  Needless to say it would still have to encode the ranges supported=
.
> And any code size gain from the na=C3=AFve algorithm might still not matc=
h the
> 268 bytes the table consumes, especially with RISC targets.
>
>  I think my proposal is a reasonable compromise that addresses the proble=
m
> at hand, and if you or anyone else finds a better solution sometime, then
> you are free to improve it.  Perfect is the enemy of good enough, so the
> potential existence of an ultimate solution that hasn't been discovered
> yet shouldn't block progress in a hope that the solution gets found soon
> enough.

Fair enough.

>  I'll repost the outstanding pieces of the series with the adjustments I
> have agreed to make.

Thanks!

[2]: Hmm... It's funny how some things may easily disappear from the
internet. I'll look again tomorrow for the links. Okay, I have the
discussion locally available, I may forward you the entire thread.
[3]: https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/seri=
al_core.c#L986
[4]: https://lore.kernel.org/linux-serial/CAHhAz+hrmLiRJ77cM=3DCYj+iyH8aUJ6=
4R6FtAwGqqB2pOS0n0aQ@mail.gmail.com/T/#u
[5]: https://github.com/npat-efault/picocom/blob/master/termios2.txt


--
With Best Regards,
Andy Shevchenko
