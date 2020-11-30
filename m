Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7BC64E7B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 21:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D422076A
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 21:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6LKW3gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgK3VWt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgK3VWt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 16:22:49 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C8C0613D2;
        Mon, 30 Nov 2020 13:22:09 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id k17so7120458vsp.13;
        Mon, 30 Nov 2020 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BA9WuBIxyQk+4n/puy9O59CDd70ZfBaz5viH95nnWs4=;
        b=t6LKW3glQoMpja4iCdfaIijiPAdNwa0Ew+dwHC/qtp3GENalFciab3yQxZdXL/hMXz
         VzYUMTzhYdIFFUygNk2tt6TNge/hwXCuD6CfokGXQajUiFlyiBxsleFXaJY6xxLb5Kgr
         fK2CEl2kdb4hjX1iUjWsxFH7m5HxkSDLgqZtSUCq0LEbUou92kmNhlowY1gclfsrBh8m
         1fZ+/jpYfXT6RbcfN7HTnKCyLDLiBqoSBCAlKGKLenPlZuqb/jkpR11IL2h2bvVx9qjO
         e3lV1x5ZdREhS0AJo04YeGsM3lKfqmjicZIaioTExcf1UXN6mcT2ZlkMiUCuwUPVxVCU
         mOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BA9WuBIxyQk+4n/puy9O59CDd70ZfBaz5viH95nnWs4=;
        b=JtPMZSn42qm0mtmshUL8vkpbofCvXjFVpifuD3D5ZGbF4XVwAvbSjvagas0WCR6jGO
         Oo8xd4Sa0FDQdkywmHnfaSOwVEVIXlfk58JLYNjJCPDmgyqBirMRTfD4WbT4W8BqAHnK
         4DcYUL84hKdfTBN3QrapbkRn2PvB2fcOmpTjvy0UFTfrhwB9XUk7S4XKLjN2MdTLJAzG
         Q66UzcWYwB8wmNUweVaogDARSH5UgyxK+LxShMd6gcjXApWRmCRUNVuUPEHCTAef44BT
         8yPdX5rePWn9lXmIgtQKWc/BtZUwO63PN0emill8F8LkUl7aW1Z6rJbiq08umhE+YtYW
         HWRQ==
X-Gm-Message-State: AOAM530cTphHmk+mUcqXnfVgwqo4ZGRcTjT0q7Ad+hUbZ99HpsD3+lHc
        fdjLUUUIAeG9Rac/KBmN1KCa7fF1frRFEjSABIizgSM+qvo=
X-Google-Smtp-Source: ABdhPJxUnwG28U4x2TJF1H+XUZg6igju8tZHdlidMvSYFb6mYkxwU91jI9HPvsWClBG0KG6pytABKZPVyHx1apFqRr0=
X-Received: by 2002:a67:b347:: with SMTP id b7mr18370082vsm.15.1606771327575;
 Mon, 30 Nov 2020 13:22:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Mon, 30 Nov 2020 13:22:07
 -0800 (PST)
In-Reply-To: <20201130153742.9163-1-johan@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 Nov 2020 13:22:07 -0800
Message-ID: <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A quick background for Greg and others who haven't seen the Sept-Oct
discussion between me and Johan on the linux-usb ML: I am the hardware
engineer who designed the FT2232D-based DUART28C adapter board, and it
was my desire to have this custom FT2232D adapter supported in mainline
Linux that triggered the chain of discussions and patch revisions that
led to the present patch series by Johan.

My FTDI-based USB to dual UART adapter is special in that the DTR &
RTS signals on one of the two UART channels (FT2232D Channel B
specifically) have been repurposed for a non-serial, non-modem-control
use: they control open drain drivers (a Nexperia 74LVC2G07 buffer IC)
which drive PWON & RESET control signals that would otherwise be
driven by short-to-ground human-finger-operated pushbutton switches.
The standard Unix/POSIX/Linux behaviour (going all the way back to
1970s Original UNIX) of automatically asserting DTR & RTS on serial
port open is a killer for custom hw in which these signals have been
repurposed, thus I need some way to suppress this automatic DTR & RTS
assertion on tty device open.  With automatic assertion on open
suppressed, these two signals can then be freely manipulated by
userspace via TIOCMBIS and TIOCMBIC.

There have certainly been other serial devices in the past (whether
true RS-232 or USB-serial) in which DTR and/or RTS has been repurposed
for some non-standard use that does not tolerate unwanted auto-assert
on every device open, and to the best of my knowledge this problem
does not occur on Windows - thus it is quite possible that some other
hw engineer somewhere out there could design and build a custom serial
or USB-serial device with repurposed DTR/RTS that works fine under
Windows, but the moment someone in Linux community tries to get it
working under our free OS, they will run into the problem of unwanted
DTR & RTS auto-assertion on device open.

In our previous discussion Johan said "this has come up the in past",
referring to repurposed DTR and/or RTS signals doing non-standard
things, thus I find it a little surprising that this issue hasn't been
solved long before my time - but I guess I must be the first to
complain loudly enough to get something done about it, and someone
always has to be the first...

Johan's patch series provides two workable solutions to the problem of
unwanted DTR & RTS auto-assertion:

1) For hardware engineers like me who design and build their own
boards with the USB-serial chip fully embedded and who have their own
custom USB IDs, a driver quirk can be applied (as part of adding
support for the new USB ID) that sets the new tty port flag upon
detecting the USB ID of the custom hw device for which it is required
- this approach provides the highest level of friendliness to the
ultimate end user of the finished hardware product.

2) For situations in which the luxury of a custom USB ID is not
available, e.g., a situation where the device that does not tolerate
automatic DTR/RTS assertion on open is a physical RS-232 device that
can be connected to "any" serial port, the new sysfs attribute comes
to the rescue.

Johan's patch comments say that the new flag can also be brought out
to termios in the future, similarly to HUPCL, but I question the
usefulness of doing so, as it is a chicken and egg problem: one needs
to open the tty device in order to do termios ioctls on it, and if
that initial open triggers DTR/RTS hardware actions, then the end user
is still screwed.  If Johan or someone else can see a potential use
case for manipulating this new flag via termios (as opposed to sysfs
or USB-ID-based driver quirks), perhaps you could elaborate on it?

Andy Shevchenko wrote:

> > Add a nordy sysfs attribute to suppress raising the modem-control lines
> > on open to signal DTE readiness.
>
> Why not call it nomctrl ?

I have no opinion one way or another as to what the new sysfs attribute
should be called - my use case won't involve this sysfs mechanism at
all, instead I care much more about the path where the tty port flag
gets set via a driver quirk upon seeing my custom USB ID. :)

The naming of the internal tty port flag is likewise a matter which I
gladly leave to more qualified kernel developers like Johan and Greg.

In any case, it would be really awesome if this patch series (with or
without further modifications) can make it into 5.10 - any chance of
such happening, or will it have to be pushed out to 5.11?

Sincerely,
Mychaela,
freelance hardware and software engineer,
she/her/hers
