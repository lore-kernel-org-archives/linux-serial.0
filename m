Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF37C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8076143E
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOROv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhFOROu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 13:14:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 559ECC061574;
        Tue, 15 Jun 2021 10:12:46 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0891C92009C; Tue, 15 Jun 2021 19:12:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 01F2592009B;
        Tue, 15 Jun 2021 19:12:44 +0200 (CEST)
Date:   Tue, 15 Jun 2021 19:12:44 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
In-Reply-To: <YMjMpQtLeP3xceYR@kroah.com>
Message-ID: <alpine.DEB.2.21.2106151805460.61948@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk> <YMiX7LAEtL0uQuVl@kroah.com> <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk> <YMjMpQtLeP3xceYR@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 15 Jun 2021, Greg Kroah-Hartman wrote:

> > > This patch series causes the following build warning to be added:
> > > 
> > > drivers/tty/serial/8250/8250_pci.c: In function ‘pci_oxsemi_tornado_setup’:
> > > drivers/tty/serial/8250/8250_pci.c:1258:32: warning: unsigned conversion from ‘int’ to ‘unsigned char’ changes value from ‘-129’ to ‘127’ [-Woverflow]
> > >  1258 |                 up->mcr_mask = ~UART_MCR_CLKSEL;
> > >       |                                ^
> > > 
> > > 
> > > Can you fix this up and resend?
> > 
> >  I've seen that, but that's not a problem with my change, but rather with 
> > <linux/serial_reg.h> making this macro (and the remaining ones from this 
> > group) expand to a signed constant (0x80 rather than 0x80u).
> 
> As your change causes it to show up, it must have something to do with
> it :)

 Of course it does, but the problem comes from the data type signedness 
difference between the `mcr_mask' member of `struct uart_8250_port', the 
type of which is (rightfully IMO) `unsigned char' (rather than `char' or 
`signed char') and the UART_MCR_CLKSEL macro, which expands to a signed 
int.  My change does not introduce this data type difference, hence it's 
not responsible for the problem, though it does expose it.

> >  I can fix the header, but that would be a separate change, and mind too 
> > that this is a user header, so it's not clear to me what the impact might 
> > be on user apps making use of it.
> 
> You can not change the uapi header, why would you want to?

 To make the data type of the constants it defines such that they can be 
assigned to program entities they are supposed to be used with without 
changing the sign at truncation time?

> >  We could use a GCC pragma to suppress the warning temporarily across this 
> > piece of code, but it's not clear to me either what our policy has been on 
> > such approach.
> 
> What pragma?

#pragma GCC diagnostic ignored "-Woverflow"

> >  Thoughts?
> 
> Why does your change cause this to show up?

 As I have noted above there is a data type signedness difference between 
`mcr_mask' and UART_MCR_CLKSEL.  So we have the value of 0x80 (128).  
Once bitwise-complemented it becomes 0xffffff7f (-129).  Once assigned to 
`mcr_mask' however it becomes 0x7f (127), which is considered an unsafe 
conversion between signed and unsigned integers by GCC, which is why the 
compiler complains about it.

 The same difference exists with say UART_MCR_OUT2 used in a similar
manner for ALPHA_KLUDGE_MCR, but GCC does not get noisy about it because 
the constant UART_MCR_OUT2 expands to is 0x08 and therefore the position 
of the bit set there does not coincide with the sign bit once truncated to 
8 bits, so the truncation does not cause a sign change.  The same warning 
would trigger however if the constant were left-shifted by 4 before the 
bitwise complement operation, so all these constants should be unsigned.  

 It does not make sense IMO to operate on signed values in the context of 
bit patterns for peripheral hardware registers.

 I'll find a way to paper it over if this is what is desired here, e.g. I 
guess this piece:

		up->mcr_mask = ~0;
		up->mcr_mask ^= UART_MCR_CLKSEL;

will do, although I find it obscurer than my original proposal, and surely 
asking for a comment (which I think is a sign of a problem).

  Maciej
