Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D5C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB762078B
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590421272;
	bh=y9FrvEPeJMlNFOBsq2Y7qf26EWNnhqKP+Jyd/0uPsTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mn2MaA0clYuDk+UDdYvCYBeLy0iMtZzPi7MeF3zepDGE+dLbEwK+18eYjUGQKVMro
	 SYpcDRCdk8eEotBqQ6Tp+5L1ritWcTcxGnQxGNnjiu675Mt0eufXg6uzzry9sKi8rS
	 pZ2t3dpNCiAByQ/3h9Spba4KOL6e6/rNKAlWmp4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404076AbgEYPlL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 11:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404002AbgEYPlL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 11:41:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8BC32071C;
        Mon, 25 May 2020 15:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590421269;
        bh=y9FrvEPeJMlNFOBsq2Y7qf26EWNnhqKP+Jyd/0uPsTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUGojtfS+wkBGxc++ZPavF7QEEYlyiRfapn8Z/d4uzkQcyHMfWkm88BXT6V+BFO6Y
         cPCBhhFR4dFjNEy7OMCvpLdl4bcIj1E6sfEsNP0GHtieIpL1d8DxTgFg7rMc+9HuXo
         d1V+DTCEyoG22dpQBvUt53biN7qMUk0ab2W4XCzo=
Date:   Mon, 25 May 2020 17:41:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1] serial: imx: Initialize lock for non-registered
 console
Message-ID: <20200525154107.GA1016976@kroah.com>
References: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
 <c5b1caca-32fc-1482-b4f5-71787b73a814@roeck-us.net>
 <20200525140752.GA910887@kroah.com>
 <20200525153418.GE1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525153418.GE1634618@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 25, 2020 at 06:34:18PM +0300, Andy Shevchenko wrote:
> On Mon, May 25, 2020 at 04:07:52PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 25, 2020 at 07:01:13AM -0700, Guenter Roeck wrote:
> > > On 5/25/20 3:59 AM, Andy Shevchenko wrote:
> > > > The commit a3cb39d258ef
> > > > ("serial: core: Allow detach and attach serial device for console")
> > > > changed a bit logic behind lock initialization since for most of the console
> > > > driver it's supposed to have lock already initialized even if console is not
> > > > enabled. However, it's not the case for Freescale IMX console.
> > > > 
> > > > Initialize lock explicitly in the ->probe().
> > > > 
> > > > Note, there is still an open question should or shouldn't not this driver
> > > > register console properly.
> > > > 
> > > > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > I really wonder if this is the correct fix, especially since it looks like
> > > there are several other drivers which don't call register_console() either
> > > but implement a console device.
> > > 
> > > Guenter
> > > 
> > > > ---
> > > >  drivers/tty/serial/imx.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index 986d902fb7fe..6b078e395931 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -2404,6 +2404,9 @@ static int imx_uart_probe(struct platform_device *pdev)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	/* We need to initialize lock even for non-registered console */
> > > > +	spin_lock_init(&sport->port.lock);
> > 
> > Why are we having to do this for all console drivers recently?
> > Shouldn't the original patch that required this gone through and fixed
> > up all drivers?
> > 
> > I'm with Guenter here, let's fix them all at once please.
> 
> Okay. Do you want series per driver or one for all?

one per driver is always easier to apply :)

thanks,

greg k-h
