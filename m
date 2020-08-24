Return-Path: <SRS0=CzRg=CC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9B7C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FBC20656
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukP8rVh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXWjy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHXWjw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Aug 2020 18:39:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92223C061574;
        Mon, 24 Aug 2020 15:39:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o4so6677166wrn.0;
        Mon, 24 Aug 2020 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veDlCj1mRvlq894HMajCnLwZsVgcyp2TdyeeYxDWxWI=;
        b=ukP8rVh/8Wl85GQXPx53mIkgQXWfOt+Tx0U0AEYKTVLY56vrS/LW9OUcS+xD+djqXs
         Z9lYRd0XW9w8PFNCKguL7mtS5h/cWDYX/zmdgV75DV3RxnCe/U91AC6R4fPj07ZtnvZe
         AvVsMqG2Eb6Jws0XK6TFUJHGMCAS5odttzXRJGgISx6dD26OhujVyDc8cuQOb6BtblDv
         x9U0cIZSgggu1WtscMOyhhBM+jXmobjtwtAhD8QzX5Rd7EEsX0ANoBz1yBlBfcqvlkVd
         +lHXhLf0FD8GWdeWhTVqIjbtKRJyHnD0trTZnUT8h1X24EII/CFYQlxrDsYBmthorn72
         ILsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veDlCj1mRvlq894HMajCnLwZsVgcyp2TdyeeYxDWxWI=;
        b=uOQ6G+SuftyCdMISVEcjwmqECW5hdplFenPuujuIGU3jWRB7VXfgMXWFBUXYpDjtg5
         tWce9iwqj/uP0toaWQKk1L7vAYNgp5pymcgo+7CuA6UZM4N7Dp/FN5XfkO484yI8CujP
         oha2LJwrux8LeS44TYdRA0q152Q22CskK9Tw7Bvz+dfr/TdRf1K9WCoGU/Hdp8Vrou1z
         QvAnux7MB+mI1LV6YI3AL98P6uCW3eRtiV78UPM65DAZSByO1y2zXDyVpK9uxg6V6EfN
         CiOkmodyMyZOSzI4Jf25g30a5qOCDUXgg5ypqX0Boh1/k9XYJjtg3GdN1E0sLWE6PLVP
         cTEw==
X-Gm-Message-State: AOAM533vzq8U2GYx9eWVZoSjBvA4QksG+YSCfJJvLPwUYsNgbinlb/OG
        ixxGhLtQDoaoP+DoxZqTGF9bXeV8e0cUuG8p
X-Google-Smtp-Source: ABdhPJzGhRk6d9k/sVZlQHxDOV8xIJNuHeDcSTLVgVTzDmG78GAy9LKlSNXGL4cfqzdg/i93gBxgzA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr7579809wrx.257.1598308791027;
        Mon, 24 Aug 2020 15:39:51 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id y26sm1852266wmj.23.2020.08.24.15.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:39:50 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: don't use snprintf() for formatting sysfs attrs
Date:   Mon, 24 Aug 2020 23:39:33 +0100
Message-Id: <20200824223932.27709-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As per the documentation (Documentation/filesystems/sysfs.rst),
snprintf() should not be used for formatting values returned by sysfs.

For all of the instances in serial_core.c, we know that the string will
be <PAGE_SIZE in length, so just use sprintf().

Issue identified by Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/tty/serial/serial_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f797c971cd82f..4d313385cb2a7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2637,7 +2637,7 @@ static ssize_t uartclk_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.baud_base * 16);
+	return sprintf(buf, "%d\n", tmp.baud_base * 16);
 }
 
 static ssize_t type_show(struct device *dev,
@@ -2647,7 +2647,7 @@ static ssize_t type_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.type);
+	return sprintf(buf, "%d\n", tmp.type);
 }
 
 static ssize_t line_show(struct device *dev,
@@ -2657,7 +2657,7 @@ static ssize_t line_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.line);
+	return sprintf(buf, "%d\n", tmp.line);
 }
 
 static ssize_t port_show(struct device *dev,
@@ -2671,7 +2671,7 @@ static ssize_t port_show(struct device *dev,
 	ioaddr = tmp.port;
 	if (HIGH_BITS_OFFSET)
 		ioaddr |= (unsigned long)tmp.port_high << HIGH_BITS_OFFSET;
-	return snprintf(buf, PAGE_SIZE, "0x%lX\n", ioaddr);
+	return sprintf(buf, "0x%lX\n", ioaddr);
 }
 
 static ssize_t irq_show(struct device *dev,
@@ -2681,7 +2681,7 @@ static ssize_t irq_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.irq);
+	return sprintf(buf, "%d\n", tmp.irq);
 }
 
 static ssize_t flags_show(struct device *dev,
@@ -2691,7 +2691,7 @@ static ssize_t flags_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "0x%X\n", tmp.flags);
+	return sprintf(buf, "0x%X\n", tmp.flags);
 }
 
 static ssize_t xmit_fifo_size_show(struct device *dev,
@@ -2701,7 +2701,7 @@ static ssize_t xmit_fifo_size_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.xmit_fifo_size);
+	return sprintf(buf, "%d\n", tmp.xmit_fifo_size);
 }
 
 static ssize_t close_delay_show(struct device *dev,
@@ -2711,7 +2711,7 @@ static ssize_t close_delay_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.close_delay);
+	return sprintf(buf, "%d\n", tmp.close_delay);
 }
 
 static ssize_t closing_wait_show(struct device *dev,
@@ -2721,7 +2721,7 @@ static ssize_t closing_wait_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.closing_wait);
+	return sprintf(buf, "%d\n", tmp.closing_wait);
 }
 
 static ssize_t custom_divisor_show(struct device *dev,
@@ -2731,7 +2731,7 @@ static ssize_t custom_divisor_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.custom_divisor);
+	return sprintf(buf, "%d\n", tmp.custom_divisor);
 }
 
 static ssize_t io_type_show(struct device *dev,
@@ -2741,7 +2741,7 @@ static ssize_t io_type_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.io_type);
+	return sprintf(buf, "%d\n", tmp.io_type);
 }
 
 static ssize_t iomem_base_show(struct device *dev,
@@ -2751,7 +2751,7 @@ static ssize_t iomem_base_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)tmp.iomem_base);
+	return sprintf(buf, "0x%lX\n", (unsigned long)tmp.iomem_base);
 }
 
 static ssize_t iomem_reg_shift_show(struct device *dev,
@@ -2761,7 +2761,7 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
+	return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
 }
 
 static ssize_t console_show(struct device *dev,
-- 
2.28.0

