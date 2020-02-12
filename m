Return-Path: <SRS0=7071=4A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D4C352A4
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C602217F4
	for <linux-serial@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537741;
	bh=QYX8ibf0AXGLzT1RdbhTP1ma4R2d/2xVyVlPC4y383c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWUJuz8dpFEUOmEBiFj8WzLMdY5qcT9MO+O75O8gsK2h+T4/XKBqys+2b+Lri/C5t
	 YVjrymaJrNBT37cp+XqnT4gx/Faso1VKqh3Y6XhfECymgLmz7bvSId12g+ofXD1pAb
	 o0gVHji7qRSOxES4s2S98fY6KqeFHHqaWOPmTzSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgBLUCU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgBLUCU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Feb 2020 15:02:20 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1767D21739;
        Wed, 12 Feb 2020 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581537739;
        bh=QYX8ibf0AXGLzT1RdbhTP1ma4R2d/2xVyVlPC4y383c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWxrb4iuibmarQYTGtaqUYNe3ZMlM7tKFJcxezJeAOzf05ail3SIAt05bBcW68pN/
         asyqdMa2tCQ7PouXOrfLg6laRbbjD2HwMyuA9P/tXGoDeR+4cjN24NzvhVfKbR6Nly
         vxww9mum38HLVEyRt8RRoXJKIr6Pmtt4Efprr1/o=
Date:   Wed, 12 Feb 2020 12:02:18 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rishi gupta <gupt21@gmail.com>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver
 emulating serial port
Message-ID: <20200212200218.GA2081271@kroah.com>
References: <cover.1578235515.git.gupt21@gmail.com>
 <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com>
 <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
 <20200110072051.GA124387@kroah.com>
 <CALUj-gvf5vcwdj=-8Sh9BjecKwGYFJciZ7caHxbzve3XNmE-xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALUj-gvf5vcwdj=-8Sh9BjecKwGYFJciZ7caHxbzve3XNmE-xg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 10, 2020 at 08:44:31PM +0530, rishi gupta wrote:
> Tried dev_groups approach, doesn't fit here. Please see inline.
> 
> On Fri, Jan 10, 2020 at 12:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 09, 2020 at 02:59:59PM +0530, rishi gupta wrote:
> > > > > +/* UART frame structure definitions */
> > > > > +#define VS_CRTSCTS       0x0001
> > > > > +#define VS_XON           0x0002
> > > > > +#define VS_NONE          0X0004
> > > > > +#define VS_DATA_5        0X0008
> > > > > +#define VS_DATA_6        0X0010
> > > > > +#define VS_DATA_7        0X0020
> > > > > +#define VS_DATA_8        0X0040
> > > >
> > > > Why the "X"?
> > > Sorry I did not understand, do you mean why VS_XON.
> >
> > No, I mean why the "0X0040" instead of "0x0040" like all other hex
> > digits in your list of defines.
> >
> > > > > +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> > > > > +                     int dtrmap, int dtropn)
> > > > > +{
> > > > > +     int ret;
> > > > > +     struct vs_dev *vsdev;
> > > > > +     struct device *dev;
> > > > > +
> > > > > +     /* Allocate and init virtual tty device private data */
> > > > > +     vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
> > > > > +     if (!vsdev)
> > > > > +             return -ENOMEM;
> > > > > +
> > > > > +     vsdev->own_tty = NULL;
> > > > > +     vsdev->peer_tty = NULL;
> > > > > +     vsdev->own_index = oidx;
> > > > > +     vsdev->peer_index =  pidx;
> > > > > +     vsdev->rts_mappings = rtsmap;
> > > > > +     vsdev->dtr_mappings = dtrmap;
> > > > > +     vsdev->set_odtr_at_open = dtropn;
> > > > > +     vsdev->msr_reg = 0;
> > > > > +     vsdev->mcr_reg = 0;
> > > > > +     vsdev->waiting_msr_chg = 0;
> > > > > +     vsdev->tx_paused = 0;
> > > > > +     vsdev->faulty_cable = 0;
> > > > > +     mutex_init(&vsdev->lock);
> > > > > +
> > > > > +     /* Register with tty core with specific minor number */
> > > > > +     dev = tty_register_device(ttyvs_driver, oidx, NULL);
> > > > > +     if (!dev) {
> > > > > +             ret = -ENOMEM;
> > > > > +             goto fail;
> > > > > +     }
> > > > > +
> > > > > +     vsdev->device = dev;
> > > > > +     dev_set_drvdata(dev, vsdev);
> > > > > +
> > > > > +     /* Create custom sysfs files for this device for events */
> > > > > +     ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);
> > > >
> > > > Please no.  You just raced with userspace and lost (i.e. userspace has
> > > > no idea these files are present.)
> > > >
> > > > Please use the correct apis for this, if you _REALLY_ want special sysfs
> > > > files for a tty device.
> > > Any specific API would you like to suggest. I am unable to progress on
> > > how to address this one.
> >
> > Now that you have moved things to configfs, maybe you do not need the
> > sysfs files anymore?
> >
> > Ah your "control" sysfs files, ok, you need to set the driver's
> > dev_groups variable to point to your sysfs attributes, and then the
> > driver core will properly set up these files.
> >
> > hope this helps,
> >
> > greg k-h
> 
> Everything done except using dev_groups approach (full driver after
> all changes https://github.com/test209/t/blob/master/ttyvs.c#L1957).
> 
> Currently to emulate parity error (or any event), user writes to a
> device specific node (0 is device number):
> echo "2" > /sys/devices/virtual/tty/ttyvs0/event
> 
> With dev_groups, sysfs is created (1) for driver not for devices

Huh?  It's there for devices.

> (2) for platform devices only

No, should work for any device type, as the logic is in the driver core.

> Due to (1), parsing based approach will be needed, for ex (0 is device number);
> echo "0-2" > /sys/devices/platform/ttyvs-card@0/event
> or
> echo "0-parity" > /sys/devices/platform/ttyvs-card@0/event

No, the 0- should not be needed, it should be a device-specific file.

> Due to (2), event file will not exist on desktop systems as there will
> be no device tree node; no platform device.

I don't understand, this file belongs in the tty device that you have
created, not in any other device.

> Original problem was user space doesn't know when
> "/sys/devices/virtual/tty/ttyvs0/event" will exist.

And if you set the devices group up properly, the sysfs file will be
created when the device is created.

> User space gets a uevent when a device is registered with tty core.
> Application must access only after this.

Yes, but you will race in creation of your file with userspace unless
you tell the core to do this properly.

> Is this okay in case of this particular driver.

No.

thanks,

greg k-h
