Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D95C004D4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 19:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjASTkh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjASTkf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 14:40:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F129373D
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 11:40:34 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j9so2423890qtv.4
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxiDazJ+Nutg44rKg7vbrQ22z5FdTpODyxYh5D8yOvU=;
        b=kHc3XPur9V2u/VHPdZRXpwwU31Cf9zLAYODXO3KHeFlQJpWUXOD26foHnrOQkiqthS
         gJcOU0WIcvyKh0iROHne1QD16qxT68GyCtOfcErU3xA8AlxBBC+2nMas9rhDUs/nZ3+j
         4CPcIjhI1z9V5pp703LG/Em4j/uTWAktM1/KP+i+tuR/oRmiJauNbDAGnGyARln6ptHG
         iB/9A3oTXvMWugpJgZvJD4N40RIc+0I4BXqRG2Quq8rr9oKEJYK7NaOWFr8g5hembcGK
         NFr/cMVcHeEfhNejvUPNIXNn8n9GGKtGV9qHwLg5aHr58e+8fvpKc2wYJwwnbWlrQ/EO
         JbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxiDazJ+Nutg44rKg7vbrQ22z5FdTpODyxYh5D8yOvU=;
        b=hFHJcYoSl9zTyydR3SGtd9uI25Q33iIiKBXnzcCfX901ruf9HYsxlRHprzuB2Yta4U
         79Tz9H9ra0Akw13IGbarP9kA1KaT79XdD89ZHUrUVytD7CjheR9y2EBvh5yooylrvpqn
         4Xa0jhro64kTKVR4mOchkob9NIxtmCbOoBHg4tOLMfEP1/eCcQDaJZ6QPwBrGmsET9+C
         J7Amf3vvr40+p083xdh0gIj5ggJnyiCvtocwx2bw9jGJdY3tdDBDvYfCmbBDrnc4LGV2
         Qyh7kuM+5AO+sb4pEGqbB+F+S0wkqdrWtyZTXSQW8hJy9NOADqu4Bx36mPo+2aVU2Is6
         uAyQ==
X-Gm-Message-State: AFqh2koCsMODzyrAtaDfMZTmX4SA4tHJbPV/N8xiuaRh7wMV6Vo0aAGC
        e8FgM4zkgTvnI1CmZaxtlEq1OR7a34iE1uOj2uw=
X-Google-Smtp-Source: AMrXdXsP8qizp3ctluOP010+UUyLMkjAxfHqt5yO6gp4ycvi0KJdr3vGSeS9tL9crNqS2ufERMf2pA==
X-Received: by 2002:ac8:6f09:0:b0:3b6:2d34:45ef with SMTP id bs9-20020ac86f09000000b003b62d3445efmr19633680qtb.7.1674157233838;
        Thu, 19 Jan 2023 11:40:33 -0800 (PST)
Received: from tstest-VirtualBox.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a25cb00b006bbf85cad0fsm24863874qko.20.2023.01.19.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:40:33 -0800 (PST)
From:   Matthew Howell <mrhowel@g.clemson.edu>
X-Google-Original-From: Matthew Howell <ts-test@tstest-VirtualBox>
Date:   Thu, 19 Jan 2023 14:40:29 -0500 (EST)
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH v4] serial: exar: Add support for Sealevel 7xxxC serial
 cards
Message-ID: <alpine.DEB.2.21.2301191440010.22558@tstest-VirtualBox>
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
* Updates exar_pci_probe() to set nr_ports to last two bytes of primary dev 
ID for these cards.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---

v2: Moved "This patch..." above signed-off line.
v3: "Added From: Matthew Howell <matthew.howell@sealevel.com>" to
submission.
v4: Insert patch so it doesn't linewrap.

Let me know if I need to make any more changes.

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
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
@@ -638,6 +644,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
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
