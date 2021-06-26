Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F2BC49EA5
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C99461920
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 04:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhFZEPt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Jun 2021 00:15:49 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60094 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhFZEPs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Jun 2021 00:15:48 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4C46892009C; Sat, 26 Jun 2021 06:13:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4546392009B;
        Sat, 26 Jun 2021 06:13:26 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:13:26 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
In-Reply-To: <aff02581e694421eba04afc2fc3644df@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2106260055211.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk> <YMiX7LAEtL0uQuVl@kroah.com> <alpine.DEB.2.21.2106151602120.61948@angie.orcam.me.uk> <YMjMpQtLeP3xceYR@kroah.com> <alpine.DEB.2.21.2106151805460.61948@angie.orcam.me.uk>
 <aff02581e694421eba04afc2fc3644df@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 15 Jun 2021, David Laight wrote:

> >  As I have noted above there is a data type signedness difference between
> > `mcr_mask' and UART_MCR_CLKSEL.  So we have the value of 0x80 (128).
> > Once bitwise-complemented it becomes 0xffffff7f (-129).  Once assigned to
> > `mcr_mask' however it becomes 0x7f (127), which is considered an unsafe
> > conversion between signed and unsigned integers by GCC, which is why the
> > compiler complains about it.
> 
> Blame the iso C standards committee for making integer promotions
> 'value preserving' instead of 'sign preserving' as they were in K&R C.
> 
> Try using ^ 0xffu instead of ~.

 Hmm, this is probably the least horrible way to paper it over, thanks.  
Even using a temporary variable (let alone a cast) does not help as GCC 
sees through it, and I've given up on converting <linux/serial_reg.h> to 
have e.g.:

#define UART_MCR_CLKSEL		_UL(0x80) /* Divide clock by 4 (TI16C752, EFR[4]=1) */

as I find that too messy with many of the comments wrapping up.  And using 
a GCC pragma would require a messy compiler version check.

 I have posted an update with a path-of-least-resistance fix then along 
with the 4/4 as v2 of this series.

  Maciej
