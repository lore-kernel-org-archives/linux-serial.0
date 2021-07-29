Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5904C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 04:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7694261052
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 04:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhG2Edf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 00:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2Ede (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 00:33:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34643C061757
        for <linux-serial@vger.kernel.org>; Wed, 28 Jul 2021 21:33:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n11so2814497wmd.2
        for <linux-serial@vger.kernel.org>; Wed, 28 Jul 2021 21:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRoWTLgHEC4ZcGP2PPoNtGhbfFLDUATvFjJoWZoJhk8=;
        b=nMRLApJywzmo2rRNsDA3pWj9l8as8dnpPBDqGJJB/D22f06tI3pS7Iw/RoYoXL74mm
         0qxUnjOUU6P6wVpnEF9A08bKVJPKfW59rTKJOZuqzUjkKju1kye49q/pl1HVXjnlKL46
         SKIoxDiC3T+9SPFd0He9Bg9KaAYSFpoIAvJApaNMUICAWUc56qsvNvuA68P62tn7XE3L
         GOGoo4uzC5EMMqQ+o4NKtD9bhz6/NA4W7/1S606z0SnQtbSkSq2wgFrbSFMXlMBH3kux
         wSe0hzzPYBcsFDas/rnqfG/K1XjTDYC55zjk3+o2rGu6CO5BGWXBWs4RZkaiPQVV/vOt
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CRoWTLgHEC4ZcGP2PPoNtGhbfFLDUATvFjJoWZoJhk8=;
        b=UFr3dQEaz8sejMtm2apVHCodO2xG/IX3oWoor9LFTSjKP5NKs6/cNbSFTYWjIQWIPG
         I1gSVWALwgHyHNH2uwTUyGcMajmQmIYWqmELChf3i5T4PP7ONOud03MuYDRHY8uEwIbx
         ZfO51TjlTiBMq9gqQr65IteOjzqVpNv8QWt3u/JtdjJYn/dZzXUg9GY5eA2fNwohXeHX
         Fd6OVOU2SjumlUYiTeS06pceuAMsXNax129xsPSKE2GFkTUwMr7BWJhW+2mnbiRAPzA2
         Jt7oIEFLaOwVFsFHyA9iGb6yKlSNq3twL/ukkuk4OBgtS30FKFEDjDTWuBG0L8ArWoU2
         I5eQ==
X-Gm-Message-State: AOAM533j90cMowIK/1BIjJr3k3lZcfqwfZ64M4SSJ67cRww6MzCpZT8t
        BU/Ki3jAQcrPivRUnr7UZTNXax5L/Eg=
X-Google-Smtp-Source: ABdhPJyYnVPOxTEi1bCUEfqEcw2csh1JcNEi4zvh2KV+ZpRX1YPW8MwiUaKA1KqWr8+xjhyv5I35MQ==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr2666504wmj.180.1627533209537;
        Wed, 28 Jul 2021 21:33:29 -0700 (PDT)
Received: from twisty.localdomain (x4db935cd.dyn.telefonica.de. [77.185.53.205])
        by smtp.gmail.com with ESMTPSA id n5sm1822822wri.31.2021.07.28.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:33:29 -0700 (PDT)
From:   Mario Kleiner <mario.kleiner.de@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     mario.kleiner.de@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: [PATCH] serial: 8250_pci: Avoid irq sharing for MSI(-X) interrupts.
Date:   Thu, 29 Jul 2021 06:33:06 +0200
Message-Id: <20210729043306.18528-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This attempts to fix a bug found with a serial port card which uses
an MCS9922 chip, one of the 4 models for which MSI-X interrupts are
currently supported. I don't possess such a card, and i'm not
experienced with the serial subsystem, so this patch is based on what
i think i found as a likely reason for failure, based on walking the
user who actually owns the card through some diagnostic.

The user who reported the problem finds the following in his dmesg
output for the relevant ttyS4 and ttyS5:

[    0.580425] serial 0000:02:00.0: enabling device (0000 -> 0003)
[    0.601448] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 125, base_baud = 115200) is a ST16650V2
[    0.603089] serial 0000:02:00.1: enabling device (0000 -> 0003)
[    0.624119] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 126, base_baud = 115200) is a ST16650V2
...
[    6.323784] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
[    6.324128] genirq: Flags mismatch irq 128. 00000080 (ttyS5) vs. 00000000 (xhci_hcd)
...

Output of setserial -a:

/dev/ttyS4, Line 4, UART: 16650V2, Port: 0x3010, IRQ: 127
	Baud_base: 115200, close_delay: 50, divisor: 0
	closing_wait: 3000
	Flags: spd_normal skip_test

This suggests to me that the serial driver wants to register and share a
MSI/MSI-X irq 128 with the xhci_hcd driver, whereas the xhci driver does
not want to share the irq, as flags 0x00000080 (== IRQF_SHARED) from the
serial port driver means to share the irq, and this mismatch ends in some
failed irq init?

With this setup, data reception works very unreliable, with dropped data,
already at a transmission rate of only a 16 Bytes chunk every 1/120th of
a second, ie. 1920 Bytes/sec, presumably due to rx fifo overflow due to
mishandled or not used at all rx irq's?

See full discussion thread with attempted diagnosis at:

https://psychtoolbox.discourse.group/t/issues-with-iscan-serial-port-recording/3886

Disabling the use of MSI interrupts for the serial port pci card did
fix the reliability problems. The user executed the following sequence
of commands to achieve this:

# Disable PCI serial port driver, shut down card:
echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/unbind
echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/unbind

# Disallow use of MSI/MSI-X interrupts on pci serial port card:
echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.0/msi_bus
echo 0 | sudo tee /sys/bus/pci/devices/0000:02:00.1/msi_bus

# Restart driver, reinitialize card, hopefully without MSI irqs now:
echo 0000:02:00.0 | sudo tee /sys/bus/pci/drivers/serial/bind
echo 0000:02:00.1 | sudo tee /sys/bus/pci/drivers/serial/bind

This resulted in the following log output:

[   82.179021] pci 0000:02:00.0: MSI/MSI-X disallowed for future drivers
[   87.003031] pci 0000:02:00.1: MSI/MSI-X disallowed for future drivers
[   98.537010] 0000:02:00.0: ttyS4 at I/O 0x3010 (irq = 17, base_baud = 115200) is a ST16650V2
[  103.648124] 0000:02:00.1: ttyS5 at I/O 0x3000 (irq = 18, base_baud = 115200) is a ST16650V2

This patch attempts to fix the problem by disabling irq sharing when
using MSI irq's. Note that all i know for sure is that disabling MSI
irq's fixed the problem for the user, so this patch could be wrong and
is untested. Please review with caution, keeping this in mind.

Fixes: 8428413b1d14 ("serial: 8250_pci: Implement MSI(-X) support")
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 drivers/tty/serial/8250/8250_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 780cc99732b6..35fd5c4e831a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3964,6 +3964,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		if (pci_match_id(pci_use_msi, dev)) {
 			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
 			pci_set_master(dev);
+			uart.port.flags &= ~UPF_SHARE_IRQ;
 			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 		} else {
 			dev_dbg(&dev->dev, "Using legacy interrupts\n");
-- 
2.25.1

