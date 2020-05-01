Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3337C4724C
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9928D20757
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCmm1wMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgEANQq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728809AbgEANQp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 09:16:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E30C061A0C;
        Fri,  1 May 2020 06:16:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l20so4538885pgb.11;
        Fri, 01 May 2020 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2+/9XXY8Y1RxQllaPBwEstw2gB8BpLP9hF+BFGMRto=;
        b=GCmm1wMVqYxnGfNpvKp1cw9fbv2U2gMWk1CMbTh48Hm7wPNMne/GbW31xoR7mD00S6
         +uYXr4iDO7nSP6i6NtmbZ50/3IbLNNl4H21oYebEd34ccm62tuScRjfDRf1UWetYkb65
         odnWO7yMmFF0syGwu/kMQNNJLwLW9Ij93HzkYPKmRli9xqzyC1VZ3EEehyJPysb8KWdz
         T+7Umkferm/ayeT9tP5ghbICCAKDJv7XaRspMAl82ljUL/xT1Jwb2cPlduJ7JsQ0OhsH
         Ld0vBtmY9g6MuytPotItD3U+UU2gcrdRAg8rKiiJr6QVPNe7h5eDislLZN2nuhtD84Cl
         FNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2+/9XXY8Y1RxQllaPBwEstw2gB8BpLP9hF+BFGMRto=;
        b=rSy2Pt8N0sREFiUERz8cWRLX2mHTohJw2fT5eigFfXMfLUQzc3qHvHRue2jVjaGUI/
         VR34jNs9etyCCfSGSFiQ+qru15W00f3vuCLK7Dy5lHPrV67ARCLJEpDu4GMTwt48PYUy
         rhgKzlsOaUIEco1lUnS/3NXBr31UrN8Kzq9f5Z4iDDhWUlxhC6kKJdsUeG0hll77mVUb
         4ttdvcAe/zcFtEnCMkRhsEBYFZZohH4wfI15vUaoWIGbofxpnWAHBVlcX8awxV1gkTtc
         hbdVTdoO5RLzFb3mbvMCEW9fCPAeom8SJyy35wLST1h4A06vCwX3Uvu4vyU+CDIWjVVy
         XvLw==
X-Gm-Message-State: AGi0PuYoN+I/RNTF0N84qwVotjlKp2qxAS4946m9YtiyghtNcGfLi178
        XYnxUFnlfFQDOpctkA1NRW2C8sMDGHBhH9mWShc=
X-Google-Smtp-Source: APiQypKHDrDQjerRe+W1cA8mxnGSdNgtk0He587ZvD8AdxHMslTtV5DWvxC7LaTDqCSIrv6W6qI497cIXQBPbgQab8o=
X-Received: by 2002:a62:f908:: with SMTP id o8mr4034258pfh.170.1588339005327;
 Fri, 01 May 2020 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200501013044.GA288759@jagdpanzerIV.localdomain> <818ba356-ba35-68de-b7bf-f145a89280f1@gmail.com>
In-Reply-To: <818ba356-ba35-68de-b7bf-f145a89280f1@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 May 2020 16:16:33 +0300
Message-ID: <CAHp75VeZRwUp+CpOct4dCAQAfyJZBAY7=qSKwRQh935KEMWw+g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and
 device-tree chosen stdout-path
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 1, 2020 at 2:11 PM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
> On 01/05/2020 04:30, Sergey Senozhatsky wrote:

> I'm assuming "by default" here means "without console arguments"
> regardless of firmware requests. This paragraph (with small changes) is
> repeated on many other Kconfig descriptions (drivers/tty/serial/Kconfig,
> drivers/tty/serial/8250/Kconfig, arch/sparc/Kconfig from grepping for
> '/dev/tty0' on **/Kconfig).
>
> From Documentation/admin-guide/serial-console.rst:
>
> > You can specify multiple console= options on the kernel command line.
> > [...]
> > Note that you can only define one console per device type (serial, video).
> >
> > If no console device is specified, the first device found capable of
> > acting as a system console will be used. At this time, the system
> > first looks for a VGA card and then for a serial port. So if you don't
> > have a VGA card in your system the first serial port will automatically
> > become the console.
>
> and later on:
>
> > Note that if you boot without a ``console=`` option (or with
> > ``console=/dev/tty0``), ``/dev/console`` is the same as ``/dev/tty0``.
> > In that case everything will still work.

I'm wondering if behaviour is changed if you put console=tty1 instead
of console=tty0.

-- 
With Best Regards,
Andy Shevchenko
