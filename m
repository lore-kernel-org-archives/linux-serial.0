Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F977C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E502061055
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 08:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhG2IhS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2IhS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 04:37:18 -0400
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [IPv6:2001:638:a01:1096::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA211C061757
        for <linux-serial@vger.kernel.org>; Thu, 29 Jul 2021 01:37:14 -0700 (PDT)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S03", Issuer "E16S03" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4Gb3ml39Xqzy0r;
        Thu, 29 Jul 2021 10:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1627547831;
        bh=akgDYmYCTU9JfNchW3hbF7iBi8vmqmo4dN+IYl2jUbA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=BWdapdRryEqFH+wKquB4f+fPZjrOB2UCCtXuLTxagZGVHDn6Kcqv0S/ghtiDKQEe5
         P/yazDQx/oSUtTCVlyGYZgPABGpbYiJtYH/jiuCDNmY9BYr2uE/ThssWwr+W5E3sKb
         fuV5V0BYqx574DQ56G2InAbCDwQTZO8PxQa8Co4z98xTsd3Y31UQn3siZnnjK+PvqM
         6/hhsg8Azg18lFRuIp3ydtuhMuif7/nPpItHOO6Wt27UETyFaZ/zJmFLy2U5+DwnA5
         JACt6XYfTWcFIcCy6WgNO5Kx08Bib9EehX+8vuiT0SB8XiI7uyZxW71QosPx3kB7lM
         9ws3ohmD3fObw==
Received: from [192.168.233.226] (194.95.106.138) by E16S03.hs-regensburg.de
 (2001:638:a01:8013::93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 10:37:11 +0200
Subject: Re: [EXT] [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X)
 interrupts.
To:     Mario Kleiner <mario.kleiner.de@gmail.com>,
        <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Message-ID: <283da956-e020-209e-052b-bfdd499ccca1@oth-regensburg.de>
Date:   Thu, 29 Jul 2021 10:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.95.106.138]
X-ClientProxiedBy: E16S02.hs-regensburg.de (2001:638:a01:8013::92) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 29/07/2021 06:33, Mario Kleiner wrote:
> This attempts to fix a bug found with a serial port card which uses
> an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
> currently supported. I don't possess such a card, and i'm not
> experienced with the serial subsystem, so this patch is based on what
> i think i found as a likely reason for failure, based on walking the
> user who actually owns the card through some diagnostic.

As there's currently some (stuck) discussion on how to generally handle
MSI capable serial cards, and this is issue related to some degree, let
me Cc Jiri and Andy.

  Ralf

> 
> The user who reported the problem finds the following in his dmesg
> output for the relevant ttyS4 and ttyS5:
> 
> [    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
> [    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
> [    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
> [    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
> ...
> [    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> [    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
> ...
> 
> Output of setserial -a:
> 
> /dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
> 	Baud_base: 115200, close_delay: 50, divisor: 0
> 	closing_wait: 3000
> 	Flags: spd_normal skip_test
> 
> This suggests to me that the serial driver wants to register and share a
> MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
> not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
> serial port driver means to share the irq, and this mismatch ends in some
> failed irq init?
> 
> With this setup, data reception works very unreliable, with dropped data,
> already at a transmission rate of only a 16 Bytes chunk every 1/120th of
> a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
> mishandled or not used at all rx irq's?
> 
> See full discussion thread with attempted diagnosis at:
> 
> https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886
> 
> Disabling the use of MSI interrupts for the serial port pci card did
> fix the reliability problems. The user executed the following sequence
> of commands to achieve this:
> 
> # Disable PCI serial port driver, shut down card:
> echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
> echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind
> 
> # Disallow use of MSI/MSI-X interrupts on pci serial port card:
> echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
> echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus
> 
> # Restart driver, reinitialize card, hopefully without MSI irqs now:
> echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
> echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind
> 
> This resulted in the following log output:
> 
> [   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
> [   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
> [   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
> [  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2
> 
> This patch attempts to fix the problem by disabling irq sharing when
> using MSI irq's. Note that all i know for sure is that disabling MSI
> irq's fixed the problem for the user, so this patch could be wrong and
> is untested. Please review with caution, keeping this in mind.
> 
> Fixes: 8428413b1d14 ("serial: 8250_pci: Implement MSI(-X) support")
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 780cc99732b6..35fd5c4e831a 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3964,6 +3964,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
>  		if (pci_match_id(pci_use_msi, dev)) {
>  			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
>  			pci_set_master(dev);
> +			uart.port.flags &= ~UPF_SHARE_IRQ;
>  			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
>  		} else {
>  			dev_dbg(&dev->dev, "Using legacy interrupts\n");
> 
