Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DFC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B7160F48
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 08:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhG3IUg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 04:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238042AbhG3IUf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 04:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05C8F60E94;
        Fri, 30 Jul 2021 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627633230;
        bh=BUZTPaM59Y0A3r0P9qx576r8W25GIdnfoas3jeRUzlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY0JXrIuVwoVynt3cJtDe+mtTuuUqbYHkVqlt+9g9VX2s9WsYNZyhvoabWRcYjsN6
         Mdhn5SvB6AaSDFdnHmlqf05oE9YHuQksANX0cobKyy7c/K/+lnEbjvt+5sf+ByQf4T
         /z26Nun+cyJ46ARaC/63wEpxnxiTm9SdBlGn6n/I=
Date:   Fri, 30 Jul 2021 10:20:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X)
 interrupts.
Message-ID: <YQO2SytBcDzz1m5F@kroah.com>
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
 <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de>
 <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcX3_0G=Ks4PZxVqTP6Ztzi7yUHAHSENOs9eNXj0=MwFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 29, 2021 at 06:25:54PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 29, 2021 at 11:37 AM Ralf Ramsauer
> <ralf.ramsauer@oth-regensburg.de> wrote:
> > On 29/07/2021 06:33, Mario Kleiner wrote:
> > > This attempts to fix a bug found with a serial port card which uses
> > > an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> > > currently supported. I don't possess such a card, and i'm not
> > > experienced with the serial subsystem, so this patch is based on what
> > > i think i found as a likely reason for failure, based on walking the
> > > user who actually owns the card through some diagnostic.
> >
> > As there's currently some (stuck) discussion on how to generally handle
> > MSI capable serial cards, and this is issue related to some degree, let
> > me Cc Jiri and Andy.
> 
> Thanks, Ralf!
> 
> > > The user who reported the problem finds the following in his dmesg
> > > output for the relevant ttyS4 and ttyS5:
> > >
> > > [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> > > [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> > > ...
> > > [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> > > ...
> > >
> > > Output of setserial -a:
> > >
> > > /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> > >       Baud_base: 115200, close_delay: 50, divisor: 0
> > >       closing_wait: 3000
> > >       Flags: spd_normal skip_test
> > >
> > > This suggests to me that the serial driver wants to register and share a
> > > MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> > > not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> > > serial port driver means to share the irq, and this mismatch ends in some
> > > failed irq init?
> > >
> > > With this setup, data reception works very unreliable, with dropped data,
> > > already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> > > a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> > > mishandled or not used at all rx irq's?
> > >
> > > See full discussion thread with attempted diagnosis at:
> > >
> > > https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> > >
> > > Disabling the use of MSI interrupts for the serial port pci card did
> > > fix the reliability problems. The user executed the following sequence
> > > of commands to achieve this:
> > >
> > > # Disable PCI serial port driver, shut down card:
> > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> > >
> > > # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> > > echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> > >
> > > # Restart driver, reinitialize card, hopefully without MSI irqs now:
> > > echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> > > echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> > >
> > > This resulted in the following log output:
> > >
> > > [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> > > [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> > > [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> > > [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> > >
> > > This patch attempts to fix the problem by disabling irq sharing when
> > > using MSI irq's. Note that all i know for sure is that disabling MSI
> 
> In general the shared MSI interrupts are weird things that can be done
> with IRQs.
> 
> > > irq's fixed the problem for the user, so this patch could be wrong and
> > > is untested. Please review with caution, keeping this in mind.
> 
> I think it's a good idea in general. I have no objections.

So is that a "reviewed-by" for this patch?

thanks,

greg k-h
