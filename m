Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45173C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2335E60F9B
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhG3IhM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhG3IhM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 04:37:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFCC061765
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 01:37:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k4-20020a17090a5144b02901731c776526so19730369pjm.4
        for <linux-serial@vger.kernel.org>; Fri, 30 Jul 2021 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJ+7WYNLUg8PY/jkycoOhRSiWUznYW9Jj4dDM8aTpA0=;
        b=fD8gj63cybxYBSC1k6d7/umtB8/6Af2bA+Lj+KGz4SrAfK7WAvLNy2NpdLbb/7r3wL
         LR3GOHu+kQmIm0JndzDYzp98BOJ7Nd/U9adKn8KjT+e99jUZRx3OI7JNXamGoaaD6NEP
         VEWsH1ZphDIlrM0QWfAuJHklg21fHNgxgV5pguoFMbOdNhBbXkovL7BSnq7essZyQ9j+
         RZSNC8lhKTteHAIqrj6F8R2ECa1M7BUaXKmZvT9Uio1hSABvaBUTCnr020XTjF9//5Ay
         mj+csdQ+jj+FFKiTuEeYDJwXsRZi2iK1Mgwpg/PeMTqQwXtR6DKD7DnFYS4AJPxvFBlh
         vOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJ+7WYNLUg8PY/jkycoOhRSiWUznYW9Jj4dDM8aTpA0=;
        b=K/pmOttXoIbppjEuZkaWZnWkhfCZezgl09PbIKPMI1lv0Z6ro2eBBBmOyQCHsuidYg
         6eYO21lBI7D5JiW3t3v0kuKVHdz3vYo3DPUtrfAJ2I4QgkWZFuCLhWH0z8Li/AE0rUQ/
         qDuNzEfDCUCn+Tr1w2QOPzOSWBLvLS7kn2m+bbSQEkTll7SWztmWrrb9RDuJCH6zhaQe
         VW6QB9VzAi+XhSgsDBAAAoCvPsmtvrLw13UO1XajtFeoClL3GCkmUzfb4YiXNUWdbotM
         jAmHApVy06nA2e6J8UDsdxkHwAc3U8ksBNTw5ipm4FK22l96l+w1zyJZKNGYo4n3UEax
         yZNA==
X-Gm-Message-State: AOAM530BjvXVXHQLkM3R57hL3P3mKaAr0/vrdBsBqP8MMbTZVbwBkk9+
        svwsrplP3NmpJexPpzgDwm6P8P3nCR+St3cscNc=
X-Google-Smtp-Source: ABdhPJyz2W3BuKmW0vuu+CHb2kSdLxJ14g/qsWW79DKsQ2UVck6XwpoyZqKIGH4a4a/jJZySOFvbW6sPUVsD3VvQfvg=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr1044258pgg.4.1627634227325;
 Fri, 30 Jul 2021 01:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
 <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de> <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
 <YQO2SytBcDzz1m5F@kroah.com>
In-Reply-To: <YQO2SytBcDzz1m5F@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jul 2021 11:36:27 +0300
Message-ID: <CAHp75VfkK+i1mh=_UFnbobqsSOocze4uzUtQjf_S+wZxzuw=uQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 30, 2021 at 11:20 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 29, 2021 at 06:25:54PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 29, 2021 at 11:37 AM Ralf Ramsauer
> > <ralf.ramsauer@oth-regensburg.de> wrote:
> > > On 29/07/2021 06:33, Mario Kleiner wrote:
> > > > This attempts to fix a bug found with a serial port card which uses
> > > > an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> > > > currently supported. I don't possess such a card, and i'm not
> > > > experienced with the serial subsystem, so this patch is based on what
> > > > i think i found as a likely reason for failure, based on walking the
> > > > user who actually owns the card through some diagnostic.
> > >
> > > As there's currently some (stuck) discussion on how to generally handle
> > > MSI capable serial cards, and this is issue related to some degree, let
> > > me Cc Jiri and Andy.
> >
> > Thanks, Ralf!
> >
> > > > The user who reported the problem finds the following in his dmesg
> > > > output for the relevant ttyS4 and ttyS5:
> > > >
> > > > [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > > [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> > > > [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > > [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> > > > ...
> > > > [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > ...
> > > >
> > > > Output of setserial -a:
> > > >
> > > > /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> > > >       Baud_base: 115200, close_delay: 50, divisor: 0
> > > >       closing_wait: 3000
> > > >       Flags: spd_normal skip_test
> > > >
> > > > This suggests to me that the serial driver wants to register and share a
> > > > MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> > > > not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> > > > serial port driver means to share the irq, and this mismatch ends in some
> > > > failed irq init?
> > > >
> > > > With this setup, data reception works very unreliable, with dropped data,
> > > > already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> > > > a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> > > > mishandled or not used at all rx irq's?
> > > >
> > > > See full discussion thread with attempted diagnosis at:
> > > >
> > > > https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> > > >
> > > > Disabling the use of MSI interrupts for the serial port pci card did
> > > > fix the reliability problems. The user executed the following sequence
> > > > of commands to achieve this:
> > > >
> > > > # Disable PCI serial port driver, shut down card:
> > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > >
> > > > # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> > > >
> > > > # Restart driver, reinitialize card, hopefully without MSI irqs now:
> > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > >
> > > > This resulted in the following log output:
> > > >
> > > > [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> > > > [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> > > > [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> > > > [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> > > >
> > > > This patch attempts to fix the problem by disabling irq sharing when
> > > > using MSI irq's. Note that all i know for sure is that disabling MSI
> >
> > In general the shared MSI interrupts are weird things that can be done
> > with IRQs.
> >
> > > > irq's fixed the problem for the user, so this patch could be wrong and
> > > > is untested. Please review with caution, keeping this in mind.
> >
> > I think it's a good idea in general. I have no objections.
>
> So is that a "reviewed-by" for this patch?

You may consider this way.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
