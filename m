Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB4C07E99
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE06127C
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhGLUSF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:18:05 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:43133 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235392AbhGLUSF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Jul 2021 16:18:05 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id ddcb796d-e34d-11eb-ba24-005056bd6ce9;
        Mon, 12 Jul 2021 23:15:14 +0300 (EEST)
Date:   Mon, 12 Jul 2021 23:15:13 +0300
From:   andy@surfacebook.localdomain
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for
 OxSemi PCIe devices
Message-ID: <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
 <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Sat, Jun 26, 2021 at 06:11:32AM +0200, Maciej W. Rozycki kirjoitti:
> Oxford Semiconductor PCIe (Tornado) serial port devices are driven by a
> fixed 62.5MHz clock input derived from the 100MHz PCI Express clock.
> 
> We currently drive the device using its default oversampling rate of 16 
> and the clock prescaler disabled, consequently yielding the baud base of 
> 3906250.  This base is inadequate for some of the high-speed baud rates 
> such as 460800bps, for which the closest rate possible can be obtained 
> by dividing the baud base by 8, yielding the baud rate of 488281.25bps, 
> which is off by 5.9638%.  This is enough for data communication to break 
> with the remote end talking actual 460800bps where missed stop bits have 
> been observed.
> 
> We can do better however, by taking advantage of a reduced oversampling 
> rate, which can be set to any integer value from 4 to 16 inclusive by 
> programming the TCR register, and by using the clock prescaler, which 
> can be set to any value from 1 to 63.875 in increments of 0.125 in the 
> CPR/CPR2 register pair[1][2][3][4].  The prescaler has to be explicitly 
> enabled though by setting bit 7 in the MCR or otherwise it is bypassed 
> as if the value of 1 was used.
> 
> By using these parameters rates from 15625000bps down to 1bps can be 
> obtained, with either exact or highly-accurate actual bit rates for 
> standard and many non-standard rates.
> 
> Make use of these features then as follows:
> 
> - Set the baud base to 15625000, reflecting the minimum oversampling 
>   rate of 4 with the clock prescaler and divisor both set to 1.
> 
> - Set the MCR mask and force bits in the UART template so as to have 
>   MCR[7] always set and then have 8250 core propagate those settings, if 
>   supplied as non-zero, overriding the ALPHA_KLUDGE_MCR default.
> 
> - Override the `get_divisor' handler and determine a good combination of
>   parameters by using a lookup table with predetermined value pairs of 
>   the oversampling rate and the clock prescaler and finding a pair that 
>   divides the input clock such that the quotient, when rounded to the 
>   nearest integer, deviates the least from the exact result.  Calculate 
>   the clock divisor accordingly.
> 
>   Scale the resulting oversampling rate (only by powers of two) if 
>   possible so as to maximise it, reducing the divisor accordingly, and 
>   avoid a divisor overflow for very low baud rates by scaling the 
>   oversampling rate and/or the prescaler even if that causes some 
>   accuracy loss.

>   Also handle the historic spd_cust feature so as to allow one to set 
>   all the three parameters manually to arbitrary values, by keeping the 
>   low 16 bits for the divisor and then putting TCR in bits 19:16 and 
>   CPR/CPR2 in bits 28:20, sanitising the bit pattern supplied such as
>   to clamp CPR/CPR2 values between 0.000 and 0.875 inclusive to 1.000.
>   This preserves compatibility with any existing setups, that is where 
>   requesting a custom divisor that only has any bits set among the low 
>   16 the oversampling rate of 16 and the clock prescaler of 1 will be 
>   used.

Please no. We really would like to get rid of that ugly hack. The BOTHER exists
for ages.

>   Finally abuse the `frac' argument to store the determined bit patterns 
>   for the TCR, CPR and CPR2 registers.
> 
> - Override the `set_divisor' handler so as to set the TCR, CPR and CPR2 
>   registers from the `frac' value supplied.  Set the divisor as usually.
> 
> With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX 
> limitation imposed by `serial8250_get_baud_rate' standard baud rates 
> below 300bps become unavailable in the regular way, e.g. the rate of 
> 200bps requires the baud base to be divided by 78125 and that is beyond 
> the unsigned 16-bit range.  The historic spd_cust feature can still be 
> used to obtain such rates if so required.
> 
> Here are the figures for the standard and some non-standard baud rates 
> (including those quoted in Oxford Semiconductor documentation), giving 
> the requested rate (r), the actual rate yielded (a) and its deviation 
> from the requested rate (d), and the values of the oversampling rate 
> (tcr), the clock prescaler (cpr) and the divisor (div) produced by the 
> new `get_divisor' handler:
> 
> r: 15625000, a: 15625000.00, d:  0.0000%, tcr:  4, cpr:  1.000, div:     1
> r: 12500000, a: 12500000.00, d:  0.0000%, tcr:  5, cpr:  1.000, div:     1
> r: 10416666, a: 10416666.67, d:  0.0000%, tcr:  6, cpr:  1.000, div:     1
> r:  8928571, a:  8928571.43, d:  0.0000%, tcr:  7, cpr:  1.000, div:     1
> r:  7812500, a:  7812500.00, d:  0.0000%, tcr:  8, cpr:  1.000, div:     1
> r:  4000000, a:  4000000.00, d:  0.0000%, tcr:  5, cpr:  3.125, div:     1
> r:  3686400, a:  3676470.59, d: -0.2694%, tcr:  8, cpr:  2.125, div:     1
> r:  3500000, a:  3496503.50, d: -0.0999%, tcr: 13, cpr:  1.375, div:     1
> r:  3000000, a:  2976190.48, d: -0.7937%, tcr: 14, cpr:  1.500, div:     1
> r:  2500000, a:  2500000.00, d:  0.0000%, tcr: 10, cpr:  2.500, div:     1
> r:  2000000, a:  2000000.00, d:  0.0000%, tcr: 10, cpr:  3.125, div:     1
> r:  1843200, a:  1838235.29, d: -0.2694%, tcr: 16, cpr:  2.125, div:     1
> r:  1500000, a:  1492537.31, d: -0.4975%, tcr:  5, cpr:  8.375, div:     1
> r:  1152000, a:  1152073.73, d:  0.0064%, tcr: 14, cpr:  3.875, div:     1
> r:   921600, a:   919117.65, d: -0.2694%, tcr: 16, cpr:  2.125, div:     2
> r:   576000, a:   576036.87, d:  0.0064%, tcr: 14, cpr:  3.875, div:     2
> r:   460800, a:   460829.49, d:  0.0064%, tcr:  7, cpr:  3.875, div:     5
> r:   230400, a:   230414.75, d:  0.0064%, tcr: 14, cpr:  3.875, div:     5
> r:   115200, a:   115207.37, d:  0.0064%, tcr: 14, cpr:  1.250, div:    31
> r:    57600, a:    57603.69, d:  0.0064%, tcr:  8, cpr:  3.875, div:    35
> r:    38400, a:    38402.46, d:  0.0064%, tcr: 14, cpr:  3.875, div:    30
> r:    19200, a:    19201.23, d:  0.0064%, tcr:  8, cpr:  3.875, div:   105
> r:     9600, a:     9600.06, d:  0.0006%, tcr:  9, cpr:  1.125, div:   643
> r:     4800, a:     4799.98, d: -0.0004%, tcr:  7, cpr:  2.875, div:   647
> r:     2400, a:     2400.02, d:  0.0008%, tcr:  9, cpr:  2.250, div:  1286
> r:     1200, a:     1200.00, d:  0.0000%, tcr: 14, cpr:  2.875, div:  1294
> r:      300, a:      300.00, d:  0.0000%, tcr: 11, cpr:  2.625, div:  7215
> r:      200, a:      200.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 15625
> r:      150, a:      150.00, d:  0.0000%, tcr: 13, cpr:  2.250, div: 14245
> r:      134, a:      134.00, d:  0.0000%, tcr: 11, cpr:  2.625, div: 16153
> r:      110, a:      110.00, d:  0.0000%, tcr: 12, cpr:  1.000, div: 47348
> r:       75, a:       75.00, d:  0.0000%, tcr:  4, cpr:  5.875, div: 35461
> r:       50, a:       50.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 62500
> r:       25, a:       25.00, d:  0.0000%, tcr: 16, cpr:  2.500, div: 62500
> r:        4, a:        4.00, d:  0.0000%, tcr: 16, cpr: 20.000, div: 48828
> r:        2, a:        2.00, d:  0.0000%, tcr: 16, cpr: 40.000, div: 48828
> r:        1, a:        1.00, d:  0.0000%, tcr: 16, cpr: 63.875, div: 61154
> 
> References:
> 
> [1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
>     Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65
> 
> [2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
>     Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode", 
>     p. 20
> 
> [3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
>     Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20
> 
> [4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
>     Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20

Is it possible to reduce a commit message by shifting some stuff to the
dedicated documentation?

...

>  drivers/tty/serial/8250/8250_pci.c  |  331 ++++++++++++++++++++++++++++--------

Can we, please, split the quirk driver first as it's done in a lot of examples
(_exar, _mid, _lpss, _...) and then modify it?

...

> +/* Tornado-specific constants for the TCR and CPR registers; see below.  */
> +#define OXSEMI_TORNADO_TCR_MASK	0xf
> +#define OXSEMI_TORNADO_CPR_MASK	0x1ff
> +#define OXSEMI_TORNADO_CPR_MIN	8
> +
> +/*
> + * Determine the oversampling rate, the clock prescaler, and the clock
> + * divisor for the requested baud rate.  The clock rate is 62.5 MHz,
> + * which is four times the baud base, and the prescaler increments in
> + * steps of 1/8.  Therefore to make calculations on integers we need
> + * to use a scaled clock rate, which is the baud base multiplied by 32
> + * (or our assumed UART clock rate multiplied by 2).
> + *
> + * The allowed oversampling rates are from 4 up to 16 inclusive (values
> + * from 0 to 3 inclusive map to 16).  Likewise the clock prescaler allows
> + * values between 1.000 and 63.875 inclusive (operation for values from
> + * 0.000 to 0.875 has not been specified).  The clock divisor is the usual
> + * unsigned 16-bit integer.
> + *
> + * For the most accurate baud rate we use a table of predetermined
> + * oversampling rates and clock prescalers that records all possible
> + * products of the two parameters in the range from 4 up to 255 inclusive,
> + * and additionally 335 for the 1500000bps rate, with the prescaler scaled
> + * by 8.  The table is sorted by the decreasing value of the oversampling
> + * rate and ties are resolved by sorting by the decreasing value of the
> + * product.  This way preference is given to higher oversampling rates.
> + *
> + * We iterate over the table and choose the product of an oversampling
> + * rate and a clock prescaler that gives the lowest integer division
> + * result deviation, or if an exact integer divider is found we stop
> + * looking for right away.  We do some fixup if the resulting clock
> + * divisor required would be out of its unsigned 16-bit integer range.
> + *
> + * Finally we abuse the supposed fractional part returned to encode the
> + * 4-bit value of the oversampling rate and the 9-bit value of the clock
> + * prescaler which will end up in the TCR and CPR/CPR2 registers.
> + */
> +static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
> +						   unsigned int baud,
> +						   unsigned int *frac)
> +{
> +	static u8 p[][2] = {
> +		{ 16, 14, }, { 16, 13, }, { 16, 12, }, { 16, 11, },
> +		{ 16, 10, }, { 16,  9, }, { 16,  8, }, { 15, 17, },
> +		{ 15, 16, }, { 15, 15, }, { 15, 14, }, { 15, 13, },
> +		{ 15, 12, }, { 15, 11, }, { 15, 10, }, { 15,  9, },
> +		{ 15,  8, }, { 14, 18, }, { 14, 17, }, { 14, 14, },
> +		{ 14, 13, }, { 14, 12, }, { 14, 11, }, { 14, 10, },
> +		{ 14,  9, }, { 14,  8, }, { 13, 19, }, { 13, 18, },
> +		{ 13, 17, }, { 13, 13, }, { 13, 12, }, { 13, 11, },
> +		{ 13, 10, }, { 13,  9, }, { 13,  8, }, { 12, 19, },
> +		{ 12, 18, }, { 12, 17, }, { 12, 11, }, { 12,  9, },
> +		{ 12,  8, }, { 11, 23, }, { 11, 22, }, { 11, 21, },
> +		{ 11, 20, }, { 11, 19, }, { 11, 18, }, { 11, 17, },
> +		{ 11, 11, }, { 11, 10, }, { 11,  9, }, { 11,  8, },
> +		{ 10, 25, }, { 10, 23, }, { 10, 20, }, { 10, 19, },
> +		{ 10, 17, }, { 10, 10, }, { 10,  9, }, { 10,  8, },
> +		{  9, 27, }, {  9, 23, }, {  9, 21, }, {  9, 19, },
> +		{  9, 18, }, {  9, 17, }, {  9,  9, }, {  9,  8, },
> +		{  8, 31, }, {  8, 29, }, {  8, 23, }, {  8, 19, },
> +		{  8, 17, }, {  8,  8, }, {  7, 35, }, {  7, 31, },
> +		{  7, 29, }, {  7, 25, }, {  7, 23, }, {  7, 21, },
> +		{  7, 19, }, {  7, 17, }, {  7, 15, }, {  7, 14, },
> +		{  7, 13, }, {  7, 12, }, {  7, 11, }, {  7, 10, },
> +		{  7,  9, }, {  7,  8, }, {  6, 41, }, {  6, 37, },
> +		{  6, 31, }, {  6, 29, }, {  6, 23, }, {  6, 19, },
> +		{  6, 17, }, {  6, 13, }, {  6, 11, }, {  6, 10, },
> +		{  6,  9, }, {  6,  8, }, {  5, 67, }, {  5, 47, },
> +		{  5, 43, }, {  5, 41, }, {  5, 37, }, {  5, 31, },
> +		{  5, 29, }, {  5, 25, }, {  5, 23, }, {  5, 19, },
> +		{  5, 17, }, {  5, 15, }, {  5, 13, }, {  5, 11, },
> +		{  5, 10, }, {  5,  9, }, {  5,  8, }, {  4, 61, },
> +		{  4, 59, }, {  4, 53, }, {  4, 47, }, {  4, 43, },
> +		{  4, 41, }, {  4, 37, }, {  4, 31, }, {  4, 29, },
> +		{  4, 23, }, {  4, 19, }, {  4, 17, }, {  4, 13, },
> +		{  4,  9, }, {  4,  8, },
> +	};

Oh là là! Please, use rational best approximation algorithm instead (check CONFIG_RATIONAL).


-- 
With Best Regards,
Andy Shevchenko


