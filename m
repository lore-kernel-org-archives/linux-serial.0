Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6946C433FB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8090020771
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=g-clemson-edu.20150623.gappssmtp.com header.i=@g-clemson-edu.20150623.gappssmtp.com header.b="vTFVxANE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbgGVUL1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732791AbgGVUL0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 16:11:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6645BC0619DC
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2020 13:11:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so2785368qtm.10
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2020 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=L7bhn4spU+NBDgg5EABDORW/iXaxYAZneHN6frZeQko=;
        b=vTFVxANEURxYQXJF8ny/wZ4WBfwoke/2SvN7SikLudohjHKX1vebgrsoYlsUE2lub2
         b+IZdWW1D3w4Xg8z1NruJan1fnT5FOT6qDbcAvK8QXJ46XdBOdYNg4cihBuysOU5ZIs/
         E4Tk186dDekJhM4xQ3F5wrMt2kvKU8JCZDXZEfxjXH7JxUznFuysOJIbxoazyzEmSW0e
         MB2/idSv1adD9ihh/hrUvbpJGgzutcOc8tUpuJbTIeryFYj4ai2e7LgTiOOrAwpPUx33
         eHsEkLICN13p7M6vylBmM/jPfRhwPaLScn/A/J9p1yeQRZnOe2HEcSZNjK7bycCZ7Akm
         vprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=L7bhn4spU+NBDgg5EABDORW/iXaxYAZneHN6frZeQko=;
        b=LTT635p5j+yeCotEISIVIk/9LeOPeFLv9diE6hTtaFgKulzVW3AZCn9Le55hWZwjmY
         g2RvA+uiP87mpcr+RYOVCEE+EPYO5ufUk4JL+jgc2Xi1gUvAjHiCHcLQHVenXptO2rmk
         qUem9puTpHz0aqAoXtoGsl77zuykj2jE+EBBpwMQpx0cj1V9RqJV08Xb32pN915AJbXn
         37c54UrytrOab0Cmsz1pAvhkvpRApSMErOIepQepDSj5zbtdWew0YBfpEk1BWLrBkbgw
         KEVRWnc5JOsHawIwxFUn3NMrDr8L8eQQyICcQK1q8KUQWnifmEsIgFZZmUVEg8PkhGPS
         VJfg==
X-Gm-Message-State: AOAM532digAaUehl9TpcZRddhl5ZFUVhhQCY+LhkVcCk3Spg+/0PjdeC
        +OejKrQCyTxAsTJ8g/sxcc3HFDDYs/jv8Orv
X-Google-Smtp-Source: ABdhPJyMOFiN34ZZcC+UFmsDEJwVjd7/FgSpZoUrV3DfhrPc/vTwM75wFzdvDkj9MGSlfFhbiC2leg==
X-Received: by 2002:aed:3f2c:: with SMTP id p41mr1126250qtf.12.1595448685615;
        Wed, 22 Jul 2020 13:11:25 -0700 (PDT)
Received: from tstest-VirtualBox ([12.18.222.50])
        by smtp.gmail.com with ESMTPSA id r185sm790487qkb.39.2020.07.22.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:11:24 -0700 (PDT)
From:   Matthew Howell <mrhowel@g.clemson.edu>
X-Google-Original-From: Matthew Howell <ts-test@tstest-VirtualBox>
Date:   Wed, 22 Jul 2020 16:11:24 -0400 (EDT)
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: [PATCH v4] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <alpine.DEB.2.21.2007221605270.13247@tstest-VirtualBox>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR17V35X based devices are inoperable on kernel versions
4.11 and above due to a change in the GPIO preconfiguration introduced in
commit
7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
cards to the value (0x00) used prior to commit 7dea8165f1d

With GPIOs preconfigured as per commit 7dea8165f1d all ports on
Sealevel XR17V35X based devices become stuck in high impedance
mode, regardless of dip-switch or software configuration. This
causes the device to become effectively unusable. This patch (in
various forms) has been distributed to our customers and no issues
related to it have been reported.

Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---

Revised based on comments received on previous submission
https://www.spinics.net/lists/linux-serial/msg39482.html

It had previously passed checkpatch.pl in "patch" mode (--patch)
without errors. However, when running it in "file" mode (-f) it finds
stling issues that did not show up in "patch" mode. These styling
issues are now resolved according to checkpatch.pl. It appears my
editor (and email client) were automatically converting tabs
to spaces.

Let me know if the tabs are still being converted to spaces somehow
or if anything else looks wrong.

--- linux/drivers/tty/serial/8250/8250_exar.c.orig	2020-07-09 11:05:03.920060577 -0400
+++ linux/drivers/tty/serial/8250/8250_exar.c	2020-07-22 14:08:27.494512202 -0400
@@ -326,7 +326,17 @@ static void setup_gpio(struct pci_dev *p
 	 * devices will export them as GPIOs, so we pre-configure them safely
 	 * as inputs.
 	 */
-	u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+
+	u8 dir = 0x00;
+
+	if  ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
+		(pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL)) {
+		// Configure GPIO as inputs for Commtech adapters
+		dir = 0xff;
+	} else {
+		// Configure GPIO as outputs for SeaLevel adapters
+		dir = 0x00;
+	}

 	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
