Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27360C2B9F4
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 07:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013AD6141F
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 07:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhF1HVx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HVw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Jun 2021 03:21:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF10C061574;
        Mon, 28 Jun 2021 00:19:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so26510983qkd.2;
        Mon, 28 Jun 2021 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f7Ot5LmHXi7VpG2BSEj4RHIyzwV7fgDXK6MRtvKTViQ=;
        b=sfQIYYTx2Yx5PlcLhW3Gy2088xDki7HijwwPxAcIs+NyQaTX2HWhK8pAHu2mxD+pca
         yx+NKPap00Q73rrZ+7km/K1mrraCLhLDabq6Bs9oj9X7C2XX4YwuoRm0VQEU2HyBorvQ
         e9lepaiSMqqGQMWqYkulVizLclWqtlA9a0Hxq+4FeIgMaqkYiIATEJ0ieFgbejugX7sJ
         QPHYyIoSDy38LVtSO7Vptd1Ezt1+gSc+5vkdmhYCm/6cuO7cbzf9ehIUvyXkdu+5kan4
         QNT006ryk4HNyP56CRqKRIoAt+AKZgor6T0WShKu8UuzPQHSblupLjVD4PiqtSjcnmCl
         J9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f7Ot5LmHXi7VpG2BSEj4RHIyzwV7fgDXK6MRtvKTViQ=;
        b=LJhS8B+lgHPHEBcYWlqcRfy/jweh7iXc2QZUDB1ncWFCyB3wT9U3ZkYB9mY66PLY8N
         7DA83ow2/4QCywZCOd1s5yQ4sPxZIAtKoJjCIprebZi/hNz1SdLbnO5ymUyXHd9NWBa5
         kugDVXdONfMj4zF8zrMacchTcpq4q1mVtSTsRDiU8slalN2Lp39Bw3C0T/kOhmw911N8
         +XGml+jlPqZeKz6C6CuHxXRfOoDZjrt8jqa4xs6Q08GE5uqvdFuf5IhWwznbkQk/Kqqt
         iYRiw/QuUoUzWYlV16Jj7eJcjSzk1pLhE7f0DDAOt8cGaqloehkxTy6hKwdsjPeD+gj4
         +6zQ==
X-Gm-Message-State: AOAM53013P1MW5+FBr4mTmt4lDlvdDJJj635EVD+06hFs6tEsqZPYLTP
        gDn+QGJF+oAoFxqdn+PbsPnKV8BpIjELwjDpAxQ=
X-Google-Smtp-Source: ABdhPJz7jM3BtHVKENllO4rl6/AidE96dr0/SyPc78+v9VbfVlXemuu8EJNVpvz+P5Jjj0wrvVmkI95RgW12VBp+MOM=
X-Received: by 2002:a37:4197:: with SMTP id o145mr24085085qka.75.1624864764584;
 Mon, 28 Jun 2021 00:19:24 -0700 (PDT)
MIME-Version: 1.0
From:   bing fan <hptsfb@gmail.com>
Date:   Mon, 28 Jun 2021 15:19:13 +0800
Message-ID: <CADVmyHWOVRNfVaJMm9D9KsFsi+t5cDwYtHcA9wn=v_Jh1QK-Rw@mail.gmail.com>
Subject: [PATCH] arm pl011 serial: support multi-irq request
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bing Fan <tombinfan@tencent.com>

In order to make pl011 work better, multiple interrupts are
required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
at the same time, pl011 to GIC does not merge the interrupt
lines(each serial-interrupt corresponding to different GIC hardware
interrupt), so need to enable and request multiple gic interrupt
numbers in the driver.

Signed-off-by: Bing Fan <hptsfb@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 78682c12156a..2b6f43c27dea 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1703,9 +1703,30 @@ static void pl011_write_lcr_h(struct
uart_amba_port *uap, unsigned int lcr_h)

 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
+       int ret = -1;
+       int i = 0;
+       unsigned int virq = 0;
+       struct amba_device *amba_dev = (struct amba_device *)uap->port.dev;
+
+       if (!amba_dev)
+               return -1;
+
        pl011_write(uap->im, uap, REG_IMSC);

-       return request_irq(uap->port.irq, pl011_int, IRQF_SHARED,
"uart-pl011", uap);
+       for (i = 0; i < AMBA_NR_IRQS; i++) {
+               virq = amba_dev->irq[i];
+               if (virq == 0)          // request irq until virq is 0
+                       break;
+
+               ret = request_irq(virq, pl011_int, IRQF_SHARED,
"uart-pl011-*", uap);
+               if (ret < 0) {
+                       dev_info(uap->port.dev, "%s %d request %u
interrupt failed\n",
+                                       __func__, __LINE__, virq);
+                       break;
+               }
+       }
+
+       return ret;
 }

 /*
-- 
2.17.1
