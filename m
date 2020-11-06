Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB0C2D0A3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260BA208B3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604660107;
	bh=QnE6iYi6SBACRLAhXwJ7UvNyy/AH9kWjqGjMj6Ag7rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=etqgh2Ja12rw/wNO6tNUNeYn+uMAA31RjL9nXsVzyuxWsP68AUtVVpPEvxwdjGP1/
	 4EqL9SC3+DO0pF0iZi2zG3c3Hs1BMtCAl+5bEh/h42YVgvYVX4gFUrOAdgpwJT/FmJ
	 2ifcOSYin6W1PPKT2ZSXkLbQbyjz+KXiojvCJyh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgKFKzG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgKFKzG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 05:55:06 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6247F20724;
        Fri,  6 Nov 2020 10:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604660106;
        bh=QnE6iYi6SBACRLAhXwJ7UvNyy/AH9kWjqGjMj6Ag7rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5NYO7BM9dZfoBPO+FfWsUjvSJlI50GRPoTEiH8W1NMEc5r1EVjTlIzYb5tKMNIsN
         ucpz2dT/rry3EPQ9MgRF5n5ar+7qELPIr9EGvDpB1480FFM7Y5Qr/oJKH4bQ9H/vvP
         0Cw8PqYFU3VKANFN1Khe590F5SbUmSEyu2TzBiEA=
Date:   Fri, 6 Nov 2020 11:55:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106105552.GA2810950@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell>
 <20201106103955.GA2784089@kroah.com>
 <20201106104810.GE2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106104810.GE2063125@dell>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 06, 2020 at 10:48:10AM +0000, Lee Jones wrote:
> On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> 
> > On Fri, Nov 06, 2020 at 10:16:46AM +0000, Lee Jones wrote:
> > > On Fri, 06 Nov 2020, Lee Jones wrote:
> > > 
> > > > On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > > > > Fixes the following W=1 kernel build warning(s):
> > > > > > 
> > > > > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > > > > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > > > > 
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > > Cc: Mike Hudson <Exoray@isys.ca>
> > > > > > Cc: linux-serial@vger.kernel.org
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > And now I get build errors of:
> > > > > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > > > > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > > > > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > > > > 	make: *** [Makefile:1164: vmlinux] Error 1
> > > > > 
> > > > 
> > > > I *always* test build my sets before posting.
> > > > 
> > > > /investigating
> > > 
> > > What config failed for you?
> > > 
> > > It looks as though SERIAL_8250_CONSOLE is a bool and doesn't appear to
> > > be compiled with allmodconfig builds for any architecture that I test
> > > against (Arm, Arm64, MIPS, PPC, x86).
> > 
> > I build on x86, and here's what I have set:
> > 
> > CONFIG_SERIAL_EARLYCON=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > CONFIG_SERIAL_8250_PNP=y
> > CONFIG_SERIAL_8250_16550A_VARIANTS=y
> > CONFIG_SERIAL_8250_FINTEK=y
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_DMA=y
> > CONFIG_SERIAL_8250_PCI=y
> > CONFIG_SERIAL_8250_EXAR=y
> > CONFIG_SERIAL_8250_NR_UARTS=16
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=8
> > CONFIG_SERIAL_8250_EXTENDED=y
> > # CONFIG_SERIAL_8250_MANY_PORTS is not set
> > # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > # CONFIG_SERIAL_8250_RSA is not set
> > CONFIG_SERIAL_8250_DWLIB=y
> > CONFIG_SERIAL_8250_DW=m
> > CONFIG_SERIAL_8250_RT288X=y
> > CONFIG_SERIAL_8250_UNIPHIER=m
> > CONFIG_SERIAL_8250_LPSS=y
> > CONFIG_SERIAL_8250_MID=y
> > CONFIG_SERIAL_8250_TEGRA=m
> 
> Is that from the default defconfig?  Or something bespoke?

No idea, bespoke I guess, it's grown over the years as what I use for
testing the tty.git tree.  Odd that I have some 8250 options turned off,
no idea why that is...

greg k-h
