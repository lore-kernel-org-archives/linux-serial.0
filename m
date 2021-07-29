Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DDC4320A
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEAA60F43
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhG2P0i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbhG2P0i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:26:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B5C061765
        for <linux-serial@vger.kernel.org>; Thu, 29 Jul 2021 08:26:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso9840223pjf.4
        for <linux-serial@vger.kernel.org>; Thu, 29 Jul 2021 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKAnZUzlZMwAPvgZHfW5VSNzran0EoCWpWRP+oBSRf4=;
        b=mPFvlCGBu8ySTQhxcgIqG5Y15Hytyy4uz7oNzS6sm5waHpDmplDdxO/LQQffaZTHyy
         6s9OmcTIg8xcWtKe6V0zG/eg6zaBsjp0TcqKfgYqH1pIJrGFUoXjYmxV0G54CpDaYXpe
         m53s/8ctNRjhOy8gp+hYx+KqTQeyp4odJivNOayp3Tripm8kh6Wk7ah/Fp4bvNP22iI8
         3KlflpL4BmTSBQCDb2KYOzC0QXI6EHzcJwGP7jyXiYtHZPqrP1YcZrLbiDFxt7ykhakq
         c4yxD6W6VTfAnykjN23r1h5F9ffAlNS4HS/NewFv19ovvG98fn9AUzsJsZuLFT2nuQ0l
         OSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKAnZUzlZMwAPvgZHfW5VSNzran0EoCWpWRP+oBSRf4=;
        b=jUuhgbOiqoLrf28DnQAW28nW9vwjEpPwbfvtQYQcMwZ4DO9EkRn89szBsHc1M3aywK
         snrxGm5DBwpcMoWkDnkekhc6mKWoygTTK5akyXsXAHZJD/v1+x5ZIfd4FVikEQO70LAQ
         y+cCAliR1C7dSCgmx+wqpBRO5XuwYadT0I0jjjt/wvVihe+oCa499mRIiT+apW7+heZ6
         y01QBUWs0rxDV7gYLpA+NP6Eqo2a3MCFFjBsw1l2yqvuQsGvm6LX6mji5z81/80QqLrT
         k6xIsvjVJh2tdvsYVEm/P3m2J4p1xlKcP/ajjqcK+vj2lS0RF8woiOgHDfPqfFp3vvRH
         delA==
X-Gm-Message-State: AOAM533++cjGqrX0yg40+9a0yuDQv/mTWnMfjx705mi858KKBR685tDZ
        zQpHI0W2hsJBAEzxeC3YpHD8ahTwSvYb/Fb2IQs=
X-Google-Smtp-Source: ABdhPJw0kSq7enIB1OBE2SzyLHVgG3M8ZY1IwIbIfjMmweJeU/cJAhJX84NHMKcoxLO1RY+XhcLmTz4fykxeBB2BhCw=
X-Received: by 2002:a17:90a:7146:: with SMTP id g6mr5926757pjs.228.1627572393943;
 Thu, 29 Jul 2021 08:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com> <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de>
In-Reply-To: <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Jul 2021 18:25:54 +0300
Message-ID: <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Mario Kleiner <mario.kleiner.de@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 29, 2021 at 11:37 AM Ralf Ramsauer
<ralf.ramsauer@oth-regensburg.de> wrote:
> On 29/07/2021 06:33, Mario Kleiner wrote:
> > This attempts to fix a bug found with a serial port card which uses
> > an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> > currently supported. I don't possess such a card, and i'm not
> > experienced with the serial subsystem, so this patch is based on what
> > i think i found as a likely reason for failure, based on walking the
> > user who actually owns the card through some diagnostic.
>
> As there's currently some (stuck) discussion on how to generally handle
> MSI capable serial cards, and this is issue related to some degree, let
> me Cc Jiri and Andy.

Thanks, Ralf!

> > The user who reported the problem finds the following in his dmesg
> > output for the relevant ttyS4 and ttyS5:
> >
> > [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> > [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> > ...
> > [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > ...
> >
> > Output of setserial -a:
> >
> > /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> >       Baud_base: 115200, close_delay: 50, divisor: 0
> >       closing_wait: 3000
> >       Flags: spd_normal skip_test
> >
> > This suggests to me that the serial driver wants to register and share a
> > MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> > not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> > serial port driver means to share the irq, and this mismatch ends in some
> > failed irq init?
> >
> > With this setup, data reception works very unreliable, with dropped data,
> > already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> > a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> > mishandled or not used at all rx irq's?
> >
> > See full discussion thread with attempted diagnosis at:
> >
> > https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> >
> > Disabling the use of MSI interrupts for the serial port pci card did
> > fix the reliability problems. The user executed the following sequence
> > of commands to achieve this:
> >
> > # Disable PCI serial port driver, shut down card:
> > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> >
> > # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> >
> > # Restart driver, reinitialize card, hopefully without MSI irqs now:
> > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> >
> > This resulted in the following log output:
> >
> > [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> > [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> > [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> > [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> >
> > This patch attempts to fix the problem by disabling irq sharing when
> > using MSI irq's. Note that all i know for sure is that disabling MSI

In general the shared MSI interrupts are weird things that can be done
with IRQs.

> > irq's fixed the problem for the user, so this patch could be wrong and
> > is untested. Please review with caution, keeping this in mind.

I think it's a good idea in general. I have no objections.

> > Fixes: 8428413b1d14 ("serial: 8250_pci: Implement MSI(-X) support")
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> > index 780cc99732b6..35fd5c4e831a 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -3964,6 +3964,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
> >               if (pci_match_id(pci_use_msi, dev)) {
> >                       dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
> >                       pci_set_master(dev);
> > +                     uart.port.flags &= ~UPF_SHARE_IRQ;
> >                       rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> >               } else {
> >                       dev_dbg(&dev->dev, "Using legacy interrupts\n");
> >



--
With Best Regards,
Andy Shevchenko
