Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404AFC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6BE610A4
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhHMQqG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHMQqF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 12:46:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D00C061756
        for <linux-serial@vger.kernel.org>; Fri, 13 Aug 2021 09:45:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn28so4445037edb.6
        for <linux-serial@vger.kernel.org>; Fri, 13 Aug 2021 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fXmDt8cxtWUPIkHJ3gQUg9i0U7A39NcoF4HintO34w=;
        b=ryqSFmKCOvSk0wpgL+hdUL71ktkh04uqkmmGSKXk0C0PP/xh+9HT7DXjK0U0MNpscH
         JHrYkzKkGI2ll7PN/0549F7ITBjuE3HydyC4WFtGTJZXhWksYFKy3EdIqnfMQDI6qIrU
         BFAAGOgr0D2HSoRMUye/m3ZdYtC73+Po9B29lhdD5GLC9/vRvK5/TFCafzlwfsf6Lh2m
         UdvT94Evf1lgJkFi9WOWHW2t58OYPKhQX93TlI7fgXx+OpyBPKx6udd93JWQPfEa7wAt
         cztNUc00U9roWCUGVV3jxHYyQ+KKmfQ3lzYSWD+n1Bh+kN9RkUjNKKp2BSgNEhu9V26Q
         Cxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fXmDt8cxtWUPIkHJ3gQUg9i0U7A39NcoF4HintO34w=;
        b=bFjGxsdcuam6ks/Hh9fmuqRZKl1rdAoEF4MJPK8+8L6hNPWzPQcOQNgULIhmK77L5U
         iY7ysN8A7nZu3jVpOUn6aA1AgOi6hr5WY/cI7u7CubwG0lLRM59pZk1mRv2ZYvYBi1pT
         2BmCA//188ZPS64V25FJgq0P0AdN3NEjMtXcjP9y9x3dB+KsF1q700Iy3BYwkNOe7XV6
         dyqRs8HQjceml0XlbKqKFy9SAULkXNb5VN8xbrvyA/dp4HgzNHxdZ9RvVhb7qqQKkCeK
         Z4cYLDv4ApsQYZ0ngtSIJ6ZoeG8+vm5P1yzva9hLwr2BGM+VOGrcN113tkHD5a+YRzyY
         YJrg==
X-Gm-Message-State: AOAM532RVh84Xte9klrFukEbqrUEdMhNcozReKmUmcvHi24bdW6XKWjx
        I2J0w/93oPTD0OplDdX6zBbWD19B6QBNV7YaFZ4=
X-Google-Smtp-Source: ABdhPJyr+hIxJDPeRzWMB9FK4nPGJdzbTqj0Jq4YRKDqpukXfCsb1L/zoKY6IIHF/8r1+jOttTatotfuq09CO0jGlPw=
X-Received: by 2002:a50:be81:: with SMTP id b1mr4342777edk.295.1628873137287;
 Fri, 13 Aug 2021 09:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
 <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de> <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
 <YQO2SytBcDzz1m5F@kroah.com> <CAHp75VfkK+i1mh=_UFnbobqsSOocze4uzUtQjf_S+wZxzuw=uQ@mail.gmail.com>
In-Reply-To: <CAHp75VfkK+i1mh=_UFnbobqsSOocze4uzUtQjf_S+wZxzuw=uQ@mail.gmail.com>
From:   Mario Kleiner <mario.kleiner.de@gmail.com>
Date:   Fri, 13 Aug 2021 18:45:25 +0200
Message-ID: <CAEsyxyhqxUMw6nV2ULn3VS8Jax+r95+pZD-sZh5-NDOje3C6NQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Btw., one question to the experts, after much more grepping through
the irq handling code and being no wiser than before:

My understanding of MSI(-X) is that one of the big advantages over
legacy IRQ is that there are so many available MSI IRQ's, and so IRQ
sharing is normally not needed. So why did the driver choose an MSI
irq shared with the USB host controller? Or iow., why did

pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES); and uart.port.irq
= pci_irq_vector(dev, 0); return a IRQ number that was already in use
at that time? Is this something to be expected, or some quirk specific
to serial drivers or this hw?

Thanks and have a nice weekend,
-mario

On Fri, Jul 30, 2021 at 10:37 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 30, 2021 at 11:20 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 29, 2021 at 06:25:54PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 29, 2021 at 11:37 AM Ralf Ramsauer
> > > <ralf.ramsauer@oth-regensburg.de> wrote:
> > > > On 29/07/2021 06:33, Mario Kleiner wrote:
> > > > > This attempts to fix a bug found with a serial port card which uses
> > > > > an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> > > > > currently supported. I don't possess such a card, and i'm not
> > > > > experienced with the serial subsystem, so this patch is based on what
> > > > > i think i found as a likely reason for failure, based on walking the
> > > > > user who actually owns the card through some diagnostic.
> > > >
> > > > As there's currently some (stuck) discussion on how to generally handle
> > > > MSI capable serial cards, and this is issue related to some degree, let
> > > > me Cc Jiri and Andy.
> > >
> > > Thanks, Ralf!
> > >
> > > > > The user who reported the problem finds the following in his dmesg
> > > > > output for the relevant ttyS4 and ttyS5:
> > > > >
> > > > > [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > > > [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> > > > > [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > > > [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> > > > > ...
> > > > > [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > > [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > > ...
> > > > >
> > > > > Output of setserial -a:
> > > > >
> > > > > /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> > > > >       Baud_base: 115200, close_delay: 50, divisor: 0
> > > > >       closing_wait: 3000
> > > > >       Flags: spd_normal skip_test
> > > > >
> > > > > This suggests to me that the serial driver wants to register and share a
> > > > > MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> > > > > not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> > > > > serial port driver means to share the irq, and this mismatch ends in some
> > > > > failed irq init?
> > > > >
> > > > > With this setup, data reception works very unreliable, with dropped data,
> > > > > already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> > > > > a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> > > > > mishandled or not used at all rx irq's?
> > > > >
> > > > > See full discussion thread with attempted diagnosis at:
> > > > >
> > > > > https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> > > > >
> > > > > Disabling the use of MSI interrupts for the serial port pci card did
> > > > > fix the reliability problems. The user executed the following sequence
> > > > > of commands to achieve this:
> > > > >
> > > > > # Disable PCI serial port driver, shut down card:
> > > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > > >
> > > > > # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> > > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> > > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> > > > >
> > > > > # Restart driver, reinitialize card, hopefully without MSI irqs now:
> > > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > > >
> > > > > This resulted in the following log output:
> > > > >
> > > > > [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> > > > > [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> > > > > [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> > > > > [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> > > > >
> > > > > This patch attempts to fix the problem by disabling irq sharing when
> > > > > using MSI irq's. Note that all i know for sure is that disabling MSI
> > >
> > > In general the shared MSI interrupts are weird things that can be done
> > > with IRQs.
> > >
> > > > > irq's fixed the problem for the user, so this patch could be wrong and
> > > > > is untested. Please review with caution, keeping this in mind.
> > >
> > > I think it's a good idea in general. I have no objections.
> >
> > So is that a "reviewed-by" for this patch?
>
> You may consider this way.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> --
> With Best Regards,
> Andy Shevchenko
