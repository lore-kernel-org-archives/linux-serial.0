Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445CC33C99
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338820673
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H19G2bGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAJHih (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:38:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43722 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgAJHih (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 02:38:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so1005740qke.10;
        Thu, 09 Jan 2020 23:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frOmwgpbYCqHF+EYUPe13bnygy2tqNJcGXBXPNFxpL4=;
        b=H19G2bGbuiDimXZSWVXQfRFQhdPBnJ9jrafNYbpdI/2xS6HUtXFqgBm9U56PpTpq6x
         4PLlmNMHn8G9SgNwMvW627xgmR60VzCNdrhKNjrIdIgil/Hr5P95RBhiMKGAPkGsnu5E
         bM/YlUr4T/jifTdWudVpQiiclLrMh1HUL7tS4J2jbtTp3PVfzd2PJgfrH63w2rfZI2XO
         gbyOTAnWa82V7wcX8cr+nEpfpEfRF2q+9lOxx7ICRkrjs4yqetjyGMBlVJ+1o/oGccLa
         rImES/t2DgdekgdaJ18U043vYskSW3XJZlaiYe/RnK2g3Cxeuz0qhB6mlH0e+9+8fI+j
         tumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frOmwgpbYCqHF+EYUPe13bnygy2tqNJcGXBXPNFxpL4=;
        b=OO2PuC1DqgdiWo9+Oqb01sr3+EQj7EDYq5dlaauic0SJeCV/UFi1NZo5riJhvwMvIl
         dOLb10LnQdirdzyUFlxc4A83Za0hxCirfU/iI8E9HM+axLakIayHYU8udMkPnmFXZ/ut
         +2NJGBUDkG2kChyeY/id7GwJEA9Ohu6D8dD6LW5E4RmriC21/9FX+447osd/kCBAduyN
         BaPVs8CE1NpT2KRz/KgnKz16ngX2piS1oQhwhfZQj3ysb+Ov5kK1+AygTbsd0qW+vcVe
         1syjJHB774K8vt84mXbh+1Ewa+UTrI4WL2k+ltT7b8Fl0eVT1JIbmqlW5WcFBqkco5G4
         KXyQ==
X-Gm-Message-State: APjAAAWDKfBaLd586l8r8AucW+XMxX6FDPg8EIRGxorAp2Voh2rzUYNs
        NUi5vlp1ludmYrq8EqKeZtDBKSllyCxgXHB6CQE=
X-Google-Smtp-Source: APXvYqxXfahdH0VQLDgp0/VIH69zZ21fhMxDJg0BMmv28OiNiMaFwdgU50jaF5FZqrKNM8GYWfoPbgRZqD+BZHufRXo=
X-Received: by 2002:ae9:c316:: with SMTP id n22mr1821462qkg.72.1578641916111;
 Thu, 09 Jan 2020 23:38:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578235515.git.gupt21@gmail.com> <9fcb02fafd5fc9b31f3fe358b8e62b8a40ae132a.1578235515.git.gupt21@gmail.com>
 <20200106193500.GC754821@kroah.com> <CALUj-gsaecfZ9HN_JVAnvJijYCHK-A5qeztDLbDOSOAjTVfTeg@mail.gmail.com>
 <20200110072051.GA124387@kroah.com>
In-Reply-To: <20200110072051.GA124387@kroah.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 10 Jan 2020 13:08:25 +0530
Message-ID: <CALUj-gvroB_N34i-QkqT6Qn1ccvif+phN+Kszf-NO6v=Q8syqg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] tty/serial: ttvys: add null modem driver emulating
 serial port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

One problem (: about configfs. Desktop distros like Ubuntu doesn't
enable configFS by default in kernel config. So users will have to
build their own version of kernel. For my own purpose, as developer I
have control over this but for others building kernel suggested ?

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
Okay understood.
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
