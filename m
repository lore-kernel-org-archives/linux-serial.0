Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C3C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 05:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963EB23EB4
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 05:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbgLKFwI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 00:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388912AbgLKFvo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 00:51:44 -0500
Date:   Fri, 11 Dec 2020 06:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607665863;
        bh=cp6+pYtXaACthxB1XxfyhkIFCLqavljHyzRg1qjaSoY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kE5bqkU5UDmezhRr0m/f7HYr4Ms9XJCb/ILK3RBEq5hswZ7Uwh37F//LFY+ieEtw2
         hgEVJsMXdzWWC/azR1PRcJHuezRx5hJeqJOFSbJjEhfnh2bwfncQ/Mgws8cr1x9Kra
         lZ1LjpV45i3H1c2ESgp3wkibYqWxeCk0CwqudIrg=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <X9MIwqJBG69M5uHq@kroah.com>
References: <20201210170443.GA17304@dincontrollerdev>
 <X9Jw+srprdT8tquZ@kroah.com>
 <20201210194625.GA17516@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210194625.GA17516@dincontrollerdev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 07:46:25PM +0000, József Horváth wrote:
> On Thu, Dec 10, 2020 at 08:03:22PM +0100, 'Greg Kroah-Hartman' wrote:
> > On Thu, Dec 10, 2020 at 05:04:46PM +0000, József Horváth wrote:
> > > This is a serial port driver for
> > > Silicon Labs Si4455 Sub-GHz transciver.
> > > 
> > > Signed-off-by: József Horváth <info@ministro.hu>
> > > ---
> > >  .../bindings/serial/silabs,si4455.yaml        |   53 +
> > >  MAINTAINERS                                   |    7 +
> > >  drivers/tty/serial/Kconfig                    |    8 +
> > >  drivers/tty/serial/Makefile                   |    1 +
> > >  drivers/tty/serial/si4455.c                   | 1235 +++++++++++++++++
> > >  drivers/tty/serial/si4455_api.h               |   56 +
> > 
> > First thing, a single .c file should not need a .h file.
> > 
> > But then I looked at the .h file and see:
> > 
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/si4455_api.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0
> > > + *
> > > + * Copyright (C) 2020 József Horváth <info@ministro.hu>
> > > + *
> > > + */
> > > +#ifndef SI4455_API_H_
> > > +#define SI4455_API_H_
> > > +
> > > +struct si4455_iocbuff {
> > > +	uint32_t length;
> > > +	uint8_t	data[4096];
> > 
> > If you do have an ioctl, use proper data types.  These are not the
> > correct ones (hint, __u32 and __u8).
> > 
> > > +};
> > > +
> > > +#define BASE_TTYIOC_PRIVATE		0xA0
> > > +/* Set EZConfig.
> > > + * After this ioctl call, the driver restarts the si4455,
> > > + * then apply the new configuration and patch.
> > > + */
> > > +#define SI4455_IOC_SEZC		_IOW('T', \
> > > +				     BASE_TTYIOC_PRIVATE + 0x01, \
> > > +				     struct si4455_iocbuff)
> > 
> > Why does a serial driver have private ioctls?  Please no, don't do that.
> 
> I checked the ioctl.h and serial_core.h, but I not found any similar definition, like BASE_VIDIOC_PRIVATE in videodev2.h.
> In this case the name of macro BASE_TTYIOC_PRIVATE means the base value of special ioctl commands owned by this driver.

My point is, a serial driver should NOT have any custom ioctls.

> I can change it to BASE_TTYIOC or SI4455_IOC_BASE
> 
> > Implement the basic serial driver first, and then we can talk about
> > "custom" configurations and the like, using the correct apis.
> 
> Without the SI4455_IOC_SEZC call, the driver can't configure the Si4455 and not working at all.
> The cofiguration for interface is provided by user for application.

That is what a device tree is for, to configure the device to have the
correct system configuration, why can't that be the same here?

> It contains the base frequency, channel spacing, modulation, and a lot
> of more stuff, and generated by Silicon Labs Wireless Development
> Suite.
> The generated configuration is in a non public(compressed,
> encrypted...who knows) format, so without this the driver can't
> provide configuration parameters to Si4455.

So we have to take a "custom" userspace blob and send it to the device
to configure it properly?  Like Jiri said, sounds like firmware, so just
use that interface instead.

thanks,

greg k-h
