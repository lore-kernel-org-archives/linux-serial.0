Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E52C433DF
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D520725
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594449040;
	bh=acSdpfnvbGb2jx7WzFGXvtApWSJ1zwvQTWvxV4ZbgjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xvpLkHZw83EuQcwZsQRdoUWt8kTRV0uxlePcIkNPkNeWVglcNVQn9uOcFVP7YMxL8
	 6DZesyf3axE7CjMuTI+As7iIwNMu9bZWxv/vuOAPL0ujfxkyVQl8sA96TAef5A28Mg
	 +veHzmk+NgRt4WN1tVLcyHX0q/dCA/bTONu7wPxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGKGaj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGKGaj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 02:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47393206F4;
        Sat, 11 Jul 2020 06:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594449038;
        bh=acSdpfnvbGb2jx7WzFGXvtApWSJ1zwvQTWvxV4ZbgjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glLyWxGbTSKecu6XfJKxx2aYmv+Wd9NhB+w34QIKn2RDUm3GV2wOzMmAZWWDheO+6
         F2dHJyKL97QejJB6zx6p6asf4EPtQ5JHIi2vkDYXwVfg51R2zuC1PInJsAN4KwfKN9
         yyr3UG0dI3UG0C2wLVmYSGWdTbmTnGxjPiUbcMc8=
Date:   Sat, 11 Jul 2020 08:30:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] tty: serial: owl: Initialize lock before registering
 port
Message-ID: <20200711063041.GC2784728@kroah.com>
References: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
 <20200529113419.GA1631227@kroah.com>
 <20200710120549.GA11293@BV030612LT>
 <20200710133542.GA2172832@kroah.com>
 <20200710155806.GA10457@BV030612LT>
 <20200710163022.GT3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710163022.GT3703480@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 10, 2020 at 07:30:22PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 10, 2020 at 06:58:06PM +0300, Cristian Ciocaltea wrote:
> > On Fri, Jul 10, 2020 at 03:35:42PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 10, 2020 at 03:05:49PM +0300, Cristian Ciocaltea wrote:
> 
> ...
> 
> > > But I think we now have a core fix for this, no need to do this in any
> > > individual driver, right?  Can you test my tty-linus branch to see if
> > > your change is still needed or not?
> > 
> > I was not aware of the alternative approach, at that time Andy
> > confirmed the expected behaviour is to have a proper initialization
> > of the spinlock in the driver:
> > https://lore.kernel.org/lkml/CAHp75Vcz0a87LSnb6Ubt5_bSF3wUcs21GbP119trXER5KBDxbQ@mail.gmail.com/
> > https://lore.kernel.org/lkml/CAHp75Vf8xJ2yX-11JsTDnRvZQOK+16aePcB1AUzq=5oO-mFCGQ@mail.gmail.com/
> > 
> > I have just checked the tty-linus tree and the only related change
> > seems to be f743061a85f5
> > ("serial: core: Initialise spin lock before use in uart_configure_port()")
> > 
> > I tested it on top of 5.8.0-rc4 and I confirm it fixes the splat,
> 
> Thank you for the testing!
> 
> > however I'm a bit confused now regarding the recommended approach since
> > there is at least one more commit in the tty-linux tree that still 
> > handles a similar issue in the driver specific code:
> > f38278e9b810 ("serial: sh-sci: Initialize spinlock for uart console")
> 
> They now should be reverted.

Please send patches for that :)

thanks,

greg k-h
