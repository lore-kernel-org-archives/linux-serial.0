Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3DECAAD8
	for <linux-serial@archiver.kernel.org>; Fri, 16 Sep 2022 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIPVDd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIPVDc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Sep 2022 17:03:32 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 878D814D0D
        for <linux-serial@vger.kernel.org>; Fri, 16 Sep 2022 14:03:30 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2F3A392009C; Fri, 16 Sep 2022 23:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 28ABF92009B;
        Fri, 16 Sep 2022 22:03:28 +0100 (BST)
Date:   Fri, 16 Sep 2022 22:03:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Anders Blomdell <anders.blomdell@control.lth.se>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
In-Reply-To: <12a346f8-afc9-e832-1b91-80e458819df8@control.lth.se>
Message-ID: <alpine.DEB.2.21.2209152056430.39056@angie.orcam.me.uk>
References: <YyB4AtFJx++PeA6S@kroah.com> <7a99a59e-838d-c9da-6ead-167398642c07@control.lth.se> <YyCNOV9no9NPwv8m@kroah.com> <e9ca9267-dfee-c7b0-f1ec-4d2b76a05991@control.lth.se> <alpine.DEB.2.21.2209131638550.60554@angie.orcam.me.uk>
 <3f2d2863-96dd-05d2-4d88-55666fe37bf8@control.lth.se> <alpine.DEB.2.21.2209132254150.60554@angie.orcam.me.uk> <5921dfd6-384e-b663-f0f7-8471b9e88c29@control.lth.se> <alpine.DEB.2.21.2209141224370.60554@angie.orcam.me.uk> <alpine.DEB.2.21.2209141456460.60554@angie.orcam.me.uk>
 <YyHr6wD8F8KxyK5m@kroah.com> <12a346f8-afc9-e832-1b91-80e458819df8@control.lth.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 15 Sep 2022, Anders Blomdell wrote:

> > > 1. Disable new OxSemi Tornado clock code iff !SERIAL_8250_16550A_VARIANTS,
> > >     bringing back buggy calculation for rates above 115200bps and coarse
> > >     BOTHER granularity.
> > > 
> > > 2. Same as above, but additionally limit the baud rates to 115200bps to
> > >     avoid buggy rates.
> > 
> > Maybe this one?  That feels odd that we do different things for this old
> > config option, that's not good.  So making this "just work" should be
> > the best idea if at all possible.

 Though quite an invasive one too IMO to deal with a corner case, plus 
distributions would likely get it wrong, just as this case indicates, and 
would ship a crippled (though at least working) driver.

> > > 3. Force SERIAL_8250_16550A_VARIANTS to "y" if SERIAL_8250_PCI != "n".
> > > 
> > > 4. Remove SERIAL_8250_16550A_VARIANTS altogether and execute code it
> > >     guards unconditionally (does it still matter nowadays?).
> > > 
> > > 5. Something else not yet determined.
> We could force an EFR probe for this specific driver only.

 Having investigated the history of SERIAL_8250_16550A_VARIANTS and the 
possible options I came to a similar conclusion.  I wasn't aware the 
option has about only just been introduced and must have confused it with 
one of the older ones such as SERIAL_8250_EXTENDED, which has been there 
since forever.

> Pros: driver behaves the same regardless of CONFIG_SERIAL_8250_16550A_VARIANTS
>       other chips/drivers will not get probed
> Cons: autoconfig code will be somewhat bigger since code after the test will
> be reachable
>       change in unrelated part (8250_core.c) to propagate .probe flags

 But SERIAL_8250_16550A_VARIANTS is quite a recent addition and the 
motivation wasn't code size, so I wouldn't be concerned here.

 Another pro is the change is small and sweet, so no large chunks of code 
to maintain.  And it is expandable easily to other subdrivers should they 
need a similar arrangement.

> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index ff84a3ed10ea..0855316468e2 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -112,6 +112,7 @@ struct uart_8250_port {
>  	unsigned char		probe;
>  	struct mctrl_gpios	*gpios;
>  #define UART_PROBE_RSA	(1 << 0)
> +#define UART_PROBE_EFR	(1 << 1)
>   	/*
>  	 * Some bits in registers are cleared on a read, so they must

 I chose to do it differently though.  And I got stumped, because when I 
got to verifying it I decided to double-check my code with a 32-bit system 
too, that is my x86 box.  And surprisingly existing code worked correctly 
despite having SERIAL_8250_16550A_VARIANTS unset as if the fix wasn't 
needed in the first place.

 After a lot of fiddling I realised there is a feature of the OxSemi ASIC 
that is not documented in the datasheet, the existence of which however 
you can read about between the lines:

"Extending CPR for Legacy UART

"When operating in Legacy UART mode, the system drivers will assume the 
industry standard 1.8432MHz reference clock.  As the Reference clock for 
the UARTs in the OXPCIe952 is 62.5MHz, all DLL/DLM values will be 
incorrect if no pre-scaling is done by the UART.  In order to correct this 
effect the CPR register must divide the reference clock by 33.90842 which 
is approximated to 33.875 by default after a reset.  As such the CPR has 
been extended to support a larger 6 bit integer range by using bit-0 of 
CPR2 to represent bit-6 of the integer portion of the clock pre-scalar"

What it doesn't say is that in the legacy UART mode the Divide-by-M N/8 
prescaler is implicitly enabled despite that the MCR[7] bit is forced 0 in 
the non-enhanced mode.  This is opposite to how things work in the native 
UART mode where the MCR[7] bit is respected regardless.  It is only when 
the enhanced mode is enabled via EFR[4] that the MCR[7] bit is respected 
both in the legacy and the native UART mode.

 It makes sense, because legacy 8250 UART drivers will expect to work with 
`base_baud' set to 115200 while using the MCR the way it has been with the 
original 16450 chip.  Conversely legacy 16450 UART drivers do not support 
the native UART mode anyway, so it doesn't have to implement this special 
case.

 And I have the option card jumpered to work in the legacy UART mode in my 
x86 system (just so that I can verify both modes of operation at any 
time):

0000:04:00.0: ttyS2 at I/O 0x1000 (irq = 10, base_baud = 15625000) is a 16C950/954
0000:04:00.1: ttyS3 at I/O 0x1008 (irq = 5, base_baud = 15625000) is a 16C950/954

04:00.0 Serial controller [0700]: Oxford Semiconductor Ltd OXPCIe952 Legacy 950 UART #1 [1415:c144]
04:00.1 Serial controller [0700]: Oxford Semiconductor Ltd OXPCIe952 Legacy 950 UART #2 [1415:c145]

vs the native UART mode (here in POWER9):

0001:01:00.0: ttyS0 at MMIO 0x600c080401000 (irq = 40, base_baud = 15625000) is a 16C950/954
0001:01:00.0: ttyS1 at MMIO 0x600c080401200 (irq = 40, base_baud = 15625000) is a 16C950/954

0001:01:00.0 Serial controller [0700]: Oxford Semiconductor Ltd OXPCIe952 Dual Native 950 UART [1415:c158]

Oh well!

 With that phenomenon sorted I'll be posting the final fix shortly, as 
soon I have made a suitable change description referring the relevant 
sources.

 I take it you don't mind being mentioned by means of `Reported-by'?

  Maciej
