Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02ABC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D84720748
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 20:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=g-clemson-edu.20150623.gappssmtp.com header.i=@g-clemson-edu.20150623.gappssmtp.com header.b="r4pxk89r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJUdE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJUdD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 16:33:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E2C08C5DC
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 13:33:03 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a32so5514394qtb.5
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=dwrU5XMw2ZcPXxtA/2F3GC2fBBG+7gT1jVHwVF2CABg=;
        b=r4pxk89r1abdVryYXZ7czwCMS4bIFBIfzJAMiYUIWWzMV3ckka47s7L5LytpXsCkST
         ox5xjvVG0pZMHueEllLQ3ZZ80Oz66n7SMEp2o6c46COnTJemcV3MWDcFAhGIv/GSj7P3
         jTS+gsltgd/8byAQJ4b3VOmjb8VcuOkURdD34BSvu8lVYrw2xj5vFRfoInSLRINRGdYt
         6R9kHp9o+pWSpaJNpZSWmcZxr5jkE3QX4fxOfp1N42POdzAvGnLVloKtHY14UGPamdoI
         iiRFP5xarOi/VWgy1Z026TP7ayGjrGn5DHpX2ZApDQ+WWjlA4cR7wc+dX0z87hfVvcLU
         Y2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=dwrU5XMw2ZcPXxtA/2F3GC2fBBG+7gT1jVHwVF2CABg=;
        b=PDK/7+7u3cuWEmPVzIYrtdhyTlA5xoflh8Y554GrvPJHCUvXBrD63h1Pkt8vQa2hdz
         VNm8wQAy+P1m/M5m85tsYJOYlMjWRDZuDgUMiAvtBbc6HjMOCc7LmFlQcrmLy4INLkfc
         cPCLF7wRRKaW+sPwRHI5ZQ6r1Zbtpz1Sb0KJrgefRV416arr3zcHCcMcN2oE4UjPmo/j
         WQVXiRHDeqVJOo+vtBKOA9DXogj01TtoyYQFdIknV6clGbx6eZtepcdqTBWbyyxbkLsX
         AzyO7AyX3YBKTdUy1u5jqeRbID5nfzXCao4RZU5EN4UsZQO2x57DIexTmL9XwqskXVFE
         i2Hg==
X-Gm-Message-State: AOAM533gfUSpaXQDqJgaq6CZXJ5X3Kj18PsMeh4bTvxVfXSN+TfclYg2
        roM3M2htVAKpRBOU0O6ANStjfoLt7tKJjE/x
X-Google-Smtp-Source: ABdhPJwtUFazG8LK2j2uIUvC3KDBMSMGv7P4Mk62sQaqerEAdArvm5fwPzeekbCvnNfNjiOCcnlt9A==
X-Received: by 2002:aed:21da:: with SMTP id m26mr54373965qtc.197.1594413183063;
        Fri, 10 Jul 2020 13:33:03 -0700 (PDT)
Received: from [10.0.2.15] ([12.18.222.50])
        by smtp.gmail.com with ESMTPSA id i28sm8949447qkh.1.2020.07.10.13.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 13:33:02 -0700 (PDT)
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
From:   Matthew Howell <mrhowel@g.clemson.edu>
Subject: [PATCH v2] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <156b27a1-82c5-090e-0ae8-86944b849d6d@g.clemson.edu>
Date:   Fri, 10 Jul 2020 16:33:00 -0400
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


From: Matthew Howell <mrhowel@g.clemson.edu>

Sealevel XR17V35X based devices are inoperable on kernel versions
4.11 and above due to a change in the GPIO preconfiguration introduced in commit
7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
cards to the value (0x00) used prior to commit 7dea8165f1d

Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
Signed-off-by: Matthew Howell <mrhowel@g.clemson.edu>
---

This is a revised patch submission based on comments received on
the previous submission.
See https://www.spinics.net/lists/linux-serial/msg39348.html

I am using a different email address to address the email footer issue,
and I have attempted to fix the formatting issues.

Summary/justification of the patch is below.

With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
XR17V35X based devices become stuck in high impedance mode, regardless of
dip-switch or software configuration. This causes the device to become
effectively unusable. This patch (in various forms) has been distributed
to our customers and no issues related to it have been reported.

Let me know if any changes need to be made.

--- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
+++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891627 -0400
@@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
      * devices will export them as GPIOs, so we pre-configure them safely
      * as inputs.
      */
-    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+    u8 dir = (pcidev->vendor == PCI_VENDOR_ID_EXAR && pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;

     writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
     writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);

