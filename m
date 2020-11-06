Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BBEC2D0A3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3C2206DC
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604657985;
	bh=tDkttaGvq4p2pm0M3z0XFtWaNLQY4aze/4Q0YHc/69A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s0QyYduw9QNjn2W2JLqUHTOUJSjggRgt48+ACPpx8UQIZ4IDpeO93c0wNx4TOKZaV
	 6HtBv7RJLaWMS2W/HEWwhU20uGErRd2ZTVmzcrvga7rSuo6SxZ1ylxkaSVUKBIqGg7
	 zcofkYrm4kDGWzLu/oljZWkMv6SifjxOc3uxufVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKFKTp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 05:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgKFKTp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 05:19:45 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89932206CB;
        Fri,  6 Nov 2020 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604657984;
        bh=tDkttaGvq4p2pm0M3z0XFtWaNLQY4aze/4Q0YHc/69A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEvURo+8IuyC58vKy8DJD1ekV2kp6zDTh9qJotBhtlwb15LKrdKzZFHP+j5NmJid5
         hblNtKj6ac5VcJciEHdYlAgeFmMWUPkFMKoeup/SM4sy5Cd9pB1KSnH4qqiGefHxTp
         /cTnk5n26JA/3LzlglyynqDNR7NKV+FDu4cnbPe4=
Date:   Fri, 6 Nov 2020 11:20:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
Message-ID: <20201106102030.GA2780243@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com>
 <20201106100552.GA2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106100552.GA2063125@dell>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 06, 2020 at 10:05:52AM +0000, Lee Jones wrote:
> On Fri, 06 Nov 2020, Greg Kroah-Hartman wrote:
> 
> > On Wed, Nov 04, 2020 at 07:35:26PM +0000, Lee Jones wrote:
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
> > >  drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Cc: Mike Hudson <Exoray@isys.ca>
> > > Cc: linux-serial@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/tty/serial/8250/8250_port.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > And now I get build errors of:
> > 	ld: drivers/tty/serial/8250/8250_early.o: in function `early_au_setup':
> > 	8250_early.c:(.init.text+0x7): undefined reference to `au_serial_in'
> > 	ld: 8250_early.c:(.init.text+0xf): undefined reference to `au_serial_out'
> > 	make: *** [Makefile:1164: vmlinux] Error 1
> > 
> > Always test-build your patches, perhaps W=1 was wrong here...
> 
> I *always* test build my sets before posting.

Great, then I should have rephrased it as:
	Always test-build your patches and fix the error found in them
	before sending.

:)

