Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA3120717
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=g-clemson-edu.20150623.gappssmtp.com header.i=@g-clemson-edu.20150623.gappssmtp.com header.b="F76bKfIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGUUIW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUIW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 16:08:22 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567FC061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 13:08:22 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so3299qvb.11
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bE+aHMPt+2ywutqsSxCUEv0VI08jDvw1IRwhdxbiXGU=;
        b=F76bKfIZPGroMbEJQvLudH3bxeu3JW7J559unLYyvbPhuqIwOqg/Uhy/nvNsIZf+XS
         40KwZRqDAWa1tLm3AztUZHPjrut7yjT0DCd9pebLQF72lwrcnLsB3vOo14N4mfptosQs
         6IgJhNWP36hQMUzWX5LgZsANxJnPEEoxePT8r9UhwdhbRDsQqsFEbmN/mAndOEvOUF9y
         rhvFqOaUCrapSCuU3UQxSwBu5PHi3sB6lozeACBSq3yJ4x82TeymxFk4cFCvKawfIZ2D
         bop569NeNf8DGnx5UZfKOE3yFoeb+/jhk8+qVa5wFjzNpvT9sexGpTaLnmb6uNIG/N+2
         0ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bE+aHMPt+2ywutqsSxCUEv0VI08jDvw1IRwhdxbiXGU=;
        b=Oih7PVSbHumDYHFXwFaTef8nk0f19bkI7z9wrblqatgJXOcWRyC6CNvAilbE3kMvT9
         LAA284KJoT6DP+Iqkj6XSFa1KFFymHIAz+bZ9uefAcG23RcMT+wKdj4xWFXXrhmNuMiG
         jEZiGdV+jr83xevWb9JnWnl+s4jhq2AW340pazVSFZLYDRcduJ/HtizJT1/C5e0dz8+K
         If1RIobVpUb/cHbkGxmrIo3fN+tor96+x2FYuszMd1APRhrmRlTnhux3wxBWJs/vROm7
         xE648aJzgNKRgnxZ5Gw9dGgRwRMVpROIkmY9wkhNBTxOGa8fILxgtXH7BWhde+jIr9RB
         vtDA==
X-Gm-Message-State: AOAM531aY/ltv6twNQecL9wmqdbyS+G4weGUfVA97YhIMiLryfFCvU9u
        BNGy0RQe3Zk9Ieyio/8m/WBGeQ==
X-Google-Smtp-Source: ABdhPJw1HHaL3xSwkR9E7dSFg1CO/v8KQ/fZ68jRE0II5IqqDNX2U4CXZ0grnEftsRTTCkvc7Muwag==
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr26850042qvb.24.1595362101408;
        Tue, 21 Jul 2020 13:08:21 -0700 (PDT)
Received: from [10.0.2.15] ([12.18.222.50])
        by smtp.gmail.com with ESMTPSA id s128sm3210106qkd.108.2020.07.21.13.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:08:20 -0700 (PDT)
From:   Matthew Howell <mrhowel@g.clemson.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: [PATCH v3] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <9318fef6-f2d4-dc77-2a25-6033d63aab9b@g.clemson.edu>
Date:   Tue, 21 Jul 2020 16:08:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


From: Matthew Howell <matthew.howell@sealevel.com>

Sealevel XR17V35X based devices are inoperable on kernel versions
4.11 and above due to a change in the GPIO preconfiguration introduced in commit
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

Patch resubmitted as per comments received on
https://www.spinics.net/lists/linux-serial/msg39371.html

Moved problem description and justification above the signed-off-by
line.

checkpatch.pl reports no styling issues with the diff below.

Let me know if I need to make any other changes.

--- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
+++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-13 11:54:44.386718167 -0400
@@ -326,7 +326,20 @@ static void setup_gpio(struct pci_dev *p
      * devices will export them as GPIOs, so we pre-configure them safely
      * as inputs.
      */
-    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+
+    u8 dir = 0x00;
+
+    if  ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
+        (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
+    {
+       // Configure GPIO as inputs for Commtech adapters
+       dir = 0xff;
+    }
+    else
+    {
+       // Configure GPIO as outputs for SeaLevel adapters
+       dir = 0x00;
+    }

     writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
     writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);

