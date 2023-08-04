Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E1C001DB
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjHDNMA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHDNL7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 09:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263113D;
        Fri,  4 Aug 2023 06:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A1461FF0;
        Fri,  4 Aug 2023 13:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF9C433C8;
        Fri,  4 Aug 2023 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691154717;
        bh=7ntSjVcQX5yc3v5S/7QHHgddXCoFWoTHt7GXxZqj6wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbNoHb1mCWqj3F6iDudOMFKB9x+CjtGWZEzrFTVLoAxmqRVucs5+JGg3Ehs+CfnSc
         GMb7ll2gtErf0oow77tzwbs2XVcAF1x7vXAGaIPrhsGUw2JGnSf2o7DsYXl5K/amni
         VV9CTFWEIIdI2b5ylY8Y5g5B9lkU06jagRqfFziM=
Date:   Fri, 4 Aug 2023 15:11:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] serial: core: Fix kmemleak issue for serial core device
 remove
Message-ID: <2023080443-squealing-henchman-0e8b@gregkh>
References: <20230804090909.51529-1-tony@atomide.com>
 <959278d8-d76e-fda8-6d0d-64e284c0ba1b@kernel.org>
 <20230804092105.GI14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804092105.GI14799@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 04, 2023 at 12:21:05PM +0300, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [230804 09:16]:
> > On 04. 08. 23, 11:09, Tony Lindgren wrote:
> > > Kmemleak reports issues for serial8250 ports after the hardware specific
> > > driver takes over on boot as noted by Tomi.
> > > 
> > > The kerneldoc for device_initialize() says we must call device_put()
> > > after calling device_initialize(). We are calling device_put() on the
> > > error path, but are missing it from the device remove path. This causes
> > > release() to never get called for the devices on remove.
> > > 
> > > Let's add the missing put_device() calls for both serial ctrl and
> > > port devices.
> > > 
> > > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >   drivers/tty/serial/serial_base_bus.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> > > --- a/drivers/tty/serial/serial_base_bus.c
> > > +++ b/drivers/tty/serial/serial_base_bus.c
> > > @@ -99,6 +99,7 @@ void serial_base_ctrl_device_remove(struct serial_ctrl_device *ctrl_dev)
> > >   		return;
> > >   	device_del(&ctrl_dev->dev);
> > > +	put_device(&ctrl_dev->dev);
> > >   }
> > >   struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
> > > @@ -174,6 +175,7 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
> > >   		return;
> > >   	device_del(&port_dev->dev);
> > > +	put_device(&port_dev->dev);
> > 
> > I didn't check the code, but device_unregister()?
> 
> I thought about that as it does the same, but since we're not calling
> device_register() I felt it would be and unpaired call. No objections to
> changing to use device_unregister() naturally if folks prefer that.

This is fine as device_register() isn't happening, thanks.

greg k-h
