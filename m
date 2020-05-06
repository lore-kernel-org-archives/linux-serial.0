Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F2C4724C
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC23206E6
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEFGOU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbgEFGOT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 02:14:19 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 23:14:19 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A415C061A0F
        for <linux-serial@vger.kernel.org>; Tue,  5 May 2020 23:14:19 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DF70A100A5F0F;
        Wed,  6 May 2020 08:06:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 47A655A483; Wed,  6 May 2020 08:06:23 +0200 (CEST)
Date:   Wed, 6 May 2020 08:06:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] serial: 8250: Avoid error message on reprobe
Message-ID: <20200506060623.sf3kh3fwhoawawsd@wunner.de>
References: <cover.1588505407.git.lukas@wunner.de>
 <b3fbbe8688d5e9d173168ae45295719ca4c9d35f.1588505407.git.lukas@wunner.de>
 <20200505160101.GV185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505160101.GV185537@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 05, 2020 at 07:01:01PM +0300, Andy Shevchenko wrote:
> On Tue, May 05, 2020 at 04:42:01PM +0200, Lukas Wunner wrote:
> > If the call to uart_add_one_port() in serial8250_register_8250_port()
> > fails, a half-initialized entry in the serial_8250ports[] array is left
> > behind.
> > 
> > A subsequent reprobe of the same serial port causes that entry to be
> > reused.  Because uart->port.dev is set, uart_remove_one_port() is called
> > for the half-initialized entry and bails out with an error message:
> > 
> > bcm2835-aux-uart 3f215040.serial: Removing wrong port: (null) != (ptrval)
> > 
> > The same happens on failure of mctrl_gpio_init() since commit
> > 4a96895f74c9 ("tty/serial/8250: use mctrl_gpio helpers").
> > 
> > Fix by zeroing the uart->port.dev pointer in the probe error path.
> >  
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v2.6.10+
> 
> Fixes tag?

The bug was introduced in the pre-git era, so I can't provide a Fixes tag:

https://git.kernel.org/tglx/history/c/befff6f5bf5f

This commit, which went into v2.6.10, added an unconditional
uart_remove_one_port() in serial8250_register_port().

In 2012, commit 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
made the call to uart_remove_one_port() conditional on uart->port.dev
being non-NULL and that allows me to fix the issue by setting that
pointer to NULL in the error path.  The commit went into v3.7, so it
should be possible to fix the problem going back to v3.7 with my patch.
And before that one needs to additionally make the call to
uart_remove_one_port() conditional.

However, according to www.kernel.org the oldest LTS kernel is v3.16.
So I've given you the nitty-gritty details but it's all fairly
irrelevant and the Cc: stable tag I've put into the commit seems the
best I can do in this case.

As for your other comment:

> >  			ret = uart_add_one_port(&serial8250_reg,
> >  						&uart->port);
> > -			if (ret == 0)
> > +			if (ret)
> > +				goto err;
> 
> > +			else
> 
> Redundant.
> 
> >  				ret = uart->port.line;

Sure, I can change that.

Thanks!

Lukas
