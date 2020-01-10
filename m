Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B93C33C99
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171FF2082E
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578640855;
	bh=w+dk7wSpEQK4o75h7tvK6qJiWTaDhrGxQZa5wmfsJqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjzzGVtTEgyyPWsJ7C96zmUyz0d0dS1HYNLuo+Nnk59DXe+OkClAOEb93S1oGeboX
	 j/mXos/I7K7rDJYmKKlKyMsvLMSdTZ5V7jsN2TzluFjo5jiRyA5lAyK1c1VfSeHSYf
	 7xxyI4fL+mbeZEzAfvOEUckhfDy+SnpLy3qDHciE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAJHUy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgAJHUy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 02:20:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FD52080D;
        Fri, 10 Jan 2020 07:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578640853;
        bh=w+dk7wSpEQK4o75h7tvK6qJiWTaDhrGxQZa5wmfsJqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyiO5Gkk+vOXMenZrdGwNETa59cH/wdH7h2FxA75bkVmgU6DfvH7axbASrMRVKGn8
         quIHIQ4JqzIUvVrToq2e902iZuyCGo5fymJiEXBQUrwnUgjgSVlyRDowTO2TcokqZm
         iij2E3JBWDWveMVzUI1Wcm0TRdwH6gfiWCs4i4B4=
Date:   Fri, 10 Jan 2020 08:20:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rishi gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver
 emulating serial port
Message-ID: <20200110072051.GA124387@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
 <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com>
 <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 09, 2020 at 02:59:59PM +0530, rishi gupta wrote:
> > > +/* UART frame structure definitions */
> > > +#define VS_CRTSCTS       0x0001
> > > +#define VS_XON           0x0002
> > > +#define VS_NONE          0X0004
> > > +#define VS_DATA_5        0X0008
> > > +#define VS_DATA_6        0X0010
> > > +#define VS_DATA_7        0X0020
> > > +#define VS_DATA_8        0X0040
> >
> > Why the "X"?
> Sorry I did not understand, do you mean why VS_XON.

No, I mean why the "0X0040" instead of "0x0040" like all other hex
digits in your list of defines.

> > > +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> > > +                     int dtrmap, int dtropn)
> > > +{
> > > +     int ret;
> > > +     struct vs_dev *vsdev;
> > > +     struct device *dev;
> > > +
> > > +     /* Allocate and init virtual tty device private data */
> > > +     vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
> > > +     if (!vsdev)
> > > +             return -ENOMEM;
> > > +
> > > +     vsdev->own_tty = NULL;
> > > +     vsdev->peer_tty = NULL;
> > > +     vsdev->own_index = oidx;
> > > +     vsdev->peer_index =  pidx;
> > > +     vsdev->rts_mappings = rtsmap;
> > > +     vsdev->dtr_mappings = dtrmap;
> > > +     vsdev->set_odtr_at_open = dtropn;
> > > +     vsdev->msr_reg = 0;
> > > +     vsdev->mcr_reg = 0;
> > > +     vsdev->waiting_msr_chg = 0;
> > > +     vsdev->tx_paused = 0;
> > > +     vsdev->faulty_cable = 0;
> > > +     mutex_init(&vsdev->lock);
> > > +
> > > +     /* Register with tty core with specific minor number */
> > > +     dev = tty_register_device(ttyvs_driver, oidx, NULL);
> > > +     if (!dev) {
> > > +             ret = -ENOMEM;
> > > +             goto fail;
> > > +     }
> > > +
> > > +     vsdev->device = dev;
> > > +     dev_set_drvdata(dev, vsdev);
> > > +
> > > +     /* Create custom sysfs files for this device for events */
> > > +     ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);
> >
> > Please no.  You just raced with userspace and lost (i.e. userspace has
> > no idea these files are present.)
> >
> > Please use the correct apis for this, if you _REALLY_ want special sysfs
> > files for a tty device.
> Any specific API would you like to suggest. I am unable to progress on
> how to address this one.

Now that you have moved things to configfs, maybe you do not need the
sysfs files anymore?

Ah your "control" sysfs files, ok, you need to set the driver's
dev_groups variable to point to your sysfs attributes, and then the
driver core will properly set up these files.

hope this helps,

greg k-h
