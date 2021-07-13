Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A7C07E9A
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8658960FDB
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 01:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhGMBzS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Jul 2021 21:55:18 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60594 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGMBzS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Jul 2021 21:55:18 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 10A0992009C; Tue, 13 Jul 2021 03:52:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0A8EF92009B;
        Tue, 13 Jul 2021 03:52:28 +0200 (CEST)
Date:   Tue, 13 Jul 2021 03:52:27 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
Message-ID: <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk> <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk> <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

 Something wrong with your "From:" header; I've fixed it up based on a 
best guess basis.

On Mon, 12 Jul 2021, andy@surfacebook.localdomain wrote:

> >   Also handle the historic spd_cust feature so as to allow one to set 
> >   all the three parameters manually to arbitrary values, by keeping the 
> >   low 16 bits for the divisor and then putting TCR in bits 19:16 and 
> >   CPR/CPR2 in bits 28:20, sanitising the bit pattern supplied such as
> >   to clamp CPR/CPR2 values between 0.000 and 0.875 inclusive to 1.000.
> >   This preserves compatibility with any existing setups, that is where 
> >   requesting a custom divisor that only has any bits set among the low 
> >   16 the oversampling rate of 16 and the clock prescaler of 1 will be 
> >   used.
> 
> Please no. We really would like to get rid of that ugly hack. The BOTHER exists
> for ages.

 I have actually carefully considered it before submission and:

1. it remains a supported user API with a tool included with contemporary 
   distributions, and

2. with this device you can't set all the possible whole-number baud 
   rates let alone UART clock frequencies with the BOTHER API, and

3. it doesn't hurt.

If you'd like to get rid of SPD_CUST, then just do so, but until then I 
fail to see a point to have it supported with some devices but not other 
ones.

 NB if you do get to it, then please consider adding an equally flexible 
API too, e.g. for fractional baud rates (134.5bps haha); I won't mind if 
it's less hackish though.

