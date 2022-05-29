Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F7C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 29 May 2022 13:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiE2NqZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 May 2022 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiE2NqY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 May 2022 09:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD68939F8
        for <linux-serial@vger.kernel.org>; Sun, 29 May 2022 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653831981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+x+7esITuEjTahDQpOkrlpvxyvUZTU5N43BUwJS8j6w=;
        b=QRiJhINSlBCRaylGlwCO5VrJnaM3I72lKxymUpLr9q3WlD11ENaxPaYfDMUcttQ9zN8cJW
        4NaRT4e3NJmfPP8srXtC93LxhIRp0ACw8TWTnbKIPqbr3CFDm8iC+QoKf4VDv8BWUjUA0F
        J+d3kLoNRYGR5dFBjfvA89Pz9nPH6a0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-29zxAVpUMzKDMrWlTP13_w-1; Sun, 29 May 2022 09:46:20 -0400
X-MC-Unique: 29zxAVpUMzKDMrWlTP13_w-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-f1ca0bd7d7so5592651fac.22
        for <linux-serial@vger.kernel.org>; Sun, 29 May 2022 06:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+x+7esITuEjTahDQpOkrlpvxyvUZTU5N43BUwJS8j6w=;
        b=ySrfg6H/9NLcKdVq0STyecE41vq82ZrCHb50ApzpEHO8M3AF9l7IafJ2WQ9QB9FGaN
         x+w0xbSwcSYiZhWFBzrjfZwE3W2KXPhVYxmlW9lIQbsgTPE/Jo84PI1vPURU1mXJ3gkb
         kVaKneiXC4UfIgdVeOOfBgRqJPvP40y+WqMw/6f4938gJgXr+okppm6VDstsSObUTmaF
         XjEF54/5EBncS0w2C2dHowt4uyXd7k1GgdQzl+B85NbGI6Iwj7pHU1uSTO+tHoHdXgxZ
         VGV8O7pAKEbBeLyxaxc6jiUfmkjsnC3/df/h6zXkUZpOV/Tm2Oow0s/0z/V4chwq1eT3
         aUag==
X-Gm-Message-State: AOAM533CNWBpHGVmFKwO2HQlwdTpmSEFGvruqty8u/+aF9iP9yOLmM63
        2xQuNFb5VYt2bYOdPiBXtty8L+nONfacgIu4ycB03vQH1nLurqCyIxW/UDRWvLjITAcIYvHgqvK
        anC/oSlZnJ/lZ9/G0kYBv2kFJ
X-Received: by 2002:a05:6870:589a:b0:f2:fafb:3268 with SMTP id be26-20020a056870589a00b000f2fafb3268mr5161983oab.68.1653831979890;
        Sun, 29 May 2022 06:46:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy/4vZkdiw3Eo74fnOSNE+IkU85kNV9iYWClrYLk9dLPusPYefeXXCYc65O67WxYVv9jkq2A==
X-Received: by 2002:a05:6870:589a:b0:f2:fafb:3268 with SMTP id be26-20020a056870589a00b000f2fafb3268mr5161978oab.68.1653831979679;
        Sun, 29 May 2022 06:46:19 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y13-20020a9d714d000000b0060aea5bbc87sm3958874otj.18.2022.05.29.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 06:46:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        peter@hurleysoftware.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: core: check if uart_get_info succeeds before using
Date:   Sun, 29 May 2022 09:46:05 -0400
Message-Id: <20220529134605.12881-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

clang static analysis reports this representative issue
drivers/tty/serial/serial_core.c:2818:9: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
        return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

uart_get_info() is used the *show() functions.  When uart_get_info() fails, what is reported
is garbage.  So check if uart_get_info() succeeded.

Fixes: 4047b37122d1 ("serial: core: Prevent unsafe uart port access, part 1")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a85b41caa0a..4160f6711c5d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2690,7 +2690,9 @@ static ssize_t uartclk_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.baud_base * 16);
 }
 
@@ -2700,7 +2702,9 @@ static ssize_t type_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.type);
 }
 
@@ -2710,7 +2714,9 @@ static ssize_t line_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.line);
 }
 
@@ -2721,7 +2727,9 @@ static ssize_t port_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 	unsigned long ioaddr;
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	ioaddr = tmp.port;
 	if (HIGH_BITS_OFFSET)
 		ioaddr |= (unsigned long)tmp.port_high << HIGH_BITS_OFFSET;
@@ -2734,7 +2742,9 @@ static ssize_t irq_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.irq);
 }
 
@@ -2744,7 +2754,9 @@ static ssize_t flags_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "0x%X\n", tmp.flags);
 }
 
@@ -2754,7 +2766,9 @@ static ssize_t xmit_fifo_size_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.xmit_fifo_size);
 }
 
@@ -2764,7 +2778,9 @@ static ssize_t close_delay_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.close_delay);
 }
 
@@ -2774,7 +2790,9 @@ static ssize_t closing_wait_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.closing_wait);
 }
 
@@ -2784,7 +2802,9 @@ static ssize_t custom_divisor_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.custom_divisor);
 }
 
@@ -2794,7 +2814,9 @@ static ssize_t io_type_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.io_type);
 }
 
@@ -2804,7 +2826,9 @@ static ssize_t iomem_base_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "0x%lX\n", (unsigned long)tmp.iomem_base);
 }
 
@@ -2814,7 +2838,9 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
 	struct serial_struct tmp;
 	struct tty_port *port = dev_get_drvdata(dev);
 
-	uart_get_info(port, &tmp);
+	if (uart_get_info(port, &tmp))
+		return 0;
+
 	return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
 }
 
-- 
2.27.0

