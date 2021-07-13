Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E4CC07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B769C61283
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 07:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhGMHWv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhGMHWu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 03:22:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49062C0613DD;
        Tue, 13 Jul 2021 00:20:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b12so18705628pfv.6;
        Tue, 13 Jul 2021 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k87ShhA7JYr3dDTpNdrndNWm72BoFK448tq+9qFOE+Q=;
        b=TvzSYuC2It9dB+C7aPwqlN5GqQ0x5DopQ8nVpXXSS48A6OZP1alOMA+zyG5IueQu6D
         0QcbsvwyG2LO5zReSQVHpHTqWcVYapchgm0ftbL2YleFSXZHwg3ucCzqD3U8l6YaQUZE
         58luLKi4ChFj/t4PJ/rxIFDTAfzf1uFXtNdiRgIpMyq7ZJ4+ZoPaq6GWMsBC7sKc7Z3W
         vYQNss9dacQ0puoQs0xSn8CKyKO47w9vmqOOG119LK2PVc/4pEMKBPuQDUyYffupG3PE
         xYeHAFsVZH4KJUu516JTiYjPzfCpYYq4u9gSfgjsNp5SPijEC+azrnrDC1Dg9yX7KdIU
         bZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k87ShhA7JYr3dDTpNdrndNWm72BoFK448tq+9qFOE+Q=;
        b=b2TIEm2UWSH94sD7vZmcsBFnlyTeedKMFrfFEVKXFsrJ+l/RtEii6F5mf92AGm6Qja
         yK0STpbKK69FY9uSbgb0qCMaAG0NViW5lsYRGd/QmYEfbDXkjjqEAQOQOmvYbugfa/os
         qrM8+RUDhRCbLHQK3Sl3To9vRa1s7fld45XvefngLTDO0YCRf+brmjgbeipudZ2IgzzN
         N4hVtkbhy8tl+ThibV+hGshYmegjJ8ManhXuHWt8qmaNMDABIl6NMC2id1XhXnFIL1xd
         WJ5IlaTmf0Vfu8TA/xDU/If9v9sQCUd1jfmQmi7+ZDmcBdcVOdWGTM4uOZGCXEylu+Nf
         njGQ==
X-Gm-Message-State: AOAM5331/RmLa65kWfu3J6UjYqza+SSRjFx92+0XMgHOgXyCWGaYhGDQ
        O+f6+UOibGOhCIKsvSiIv+SuNxbaxYcoCdSzdERAJQ0ON1yu8D/fXVE=
X-Google-Smtp-Source: ABdhPJwATcOwyw4C63A7maDbOoHQTY3NYjqzLaZ+EEUA3+JAKClQMLHxQuPsxsiNOWQ0+Tl1Gflpv4NsDetOwJHt/qY=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr3285711pfh.73.1626160800594; Tue, 13
 Jul 2021 00:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
 <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk> <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
 <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jul 2021 10:19:24 +0300
Message-ID: <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 13, 2021 at 4:52 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote=
:
>  Something wrong with your "From:" header; I've fixed it up based on a
> best guess basis.

Ah, yes, I have to fix it locally. Thanks!

> On Mon, 12 Jul 2021, andy@surfacebook.localdomain wrote:
>
> > >   Also handle the historic spd_cust feature so as to allow one to set
> > >   all the three parameters manually to arbitrary values, by keeping t=
he
> > >   low 16 bits for the divisor and then putting TCR in bits 19:16 and
> > >   CPR/CPR2 in bits 28:20, sanitising the bit pattern supplied such as
> > >   to clamp CPR/CPR2 values between 0.000 and 0.875 inclusive to 1.000=
.
> > >   This preserves compatibility with any existing setups, that is wher=
e
> > >   requesting a custom divisor that only has any bits set among the lo=
w
> > >   16 the oversampling rate of 16 and the clock prescaler of 1 will be
> > >   used.
> >
> > Please no. We really would like to get rid of that ugly hack. The BOTHE=
R exists
> > for ages.
>
>  I have actually carefully considered it before submission and:
>
> 1. it remains a supported user API with a tool included with contemporary
>    distributions, and

What supported API?

> 2. with this device you can't set all the possible whole-number baud
>    rates let alone UART clock frequencies with the BOTHER API, and

How does SPD_CUST make it different?

> 3. it doesn't hurt.

It hurts development a lot.

> If you'd like to get rid of SPD_CUST, then just do so, but until then I
> fail to see a point to have it supported with some devices but not other
> ones.

It _is_ the current state of affairs. Most of the contemporary drivers
do not support this "feature" at all.

>  NB if you do get to it, then please consider adding an equally flexible
> API too, e.g. for fractional baud rates (134.5bps haha); I won't mind if
> it's less hackish though.

Why do you need fractional baud rates for the small speeds? I do not
believe we have any good use case for that. And 1/2 from 134 is less
than 0.5% which is tolerable by UART by definition.

So, please no, drop it.

