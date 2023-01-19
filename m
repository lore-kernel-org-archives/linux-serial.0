Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81050C004D4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 17:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjASRLH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjASRLE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 12:11:04 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5058F6FB
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 09:10:57 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4d13cb4bbffso36660007b3.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mnbgHUhFLfnpUkE71GTIVH2rgETIind6t1t/sYcEOwA=;
        b=RxDmlsG251IilItp3f9kJiPDGGoAMREZPfb9MPgfO7RKvrNrFoRe3FK71m8oWzrsFR
         Bhrx6Osm9rz9yW3cq75If8k3b9m3rGhbxa14dWYeFNOpusDCwk4d6aaamxBE8RPn07vx
         OyzeE9ShlCpXXI7iooRE4V0KNy/x5u2hwpqs4VSLCL+eLZ0zeaxbYEM3+F0erCsl25oM
         pJxgRvXotZwwGOCP0VxedRWWHsiL4eXst/1DKpfyKJidW0LiLovE98axPKb2qmxPQVne
         BobyGEjnpCIi0CdQi/uUAi1sa8f7xMK+kGjIAWTuo8oxZrEqkXGDtRdBEut5bY3NXCQh
         DFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnbgHUhFLfnpUkE71GTIVH2rgETIind6t1t/sYcEOwA=;
        b=vHuLfwExLxdJ521A7mMN22tCj7H6Hrjv2i+7SqUP+KL2UOUiJVDVqfa2yLc1flfkbd
         RXilDK8sCd62NkQZvofMi23p8cTU15N5qeCHiVfWGnapJgMVaiMxeMA2EVaHqt1x4zmz
         hBhcIPwle/80MkSzUXn3KOtzhfj2McAuYLeZdBnJezCCO1ubY1gJDIiRHE687me9vqlQ
         lYp0Qa5fPHPt8IYziFmp1zOkeo7Pr7nUWUR6Xcjf4S5bf7w4OA7hmJqJTyntQjvZPZmB
         SGAmgH3+wu2GJqRbxa0waPsKlDuaXl9KmWKIZkWhmZqyHJctcOPzM8fuijr9OqNvjqPO
         6svQ==
X-Gm-Message-State: AFqh2koUTgGX6g4eco34YgTBa+XPkhqNToXYcodKe0Ag55WQNSBKMsvh
        kLuchVfe6sCyrLZ3yFeWMx0bMw==
X-Google-Smtp-Source: AMrXdXvubxIePvSFHtHHIhCqYRM3WZ/OJcV/MCBxrVOpx27fIX4tFCtgaWdvSI000Bwrd7OtINc3XA==
X-Received: by 2002:a05:7500:f1c:b0:f1:8ec7:3515 with SMTP id kl28-20020a0575000f1c00b000f18ec73515mr973621gab.32.1674148256751;
        Thu, 19 Jan 2023 09:10:56 -0800 (PST)
Received: from tstest-VirtualBox.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id de9-20020a05620a370900b007057cc1e87bsm23877695qkb.136.2023.01.19.09.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:10:56 -0800 (PST)
From:   Matthew Howell <mrhowel@g.clemson.edu>
X-Google-Original-From: Matthew Howell <ts-test@tstest-VirtualBox>
Date:   Thu, 19 Jan 2023 12:10:49 -0500 (EST)
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH v3] serial: exar: Add support for Sealevel 7xxxC serial
 cards
Message-ID: <alpine.DEB.2.21.2301191204520.22332@tstest-VirtualBox>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Add support for Sealevel 7xxxC serial cards.

This patch:
* Adds IDs to recognize 7xxxC cards from Sealevel Systems.
* Updates exar_pci_probe() to set nr_ports to last two bytes of primary
dev ID for these cards.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---

v2: Moved "This patch..." above signed-off line.
v3: "Added From: Matthew Howell <matthew.howell@sealevel.com>" to
submission.

Let me know if I need to make any more changes.

diff --git a/drivers/tty/serial/8250/8250_exar.c
b/drivers/tty/serial/8250/8250_exar.c
index 314a05e00..64770c62b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -43,6 +43,12 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358

+#define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
+#define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
+#define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
+#define PCI_DEVICE_ID_SEALEVEL_780xC		0x1008
+#define PCI_DEVICE_ID_SEALEVEL_716xC		0x1010
+
 #define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
 #define UART_EXAR_SLEEP	0x8b	/* Sleep mode */
@@ -638,6 +644,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
pci_device_id *ent)
 		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
 	else if (board->num_ports)
 		nr_ports = board->num_ports;
+	else if (pcidev->vendor == PCI_VENDOR_ID_SEALEVEL)
+		nr_ports = pcidev->device & 0xff;
 	else
 		nr_ports = pcidev->device & 0x0f;

@@ -864,6 +872,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
+
+	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
