Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E3C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D70061139
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHMRFr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhHMRFq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 13:05:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D6C061756
        for <linux-serial@vger.kernel.org>; Fri, 13 Aug 2021 10:05:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so21562179pjr.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Aug 2021 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78XuOFlSxitJVl/k5AEDilsvgWxQvt6c0Z6uBsqMIic=;
        b=KO7937f76xJfOd3F3e3T3GYZmWqAog4lXR76YaUye1C9mxhtUdCEu0GN6+tB4zrh0r
         Jl/FIs3WD5KF8mrciLd3+WhpcuVKQx2oYubHV4dCCz0f8efIqKf2qjGIWu9b4nm6K25Q
         P4wUf9q25O0rT1D0z87Pts/Nmx7OYG7EERd44G1Apl/n067JbBKTv9L9t9GQ0AdozE/1
         1dL+OOhbo85kyu1fwd4Y6FntjPE5JWznkL3lQVuh4AGWTwms6W/YCasahmOcR+Mx6nER
         N3zYl+eh5sI51D5lhC1JiEg2IDphMFffDlyqG0lGXNsfYBQ0bSJWWR6Mc6JvF2hH+ocD
         rKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78XuOFlSxitJVl/k5AEDilsvgWxQvt6c0Z6uBsqMIic=;
        b=qDkKyYciWms8ikAVeGw0zIFQc8o+7usn2QXFTK7rQgveoXWem+k5LugbMQljwCQHKy
         Hwj7WXlyWeNGDd/DAklkKg2AphizvRgfZe1InTF8qmBkvFUjMazQdHJDeqC1utGiRzZ0
         Gj98CuDVjxhaTxP78ptonn5uZmA8Ln4bDGosndUzcemkeISMaZDoZImPoxzYsfK8qAhO
         +AacyNOJlW97mKYZGWUutAqbULP7j2xGY8LCQIYz693pqvtdOyZjfYIin0ht46WePKlZ
         cX63vEgsJ4sWyrappSonu5aVtxapEDfegRT+XFXPt3DwT6DKjLHZMNtzPadC2DD49Ehu
         oMLA==
X-Gm-Message-State: AOAM531yDHaAsn2dYexjunclt8ExPKICT2J8wgNZmrgTJ9biefAOhTTT
        SaBwHDqb5GPlu8Ju1xJM8RZ735aADKTiDb25KuY=
X-Google-Smtp-Source: ABdhPJybsZYnWRIjLD17gNiI5eBEqmKN+nmybW9NjkkgKpb0YQhdwDCZ3RR2k9v72vqIn3BdWC9he5U1A9GXZdKSAbg=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr3411727pfi.7.1628874319549; Fri, 13 Aug
 2021 10:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
 <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de> <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
 <YQO2SytBcDzz1m5F@kroah.com> <CAHp75VfkK+i1mh=_UFnbobqsSOocze4uzUtQjf_S+wZxzuw=uQ@mail.gmail.com>
 <CAEsyxyhqxUMw6nV2ULn3VS8Jax+r95+pZD-sZh5-NDOje3C6NQ@mail.gmail.com>
In-Reply-To: <CAEsyxyhqxUMw6nV2ULn3VS8Jax+r95+pZD-sZh5-NDOje3C6NQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Aug 2021 20:04:39 +0300
Message-ID: <CAHp75VdLR8K_eYwfyfVZUyaOhtq0OyyHA0n0bcjWwNpFOEt1xg@mail.gmail.com>
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.
To:     Mario Kleiner <mario.kleiner.de@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 7:45 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Btw., one question to the experts, after much more grepping through
> the irq handling code and being no wiser than before:
>
> My understanding of MSI(-X) is that one of the big advantages over
> legacy IRQ is that there are so many available MSI IRQ's, and so IRQ
> sharing is normally not needed. So why did the driver choose an MSI
> irq shared with the USB host controller? Or iow., why did
>
> pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES); and uart.port.irq
> = pci_irq_vector(dev, 0); return a IRQ number that was already in use
> at that time? Is this something to be expected, or some quirk specific
> to serial drivers or this hw?

My theory is that they are sharing the same pin on the PCI bus and
drivers have a SHARED flag and some code inside IRQ core decides that
it's fine to have them shared. But I think the best person to answer
is Thomas.

> > > > > On 29/07/2021 06:33, Mario Kleiner wrote:
> > > > > > This attempts to fix a bug found with a serial port card which uses
> > > > > > an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> > > > > > currently supported. I don't possess such a card, and i'm not
> > > > > > experienced with the serial subsystem, so this patch is based on what
> > > > > > i think i found as a likely reason for failure, based on walking the
> > > > > > user who actually owns the card through some diagnostic.
> > > > >
> > > > > As there's currently some (stuck) discussion on how to generally handle
> > > > > MSI capable serial cards, and this is issue related to some degree, let
> > > > > me Cc Jiri and Andy.
> > > >
> > > > Thanks, Ralf!
> > > >
> > > > > > The user who reported the problem finds the following in his dmesg
> > > > > > output for the relevant ttyS4 and ttyS5:
> > > > > >
> > > > > > [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > > > > [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> > > > > > [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > > > > [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> > > > > > ...
> > > > > > [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > > > [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > > > > ...
> > > > > >
> > > > > > Output of setserial -a:
> > > > > >
> > > > > > /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> > > > > >       Baud_base: 115200, close_delay: 50, divisor: 0
> > > > > >       closing_wait: 3000
> > > > > >       Flags: spd_normal skip_test
> > > > > >
> > > > > > This suggests to me that the serial driver wants to register and share a
> > > > > > MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> > > > > > not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> > > > > > serial port driver means to share the irq, and this mismatch ends in some
> > > > > > failed irq init?
> > > > > >
> > > > > > With this setup, data reception works very unreliable, with dropped data,
> > > > > > already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> > > > > > a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> > > > > > mishandled or not used at all rx irq's?
> > > > > >
> > > > > > See full discussion thread with attempted diagnosis at:
> > > > > >
> > > > > > https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> > > > > >
> > > > > > Disabling the use of MSI interrupts for the serial port pci card did
> > > > > > fix the reliability problems. The user executed the following sequence
> > > > > > of commands to achieve this:
> > > > > >
> > > > > > # Disable PCI serial port driver, shut down card:
> > > > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > > > >
> > > > > > # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> > > > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> > > > > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> > > > > >
> > > > > > # Restart driver, reinitialize card, hopefully without MSI irqs now:
> > > > > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > > > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > > > >
> > > > > > This resulted in the following log output:
> > > > > >
> > > > > > [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> > > > > > [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> > > > > > [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> > > > > > [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> > > > > >
> > > > > > This patch attempts to fix the problem by disabling irq sharing when
> > > > > > using MSI irq's. Note that all i know for sure is that disabling MSI
> > > >
> > > > In general the shared MSI interrupts are weird things that can be done
> > > > with IRQs.
> > > >
> > > > > > irq's fixed the problem for the user, so this patch could be wrong and
> > > > > > is untested. Please review with caution, keeping this in mind.
> > > >
> > > > I think it's a good idea in general. I have no objections.

-- 
With Best Regards,
Andy Shevchenko