> > > References:
> > >
> > > [1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
> > >     Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65
> > >
> > > [2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
> > >     Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode=
",
> > >     p. 20
> > >
> > > [3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
> > >     Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20
> > >
> > > [4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
> > >     Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20
> >
> > Is it possible to reduce a commit message by shifting some stuff to the
> > dedicated documentation?
>
>  The relevant stuff has been included as comments along with actual code
> already, and the rest is the usual submission-time rationale.  This will
> be the initial source of information when someone studies the history of
> this code (`git log').

I do not object to this, but perhaps in the form of documentation it
would serve a better job (no-one will need to go deep into the Git
history for this, especially non-developer people who just got a
tarball, for example).

>  I don't consider it cast in stone however, so if there's any particular
> piece you'd like to see elsewhere, then please point out to me what to
> move and where.  Or give any guidance other than just: "Rewrite it!"

At least that table with divisors and deviation with accompanying
text. But I dare to say 90-95% of the commit message and leave
something like "Here is a new driver. documentation is there." To
where? Documentation/admin-guide seems most suitable right now
(looking at the presence of auxdisplay folder), however I think that
maybe dedicated folder like Documentation/hardware-notes maybe better.

+Cc: Mauro. What do you think about this? We need a folder where we
rather describe hardware features and maybe some driver implementation
details.

>  (Yes I often have troubles figuring out the real intent of some changes
> made say 15 years ago that have turned out broken after all those years
> and whose change description is simply too terse now that the lore has
> been lost.)
>
> > >  drivers/tty/serial/8250/8250_pci.c  |  331 +++++++++++++++++++++++++=
+++--------
> >
> > Can we, please, split the quirk driver first as it's done in a lot of e=
xamples
> > (_exar, _mid, _lpss, _...) and then modify it?
>
>  I have found it unclear where the line is drawn between having support
> code included with 8250_pci.c proper and having it split off to a separat=
e
> file.  All the device-specific files seem to provide complex handling,
> well beyond just calculating the clock.

Lines of code in the current 8250_pci in conjunction with expansion.
To me 331 (okay, it's something like 280?) LOC + sounds like a very
good justification to split.

>  I'll be happy to split it off however (with a suitable preparatory
> change) if there is a consensus in favour to doing so.

If you have a consensus with yourself :-) Maintaining 8250_pci is a burden.
You may look into the history of 8250_pci (and you will often see my
name there) how it was shrinking in time.

> > > +/*
> > > + * Determine the oversampling rate, the clock prescaler, and the clo=
ck
> > > + * divisor for the requested baud rate.  The clock rate is 62.5 MHz,
> > > + * which is four times the baud base, and the prescaler increments i=
n
> > > + * steps of 1/8.  Therefore to make calculations on integers we need
> > > + * to use a scaled clock rate, which is the baud base multiplied by =
32
> > > + * (or our assumed UART clock rate multiplied by 2).
> > > + *
> > > + * The allowed oversampling rates are from 4 up to 16 inclusive (val=
ues
> > > + * from 0 to 3 inclusive map to 16).  Likewise the clock prescaler a=
llows
> > > + * values between 1.000 and 63.875 inclusive (operation for values f=
rom
> > > + * 0.000 to 0.875 has not been specified).  The clock divisor is the=
 usual
> > > + * unsigned 16-bit integer.
> > > + *
> > > + * For the most accurate baud rate we use a table of predetermined
> > > + * oversampling rates and clock prescalers that records all possible
> > > + * products of the two parameters in the range from 4 up to 255 incl=
usive,
> > > + * and additionally 335 for the 1500000bps rate, with the prescaler =
scaled
> > > + * by 8.  The table is sorted by the decreasing value of the oversam=
pling
> > > + * rate and ties are resolved by sorting by the decreasing value of =
the
> > > + * product.  This way preference is given to higher oversampling rat=
es.
> > > + *
> > > + * We iterate over the table and choose the product of an oversampli=
ng
> > > + * rate and a clock prescaler that gives the lowest integer division
> > > + * result deviation, or if an exact integer divider is found we stop
> > > + * looking for right away.  We do some fixup if the resulting clock

for it right

> > > + * divisor required would be out of its unsigned 16-bit integer rang=
e.
> > > + *
> > > + * Finally we abuse the supposed fractional part returned to encode =
the
> > > + * 4-bit value of the oversampling rate and the 9-bit value of the c=
lock
> > > + * prescaler which will end up in the TCR and CPR/CPR2 registers.
> > > + */
> > > +static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port =
*port,
> > > +                                              unsigned int baud,
> > > +                                              unsigned int *frac)
> > > +{
> > > +   static u8 p[][2] =3D {
> > > +           { 16, 14, }, { 16, 13, }, { 16, 12, }, { 16, 11, },
> > > +           { 16, 10, }, { 16,  9, }, { 16,  8, }, { 15, 17, },
> > > +           { 15, 16, }, { 15, 15, }, { 15, 14, }, { 15, 13, },
> > > +           { 15, 12, }, { 15, 11, }, { 15, 10, }, { 15,  9, },
> > > +           { 15,  8, }, { 14, 18, }, { 14, 17, }, { 14, 14, },
> > > +           { 14, 13, }, { 14, 12, }, { 14, 11, }, { 14, 10, },
> > > +           { 14,  9, }, { 14,  8, }, { 13, 19, }, { 13, 18, },
> > > +           { 13, 17, }, { 13, 13, }, { 13, 12, }, { 13, 11, },
> > > +           { 13, 10, }, { 13,  9, }, { 13,  8, }, { 12, 19, },
> > > +           { 12, 18, }, { 12, 17, }, { 12, 11, }, { 12,  9, },
> > > +           { 12,  8, }, { 11, 23, }, { 11, 22, }, { 11, 21, },
> > > +           { 11, 20, }, { 11, 19, }, { 11, 18, }, { 11, 17, },
> > > +           { 11, 11, }, { 11, 10, }, { 11,  9, }, { 11,  8, },
> > > +           { 10, 25, }, { 10, 23, }, { 10, 20, }, { 10, 19, },
> > > +           { 10, 17, }, { 10, 10, }, { 10,  9, }, { 10,  8, },
> > > +           {  9, 27, }, {  9, 23, }, {  9, 21, }, {  9, 19, },
> > > +           {  9, 18, }, {  9, 17, }, {  9,  9, }, {  9,  8, },
> > > +           {  8, 31, }, {  8, 29, }, {  8, 23, }, {  8, 19, },
> > > +           {  8, 17, }, {  8,  8, }, {  7, 35, }, {  7, 31, },
> > > +           {  7, 29, }, {  7, 25, }, {  7, 23, }, {  7, 21, },
> > > +           {  7, 19, }, {  7, 17, }, {  7, 15, }, {  7, 14, },
> > > +           {  7, 13, }, {  7, 12, }, {  7, 11, }, {  7, 10, },
> > > +           {  7,  9, }, {  7,  8, }, {  6, 41, }, {  6, 37, },
> > > +           {  6, 31, }, {  6, 29, }, {  6, 23, }, {  6, 19, },
> > > +           {  6, 17, }, {  6, 13, }, {  6, 11, }, {  6, 10, },
> > > +           {  6,  9, }, {  6,  8, }, {  5, 67, }, {  5, 47, },
> > > +           {  5, 43, }, {  5, 41, }, {  5, 37, }, {  5, 31, },
> > > +           {  5, 29, }, {  5, 25, }, {  5, 23, }, {  5, 19, },
> > > +           {  5, 17, }, {  5, 15, }, {  5, 13, }, {  5, 11, },
> > > +           {  5, 10, }, {  5,  9, }, {  5,  8, }, {  4, 61, },
> > > +           {  4, 59, }, {  4, 53, }, {  4, 47, }, {  4, 43, },
> > > +           {  4, 41, }, {  4, 37, }, {  4, 31, }, {  4, 29, },
> > > +           {  4, 23, }, {  4, 19, }, {  4, 17, }, {  4, 13, },
> > > +           {  4,  9, }, {  4,  8, },
> > > +   };
> >
> > Oh l=C3=A0 l=C3=A0! Please, use rational best approximation algorithm i=
nstead
> > (check CONFIG_RATIONAL).
>
>  Thanks for the pointer, I didn't know we had this piece.
>
>  However how is it supposed to apply here?  The denominator is always 8,
> so we can rule it out (by multiplying the dividend by 8, which this piece
> does, so that the divisor is a whole number), but the numerator has to be
> a product of three integers, from a different range each ([4,16], [8,511]=
,
> [1, 65535]) as noted above.
>
>  Essentially we need to find such three integers (with extra constraints)
> the product of which is closest to (500000000 / baud_rate) -- which IMHO
> amounts to factorisation, an NP-complete problem as you have been surely
> aware (and the whole world relies on), and I have decided that this simpl=
e
> table-driven approximation is good enough to handle the usual baud rates,
> especially the higher ones.  For several baud rates it gives more accurat=
e
> results (lower deviation) than the factors proposed in the manufacturer's
> datasheets.

And my point is to calculate is always based on the asked baud rate.
Yes. I understand what you wrote above and sometimes only brute force
can be used, but in the kernel we have integer arithmetics which helps
a lot besides the fact of bits twiddlings.

>  I just fail to see how your proposed algorithm could be factored in here=
,
> but I'll be happy to be proved wrong, so I'll appreciate guidance.

It's possible that it doesn't fit in the current form or for all three
integers. Just give some time and think about it. Maybe you can come
up with a better idea. I usually point to one case I have solved [1]
to show that ugly tables can be dropped (in some cases it makes sense
to leave them, though).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/drivers/spi/spi-pxa2xx.c?id=3D9df461eca18f5395ee84670cdba6755dddec1898

>  In any case thank you for your review, always appreciated!

You/re welcome!

--=20
With Best Regards,
Andy Shevchenko
