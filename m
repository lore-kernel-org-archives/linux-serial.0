Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6871C352A3
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320B206ED
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0zzzlSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgBJPOo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:14:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40695 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJPOn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 10:14:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so5346953qto.7;
        Mon, 10 Feb 2020 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sEfE+Vg+QGs9dNdzDI7cFYNk7IQi+zT8aKliaK6oAA=;
        b=W0zzzlSKPizTOZA3AoLmgXs9P80alKlMSWILYdjLb2VujxB7IgjBvJnAbUaEkRpxxz
         r3Jtyw4W0ykU6hkVvF6j77H1yuwYhM/ek+3CYVtWvYOR3e/WHGHoCfTHzEAqrXH1s3nq
         EOq3dr6YesINrQ5SpV31YikeR9Pn6fLCjJrUv5Zyyv4PTFD7W5H6D2ToWrqdP9UHfd6j
         mmabWSsbUOQ9tGe1W0U9jWaT4tLxxUnvyIcfgNZY6Oq9IqQFa0BxNSZG8IG798AwxU6B
         jfFEEG7zz6A85IKQWrsDMUWWWKcm5HqlNQUMPlQELC+JttE+qxRm0k0sBLl9LzuJvAxf
         KzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sEfE+Vg+QGs9dNdzDI7cFYNk7IQi+zT8aKliaK6oAA=;
        b=CtRkc3IJmc84I54icPzB5lbQAi18uir8IjhOWXr5j4XBIHLlTBK2/QupxbkZpq/6kD
         gd9x8mz4X4XKv/MyEMjjNgPNOfkhnmRyI4pfYLgi8UX2sVMLqwHWw/XRJknjkh32n6m5
         wdtM+N6V5enQSdCPghWMOSOaoovFXaiH2MSIRX5Fo0aa68wzIys2WAW5zOggzNOUy4Mk
         GKe61bHDzO34e0Xqd6vwF897WlO9f0Ep2F3QNuEAAOMSmV/fyhOIp/Nl/kz9Qs1kQsqP
         H724VLvCEKsIrrjRS94GbFyzRVfQmEaTPsfcWz8x+TJbTZSgCpNR8MpvLMimAV3URiLv
         BlFw==
X-Gm-Message-State: APjAAAWautjClJu+2sj7aq5vjLIkBE5yQxsYh9KF1zsENpa0tLGuvNJE
        y3PArR5MclcyHUnZq8RN7Gs4dHjFdV16XUGqyvo=
X-Google-Smtp-Source: APXvYqwSUaRPH0ZzeOKVW3XJ6821qKmS7Zo6QHsDR/qDZHmMmRI86qM/YCEl5KNCx3eavnZ2Dh/RvPffO3gCPzBW/sw=
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr10426164qto.6.1581347682504;
 Mon, 10 Feb 2020 07:14:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578235515.git.gupt21@gmail.com> <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com> <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
 <20200110072051.GA124387@kroah.com>
In-Reply-To: <20200110072051.GA124387@kroah.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Mon, 10 Feb 2020 20:44:31 +0530
Message-ID: <CALUj-gvf5vcwdj=-8Sh9BjecKwGYFJciZ7caHxbzve3XNmE-xg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver emulating
 serial port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Tried dev_groups approach, doesn't fit here. Please see inline.

On Fri, Jan 10, 2020 at 12:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 09, 2020 at 02:59:59PM +0530, rishi gupta wrote:
> > > > +/* UART frame structure definitions */
> > > > +#define VS_CRTSCTS       0x0001
> > > > +#define VS_XON           0x0002
> > > > +#define VS_NONE          0X0004
> > > > +#define VS_DATA_5        0X0008
> > > > +#define VS_DATA_6        0X0010
> > > > +#define VS_DATA_7        0X0020
> > > > +#define VS_DATA_8        0X0040
> > >
> > > Why the "X"?
> > Sorry I did not understand, do you mean why VS_XON.
>
> No, I mean why the "0X0040" instead of "0x0040" like all other hex
> digits in your list of defines.
>
> > > > +static int vs_alloc_reg_one_dev(int oidx, int pidx, int rtsmap,
> > > > +                     int dtrmap, int dtropn)
> > > > +{
> > > > +     int ret;
> > > > +     struct vs_dev *vsdev;
> > > > +     struct device *dev;
> > > > +
> > > > +     /* Allocate and init virtual tty device private data */
> > > > +     vsdev = kcalloc(1, sizeof(struct vs_dev), GFP_KERNEL);
> > > > +     if (!vsdev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     vsdev->own_tty = NULL;
> > > > +     vsdev->peer_tty = NULL;
> > > > +     vsdev->own_index = oidx;
> > > > +     vsdev->peer_index =  pidx;
> > > > +     vsdev->rts_mappings = rtsmap;
> > > > +     vsdev->dtr_mappings = dtrmap;
> > > > +     vsdev->set_odtr_at_open = dtropn;
> > > > +     vsdev->msr_reg = 0;
> > > > +     vsdev->mcr_reg = 0;
> > > > +     vsdev->waiting_msr_chg = 0;
> > > > +     vsdev->tx_paused = 0;
> > > > +     vsdev->faulty_cable = 0;
> > > > +     mutex_init(&vsdev->lock);
> > > > +
> > > > +     /* Register with tty core with specific minor number */
> > > > +     dev = tty_register_device(ttyvs_driver, oidx, NULL);
> > > > +     if (!dev) {
> > > > +             ret = -ENOMEM;
> > > > +             goto fail;
> > > > +     }
> > > > +
> > > > +     vsdev->device = dev;
> > > > +     dev_set_drvdata(dev, vsdev);
> > > > +
> > > > +     /* Create custom sysfs files for this device for events */
> > > > +     ret = sysfs_create_group(&dev->kobj, &vs_info_attr_grp);
> > >
> > > Please no.  You just raced with userspace and lost (i.e. userspace has
> > > no idea these files are present.)
> > >
> > > Please use the correct apis for this, if you _REALLY_ want special sysfs
> > > files for a tty device.
> > Any specific API would you like to suggest. I am unable to progress on
> > how to address this one.
>
> Now that you have moved things to configfs, maybe you do not need the
> sysfs files anymore?
>
> Ah your "control" sysfs files, ok, you need to set the driver's
> dev_groups variable to point to your sysfs attributes, and then the
> driver core will properly set up these files.
>
> hope this helps,
>
> greg k-h

Everything done except using dev_groups approach (full driver after
all changes https://github.com/test209/t/blob/master/ttyvs.c#L1957).

Currently to emulate parity error (or any event), user writes to a
device specific node (0 is device number):
echo "2" > /sys/devices/virtual/tty/ttyvs0/event

With dev_groups, sysfs is created (1) for driver not for devices (2)
for platform devices only

Due to (1), parsing based approach will be needed, for ex (0 is device number);
echo "0-2" > /sys/devices/platform/ttyvs-card@0/event
or
echo "0-parity" > /sys/devices/platform/ttyvs-card@0/event

Due to (2), event file will not exist on desktop systems as there will
be no device tree node; no platform device.

Original problem was user space doesn't know when
"/sys/devices/virtual/tty/ttyvs0/event" will exist.
User space gets a uevent when a device is registered with tty core.
Application must access only after this.
Is this okay in case of this particular driver.

Only after open(/dev/ttyvs0) succeeds, application should access
"/sys/devices/virtual/tty/ttyvs0/event".

Regards,
Rishi
