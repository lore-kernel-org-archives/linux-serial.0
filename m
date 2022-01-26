Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F9C2BA4C
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiAZL7D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241021AbiAZL7D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 06:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643198342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAFRX3Ll2EWOOf5SvwlveLi2EAh9zYL/C14r8isbSmc=;
        b=BHvH8kPWVLoPjT7mpaF9cTQbmLuReOJr5XeJcl9DSfiVfHUR2qUiaAh8f7XPSx9wu1dMzz
        BXjSDLrlERbCPRear7K5msxbWUPQ5S168hKMtuWxtDUW+uK4OoiSVPW/ncBwG9RJceQe8Z
        pqa7HuCzfJ2aBBt8HtZU5T/rMk5KlJU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-E1pMWjzAMYON58P6GYfPHQ-1; Wed, 26 Jan 2022 06:59:00 -0500
X-MC-Unique: E1pMWjzAMYON58P6GYfPHQ-1
Received: by mail-ed1-f70.google.com with SMTP id w3-20020a50c443000000b0040696821132so9539125edf.22
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 03:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAFRX3Ll2EWOOf5SvwlveLi2EAh9zYL/C14r8isbSmc=;
        b=AgbkQA6ohMfNlrm7vpgX/jdIvbG98tMK+VrLfg9p2LU4vAZHuWVq/zsmYAzGE/G7Ip
         9xFt0qM/McZKo/G1+heciq3DQ9GFDTNHreFJQ7rw123kwsz3tEX9/UR+jeVB4CObWIOa
         bkj6BFbvaX7IX1iaRhkc78EhWmUJ127hpnCxnE7DmP7+kA2Bj+m0SbqwEx0L1mLdwzmi
         jyoD8OU5CKQFP6rpzvNfp8ZBSompkHrVoOnvMgk/ACWjjV6P92q5sPTXZnFm+SIK12sY
         v211XzxrnSxrSFQhQVkepAO3wHLrrurN8FS9QbNg1jXReCTMlivKzmVSSKpzdW1AXgBi
         +rfg==
X-Gm-Message-State: AOAM530r41RCC8MccQwRFeYfRVuj68/QqKfF7lwHna9+h41WG0Ea3pCg
        LwE7i+AywgXiYCAVOS1R2hfnFDE21EhkamgcG+IeZVfvpVcGeskssx8HhyuA7c8LumXe0yVpFc5
        i/MXxXB4auv5Ne5wRzcL37E+kjAkk78HbiDhAN44W
X-Received: by 2002:a17:907:7e93:: with SMTP id qb19mr4331403ejc.450.1643198338369;
        Wed, 26 Jan 2022 03:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUwyus9ZvysDcJHkMldzv4YPOHEEDKqqFKeSQezb1vPN+VSGYQ1CMkL5Ztv3mFaQJGPzX8zrEDu9o0U2rOMJI=
X-Received: by 2002:a17:907:7e93:: with SMTP id qb19mr4331391ejc.450.1643198338173;
 Wed, 26 Jan 2022 03:58:58 -0800 (PST)
MIME-Version: 1.0
References: <202201170006.31440.pisa@cmp.felk.cvut.cz> <YeVpFozoVQo1vbKS@kroah.com>
 <202201191446.28415.pisa@cmp.felk.cvut.cz> <YfEMkHvDb6KJjh3h@kroah.com>
In-Reply-To: <YfEMkHvDb6KJjh3h@kroah.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 26 Jan 2022 08:58:47 -0300
Message-ID: <CAAq0SUneu6mgKjCSEa1pE--6WOFqXJb_d6zodtOGWnbor9-LVw@mail.gmail.com>
Subject: Re: TTY layer discussion about generic FIFO depth and Rx iddle
 timeout control
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Wander Lairson Costa <wander@redhat.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 26, 2022 at 5:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 19, 2022 at 02:46:28PM +0100, Pavel Pisa wrote:
> > Dear Greg,
> >
> > thanks for the reply.
> >
> > On Monday 17 of January 2022 14:03:18 Greg Kroah-Hartman wrote:
> > > On Mon, Jan 17, 2022 at 12:06:31AM +0100, Pavel Pisa wrote:
> > > >   https://github.com/lin-bus
> > > >
> > > > Kernel part - slLIN TTY discipline - can be found there
> > > >
> > > >   https://github.com/lin-bus/linux-lin/tree/master/sllin
> > >
> > > So it's just a 2000 line kernel module?  That should be easy to turn
> > > into a patch and submit for review, right?
> > >
> > > Odds are it can be made much smaller based on an initial glance at it.
> > > Review comments can help show what to do.
> >
> > Thanks for encouragement for mainlining or at least review on the list.
> > I agree that it can shrink when patch for mainline without sections
> > providing compatibility with old kernels is prepared.
> > Generally, I think that it is doable and important is feedback
> > from the user base that there is interrest... and time...
> >
> > I think that resolution of APO for the trigger/FIFO control
> > is critical for thinking about mainlining. Rest is the usual
> > work...
> >
> > > >   https://github.com/lin-bus/linux-lin/issues/13
> > > >
> > > Discuss it here by submitting patches please.  Links to random github
> > > repos do not do much as we can do nothing with them, sorry.
> >
> > Yes, I understand but I would like to hear some suggestion
> > the first where/into which object operations structure
> > should be the function added.
> >
> > There is required functionality in 8250 driver linux/drivers/tty/serial/8250/8250_port.c
> >
> >      do_set_rxtrig(struct tty_port *port, unsigned char bytes)
> >      do_serial8250_set_rxtrig(...)
> >      serial8250_set_attr_rx_trig_bytes(...)
> >      DEVICE_ATTR_RW(rx_trig_bytes)
> >
> > But to make slLIN generally usable, we would need to have functionality
> > reachable from the line discipline
> >
> > Do you agree that right place is struct uart_ops?
> >
> >   https://elixir.bootlin.com/linux/latest/source/include/linux/serial_core.h#L38
> >
> > What should be a prototype?
>
> For all of these questions, I do not know.  Try it out yourself first
> and see what you feel works best.  We will be glad to review working
> patches, but to discuss options before that is difficult and not
> something we normally worry about.
>

That gives me some time to find more machines to test the fixes.

> thanks,
>
> greg k-h
>

