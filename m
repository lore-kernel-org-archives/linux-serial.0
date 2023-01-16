Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BFC46467
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 20:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjAPUvB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 15:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjAPUuM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 15:50:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2632E0CE
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 12:49:11 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d13so20269799qvj.8
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 12:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htxDw6oxhXjqQbE1UgetSmDIGG+7VDNJASjMOKXVnjk=;
        b=ifNKwmQjvP4wEv0ACZ0sU2EaMtXih+2zwcX3PKKV+vUjr17tUWbI2gJUVXkaxEGwRh
         +TWxshF/FYFZmHJG7hRDyF2o1a7WakZRqFfgJ8ko/5+bT4TVe+Dzam6kvrjeKwQw3mUN
         IjJdYyfyUKwR6AiFOSuLQMHxFiHWnshUZj2LpykT1XqjYfDs84fI23b7/ZhWQ1UwNGqx
         xBtt16u+zLw9xYO2Escvntc1eSztwxIAe+7+FOh5EV4/D6PHlz9MB4atJhWtTQd6yaM/
         R0xKI0M4Sn6eY3Z2cdmeLSRWduWKP9XSvYjgmaF1fhsQ04XV1jyoIB/DxziNlykBKbQE
         p/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htxDw6oxhXjqQbE1UgetSmDIGG+7VDNJASjMOKXVnjk=;
        b=zvI2TYRBvWqNQAULIJyqSCY9p6fW+NLHlS86LxPUJV5unRmsXjve4SwpZoBBpFVA31
         M62paFdlWjSew5ucthmD5KjJqos21yecMsJk4Qvoahj3Xh7dYTSOwDZ4YHrVdbym6mAc
         J5FPra6cZ3yL92tsXu8j+eqv6CY8YrJ4MMpqzUqdRKuOnYNYpZp5eugMyRseHEtKW457
         HQkrLtZCJNiynetOQ9hKwbnzu0OFnH61Ky83btSlsIE9g3OYcbQzvglDtso9HLFSysQE
         96Ty5wNIcFR9yCoeD1rffahZkZ31OFnVIMxBQPYwZFc+ajy07IonXJAEXTTAx9AnKuqQ
         ZTeg==
X-Gm-Message-State: AFqh2kpJKkqp+bABvVQuzGpXAZmUXDdDB6DspZWUIRTcRt4+V0AxhAVm
        EiO+xztpX4itn3TRH3zobwywQVV/vhs+qlFeptI=
X-Google-Smtp-Source: AMrXdXusqrefp38Nh6smDrOhjKHFsLh2pKlFrbtNYwNJvl9LloOTZBbFcIdO8fB5FXe3sOpNL6ahSA==
X-Received: by 2002:a05:6214:3202:b0:4d7:45fb:f5ac with SMTP id ms2-20020a056214320200b004d745fbf5acmr1379588qvb.23.1673902150491;
        Mon, 16 Jan 2023 12:49:10 -0800 (PST)
Received: from tstest-VirtualBox.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006bb82221013sm18711615qkb.0.2023.01.16.12.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:49:09 -0800 (PST)
From:   Matthew Howell <mrhowel@g.clemson.edu>
X-Google-Original-From: Matthew Howell <ts-test@tstest-VirtualBox>
Date:   Mon, 16 Jan 2023 15:49:08 -0500 (EST)
To:     linux-serial@vger.kernel.org
cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH] serial: exar: Add support for Sealevel 7xxxC serial cards
Message-ID: <alpine.DEB.2.21.2301161242150.19090@tstest-VirtualBox>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for Sealevel 7xxxC serial cards.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>

This patch:
* Adds IDs to recognize 7xxxC cards from Sealevel Systems.
* Updates exar_pci_probe() to set nr_ports to last two bytes of primary
dev ID for these cards.

Let me know if I need to make any changes.

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
