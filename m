Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB9C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1218320776
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388805AbgEYUsh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 16:48:37 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34283 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbgEYUsh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 16:48:37 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB5162000D;
        Mon, 25 May 2020 20:48:29 +0000 (UTC)
Date:   Mon, 25 May 2020 13:48:27 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        heikki.krogerus@linux.intel.com, vigneshr@ti.com,
        lkml <linux-kernel@vger.kernel.org>, fido_max@inbox.ru,
        radu-andrei.bulie@nxp.com
Subject: Re: [PATCH] serial: 8250: probe all 16550A variants by default
Message-ID: <20200525204827.GC445190@localhost>
References: <20200525130238.3614179-1-olteanv@gmail.com>
 <20200525172815.GA445190@localhost>
 <CA+h21hqjcCpUuwZPONuP-qXn7pZv--avGVavQ_gT0n1guBNR_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hqjcCpUuwZPONuP-qXn7pZv--avGVavQ_gT0n1guBNR_Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 09:52:54PM +0300, Vladimir Oltean wrote:
> Hi Josh,
> 
> On Mon, 25 May 2020 at 20:28, Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > On Mon, May 25, 2020 at 04:02:38PM +0300, Vladimir Oltean wrote:
> > > On NXP T1040, the UART is typically detected as 16550A_FSL64. After said
> > > patch, it gets detected as plain 16550A and the Linux console is
> > > completely garbled and missing characters.
> >
> > Interesting that there's *new* powerpc hardware that needs these
> > variants. I based the patch on the fact that, on x86 at least, hardware
> > using these variants hasn't been made for a long time.
> >
> > In the hopes of preserving at least part of the benefit of the patch,
> > could you please change it to `default y if !X86_64`?
> >
> 
> Why don't you add CONFIG_SERIAL_8250_16550A_VARIANTS=n in x86_64_defconfig?

In general, it seems preferable to me when the defconfig files differ
less from the defaults encoded in Kconfig.

You're proposing a change to the default; could you please include one
or the other additional change in your patch to preserve the behavior on
x86_64?

> > >  drivers/tty/serial/8250/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> > > index af0688156dd0..89c7ecb55619 100644
> > > --- a/drivers/tty/serial/8250/Kconfig
> > > +++ b/drivers/tty/serial/8250/Kconfig
> > > @@ -63,6 +63,7 @@ config SERIAL_8250_PNP
> > >  config SERIAL_8250_16550A_VARIANTS
> > >       bool "Support for variants of the 16550A serial port"
> > >       depends on SERIAL_8250
> > > +     default y
> > >       help
> > >         The 8250 driver can probe for many variants of the venerable 16550A
> > >         serial port. Doing so takes additional time at boot.
> > > --
> > > 2.25.1
> > >
> 
> Thanks,
> -Vladimir