> > References:
> > 
> > [1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
> >     Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65
> > 
> > [2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
> >     Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode", 
> >     p. 20
> > 
> > [3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
> >     Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20
> > 
> > [4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
> >     Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20
> 
> Is it possible to reduce a commit message by shifting some stuff to the
> dedicated documentation?

 The relevant stuff has been included as comments along with actual code 
already, and the rest is the usual submission-time rationale.  This will 
be the initial source of information when someone studies the history of 
this code (`git log').

 I don't consider it cast in stone however, so if there's any particular 
piece you'd like to see elsewhere, then please point out to me what to 
move and where.  Or give any guidance other than just: "Rewrite it!"  

 (Yes I often have troubles figuring out the real intent of some changes 
made say 15 years ago that have turned out broken after all those years 
and whose change description is simply too terse now that the lore has 
been lost.)

> >  drivers/tty/serial/8250/8250_pci.c  |  331 ++++++++++++++++++++++++++++--------
> 
> Can we, please, split the quirk driver first as it's done in a lot of examples
> (_exar, _mid, _lpss, _...) and then modify it?

 I have found it unclear where the line is drawn between having support 
code included with 8250_pci.c proper and having it split off to a separate 
file.  All the device-specific files seem to provide complex handling, 
well beyond just calculating the clock.

 I'll be happy to split it off however (with a suitable preparatory 
change) if there is a consensus in favour to doing so.

> > +/*
> > + * Determine the oversampling rate, the clock prescaler, and the clock
> > + * divisor for the requested baud rate.  The clock rate is 62.5 MHz,
> > + * which is four times the baud base, and the prescaler increments in
> > + * steps of 1/8.  Therefore to make calculations on integers we need
> > + * to use a scaled clock rate, which is the baud base multiplied by 32
> > + * (or our assumed UART clock rate multiplied by 2).
> > + *
> > + * The allowed oversampling rates are from 4 up to 16 inclusive (values
> > + * from 0 to 3 inclusive map to 16).  Likewise the clock prescaler allows
> > + * values between 1.000 and 63.875 inclusive (operation for values from
> > + * 0.000 to 0.875 has not been specified).  The clock divisor is the usual
> > + * unsigned 16-bit integer.
> > + *
> > + * For the most accurate baud rate we use a table of predetermined
> > + * oversampling rates and clock prescalers that records all possible
> > + * products of the two parameters in the range from 4 up to 255 inclusive,
> > + * and additionally 335 for the 1500000bps rate, with the prescaler scaled
> > + * by 8.  The table is sorted by the decreasing value of the oversampling
> > + * rate and ties are resolved by sorting by the decreasing value of the
> > + * product.  This way preference is given to higher oversampling rates.
> > + *
> > + * We iterate over the table and choose the product of an oversampling
> > + * rate and a clock prescaler that gives the lowest integer division
> > + * result deviation, or if an exact integer divider is found we stop
> > + * looking for right away.  We do some fixup if the resulting clock
> > + * divisor required would be out of its unsigned 16-bit integer range.
> > + *
> > + * Finally we abuse the supposed fractional part returned to encode the
> > + * 4-bit value of the oversampling rate and the 9-bit value of the clock
> > + * prescaler which will end up in the TCR and CPR/CPR2 registers.
> > + */
> > +static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
> > +						   unsigned int baud,
> > +						   unsigned int *frac)
> > +{
> > +	static u8 p[][2] = {
> > +		{ 16, 14, }, { 16, 13, }, { 16, 12, }, { 16, 11, },
> > +		{ 16, 10, }, { 16,  9, }, { 16,  8, }, { 15, 17, },
> > +		{ 15, 16, }, { 15, 15, }, { 15, 14, }, { 15, 13, },
> > +		{ 15, 12, }, { 15, 11, }, { 15, 10, }, { 15,  9, },
> > +		{ 15,  8, }, { 14, 18, }, { 14, 17, }, { 14, 14, },
> > +		{ 14, 13, }, { 14, 12, }, { 14, 11, }, { 14, 10, },
> > +		{ 14,  9, }, { 14,  8, }, { 13, 19, }, { 13, 18, },
> > +		{ 13, 17, }, { 13, 13, }, { 13, 12, }, { 13, 11, },
> > +		{ 13, 10, }, { 13,  9, }, { 13,  8, }, { 12, 19, },
> > +		{ 12, 18, }, { 12, 17, }, { 12, 11, }, { 12,  9, },
> > +		{ 12,  8, }, { 11, 23, }, { 11, 22, }, { 11, 21, },
> > +		{ 11, 20, }, { 11, 19, }, { 11, 18, }, { 11, 17, },
> > +		{ 11, 11, }, { 11, 10, }, { 11,  9, }, { 11,  8, },
> > +		{ 10, 25, }, { 10, 23, }, { 10, 20, }, { 10, 19, },
> > +		{ 10, 17, }, { 10, 10, }, { 10,  9, }, { 10,  8, },
> > +		{  9, 27, }, {  9, 23, }, {  9, 21, }, {  9, 19, },
> > +		{  9, 18, }, {  9, 17, }, {  9,  9, }, {  9,  8, },
> > +		{  8, 31, }, {  8, 29, }, {  8, 23, }, {  8, 19, },
> > +		{  8, 17, }, {  8,  8, }, {  7, 35, }, {  7, 31, },
> > +		{  7, 29, }, {  7, 25, }, {  7, 23, }, {  7, 21, },
> > +		{  7, 19, }, {  7, 17, }, {  7, 15, }, {  7, 14, },
> > +		{  7, 13, }, {  7, 12, }, {  7, 11, }, {  7, 10, },
> > +		{  7,  9, }, {  7,  8, }, {  6, 41, }, {  6, 37, },
> > +		{  6, 31, }, {  6, 29, }, {  6, 23, }, {  6, 19, },
> > +		{  6, 17, }, {  6, 13, }, {  6, 11, }, {  6, 10, },
> > +		{  6,  9, }, {  6,  8, }, {  5, 67, }, {  5, 47, },
> > +		{  5, 43, }, {  5, 41, }, {  5, 37, }, {  5, 31, },
> > +		{  5, 29, }, {  5, 25, }, {  5, 23, }, {  5, 19, },
> > +		{  5, 17, }, {  5, 15, }, {  5, 13, }, {  5, 11, },
> > +		{  5, 10, }, {  5,  9, }, {  5,  8, }, {  4, 61, },
> > +		{  4, 59, }, {  4, 53, }, {  4, 47, }, {  4, 43, },
> > +		{  4, 41, }, {  4, 37, }, {  4, 31, }, {  4, 29, },
> > +		{  4, 23, }, {  4, 19, }, {  4, 17, }, {  4, 13, },
> > +		{  4,  9, }, {  4,  8, },
> > +	};
> 
> Oh là là! Please, use rational best approximation algorithm instead 
> (check CONFIG_RATIONAL).

 Thanks for the pointer, I didn't know we had this piece.

 However how is it supposed to apply here?  The denominator is always 8,
so we can rule it out (by multiplying the dividend by 8, which this piece 
does, so that the divisor is a whole number), but the numerator has to be 
a product of three integers, from a different range each ([4,16], [8,511], 
[1, 65535]) as noted above.

 Essentially we need to find such three integers (with extra constraints) 
the product of which is closest to (500000000 / baud_rate) -- which IMHO 
amounts to factorisation, an NP-complete problem as you have been surely 
aware (and the whole world relies on), and I have decided that this simple 
table-driven approximation is good enough to handle the usual baud rates, 
especially the higher ones.  For several baud rates it gives more accurate 
results (lower deviation) than the factors proposed in the manufacturer's 
datasheets.

 I just fail to see how your proposed algorithm could be factored in here, 
but I'll be happy to be proved wrong, so I'll appreciate guidance.

 In any case thank you for your review, always appreciated!

  Maciej
